// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names
import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ticket_prod_v2/generated/l10n.dart';

import 'package:ticket_prod_v2/src/repertoire_page/domain/entities/seance_info_model.dart';
import 'package:ticket_prod_v2/src/repertoire_page/presentation/bloc/repertoire_bloc.dart';
import 'package:ticket_prod_v2/src/repertoire_page/presentation/views/seances_list_tile.dart';
import 'package:ticket_prod_v2/src/repertoire_page/presentation/widgets/version_info_widget.dart';

enum WeekDay { TODAY, TOMORROW }

@RoutePage()
class RepertoireScreen extends StatefulWidget {
  final DateTime? date;
  const RepertoireScreen({
    Key? key,
    this.date,
  }) : super(key: key);

  @override
  State<RepertoireScreen> createState() => _RepertoireScreenState();
}

class _RepertoireScreenState extends State<RepertoireScreen> {
  WeekDay selectedDay = WeekDay.TODAY;

  @override
  void initState() {
    super.initState();
    _loadSeances();
  }

  void _loadSeances() {
    DateTime now = DateTime.now();
    DateTime targetDate;

    if (selectedDay == WeekDay.TOMORROW) {
      if (now.hour >= 0 && now.hour < 3) {
        targetDate = DateTime(now.year, now.month, now.day + 0, 7, 0, 0);
      } else {
        targetDate = DateTime(now.year, now.month, now.day + 1, 7, 0, 0);
      }
    } else {
      if (now.hour >= 0 && now.hour < 3) {
        targetDate = DateTime(now.year, now.month, now.day - 1, 23, 0, 0);
      } else {
        targetDate = DateTime(now.year, now.month, now.day, 7, 0, 0);
      }
    }

    BlocProvider.of<RepertoireBloc>(context)
        .add(RepertoireLoadingEvent(date: _formatDateTime(targetDate)));
  }

  String _formatDateTime(DateTime dateTime) {
    DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
    return formatter.format(dateTime);
  }

  Future<void> _refreshSeances() async {
    _loadSeances();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onDoubleTap: () {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: VersionInfoWidget(),
                    ));
          },
          child: Text(
            S.current.repertoire,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<RepertoireBloc, RepertoireState>(
        listener: (context, state) {
          if (state is RepertoireLoadedErrorState) {
            _showAlert(
                context: context,
                content: state.message,
                title: state.statusCode.toString());
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: CupertinoSlidingSegmentedControl<WeekDay>(
                        children: {
                          WeekDay.TODAY: SizedBox(
                              height: 40,
                              child: Center(
                                  child: Text(
                                S.current.today,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ))),
                          WeekDay.TOMORROW: SizedBox(
                              height: 40,
                              child: Center(
                                  child: Text(
                                S.current.tomorrow,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ))),
                        },
                        groupValue: selectedDay,
                        onValueChanged: (value) {
                          setState(() {
                            selectedDay = value!;
                            _loadSeances();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshSeances,
                child: BlocBuilder<RepertoireBloc, RepertoireState>(
                  builder: (context, state) {
                    if (state is RepertoireLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is RepertoireLoadedState) {
                      if (state.seances.isNotEmpty) {
                        return ListView.separated(
                            key: ValueKey(state.seances),
                            padding: const EdgeInsets.only(bottom: 16),
                            itemBuilder: (BuildContext context, int index) {
                              SeanceInfoModel seanceInfoModel =
                                  state.seances[index];
                              Color? backgroundColor;
                              Color? textColor;

                              if (seanceInfoModel.seanceStatus ==
                                  STATUS_STARTING_SOON) {
                                backgroundColor =
                                    const Color.fromARGB(255, 255, 230, 0);
                              } else if (seanceInfoModel.seanceStatus ==
                                  STATUS_IN_PROGRESS) {
                                backgroundColor =
                                    const Color.fromARGB(255, 215, 215, 215);
                                textColor =
                                    const Color.fromARGB(255, 109, 109, 109);
                              }
                              return SeancesListTile(
                                backgroundColor: backgroundColor,
                                textColor: textColor,
                                startTime: DateFormat('HH:mm')
                                    .format(seanceInfoModel.startTime),
                                movie: seanceInfoModel.movie,
                                endTime: DateFormat('HH:mm')
                                    .format(seanceInfoModel.endTime),
                                hall: seanceInfoModel.hallName,
                                isExistBuy: seanceInfoModel.isExistBuy,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                                      color: Color.fromARGB(255, 31, 44, 67),
                                    ),
                            itemCount: state.seances.length);
                      } else {
                        return Center(
                          child: Text(
                            S.current.empty_seance,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }
                    }

                    return Center(
                      child: Text(
                        S.current.empty_seance,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _showAlert({required BuildContext context, String? title, String? content}) {
    final content0 = content ?? '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title != null
            ? Text(title, style: const TextStyle(fontWeight: FontWeight.w600))
            : null,
        content: Text(content0),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              AutoRouter.of(context).pop();
            },
            child: const Text(
              'Ок',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
