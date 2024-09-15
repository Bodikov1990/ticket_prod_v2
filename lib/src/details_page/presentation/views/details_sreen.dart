// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:ticket_prod_v2/core/viewmodels/theme_view_model.dart';
import 'package:ticket_prod_v2/generated/l10n.dart';

import 'package:ticket_prod_v2/src/details_page/presentation/bloc/details_bloc.dart';
import 'package:ticket_prod_v2/src/details_page/presentation/bloc/seat_list_bloc.dart';
import 'package:ticket_prod_v2/src/details_page/presentation/views/seat_list_widget.dart';
import 'package:ticket_prod_v2/src/details_page/presentation/views/ticket_info_widget.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/order_entity.dart';

@RoutePage()
class DetailsScreen extends StatefulWidget {
  final OrderEntity ticket;
  final void Function(bool) onTapActivate;

  const DetailsScreen({
    super.key,
    required this.ticket,
    required this.onTapActivate,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final Color _scaffoldColor = Colors.white;
  final Color _newTicketColor = const Color.fromARGB(255, 105, 225, 197);
  final Color _usedTicketColor = const Color.fromARGB(251, 247, 240, 172);

  String? id = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailsBloc>(context)
        .add(DetailsCheckTicketStatusEvent(ticketEntity: widget.ticket));
  }

  void _activateSeats() {
    if (id != null) {
      GetIt.I<Talker>().debug('--- Tapped ACTIVATE button');
      BlocProvider.of<SeatListBloc>(context)
          .add(SeatActivateEvent(ticketID: id ?? ''));
    }
  }

  void _clearSeatsEvent() {
    BlocProvider.of<SeatListBloc>(context).add(SeatClearEvent());
  }

  @override
  Widget build(BuildContext contextMain) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _clearSeatsEvent();
        }
      },
      child: BlocListener<DetailsBloc, DetailsState>(
        listener: (listenerContext, state) {
          if (state is DetailsTicketStatusActivated) {
            GetIt.I<Talker>().debug('--- SEATS ALREADY ACTIVATED');
            _seatFilterEvent();
            _showAlert(
              contextMain: contextMain,
              title: state.alertTitle,
              content: state.alertMessage,
              onOkPressed: () {
                widget.onTapActivate(true);
              },
            );
          } else if (state is DetailsTicketStatusNew) {
            _seatFilterEvent();
          }
        },
        child: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (builderContext, state) {
            Color backgroundColor = _scaffoldColor;

            if (state is DetailsTicketStatusNew) {
              backgroundColor = _newTicketColor;
              id = state.ticketEntity.id;
            } else if (state is DetailsTicketStatusActivated) {
              backgroundColor = _usedTicketColor;
            }

            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(CupertinoIcons.back),
                  onPressed: () {
                    _clearSeatsEvent();
                    AutoRouter.of(context).maybePop(true);
                  },
                ),
                title: Text(
                  S.current.ticket_details,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              backgroundColor: backgroundColor,
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildTicketInfoWidgets(state),
                  ),
                ),
              ),
              floatingActionButton: BlocListener<SeatListBloc, SeatListState>(
                  listener: (context, state) {
                    if (state is SeatActivateErrorState) {
                      GetIt.I<Talker>().debug('--- Seats activated: ERROR');
                      _showAlert(
                        contextMain: contextMain,
                        title: state.title,
                        content: state.message,
                        onOkPressed: () {
                          widget.onTapActivate(true);

                          AutoRouter.of(contextMain).popUntilRoot();
                        },
                      );
                    } else if (state is SeatActivatedState) {
                      GetIt.I<Talker>().debug('--- Seats activated: SUCCESS');
                      _showAlert(
                        contextMain: contextMain,
                        title: state.title,
                        content: state.message,
                        onOkPressed: () {
                          widget.onTapActivate(true);

                          AutoRouter.of(contextMain).popUntilRoot();
                        },
                      );
                    }
                  },
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(ThemeViewModel().mainBlue),
                        foregroundColor:
                            const WidgetStatePropertyAll(Colors.white)),
                    onPressed: () {
                      if (widget.ticket.status == 3) {
                        GetIt.I<Talker>().debug(
                            '--- Ticket already activated, ticket status ${widget.ticket.status}');
                        _clearSeatsEvent();
                        widget.onTapActivate(true);
                        AutoRouter.of(context).popUntilRoot();
                      } else {
                        _activateSeats();
                      }
                    },
                    child: Text(widget.ticket.status == 3
                        ? S.current.back
                        : S.current.activate),
                  )),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildTicketInfoWidgets(DetailsState state) {
    String? ticketStatus;
    String? movieName;
    String? hallName;
    String? startTime;
    String? seats;

    if (state is DetailsTicketStatusActivated) {
      ticketStatus = state.ticketStatus;
      movieName = state.movieName;
      hallName = state.hallName;
      startTime = state.startTime;
      seats = state.seats;
    } else if (state is DetailsTicketStatusNew) {
      ticketStatus = state.ticketStatus;
      movieName = state.movieName;
      hallName = state.hallName;
      startTime = state.startTime;
      seats = state.seats;
    }
    return [
      _borderBuild(
          ticketStatus ?? '',
          TicketInfoWidget(
            label: S.current.status,
            value: ticketStatus,
          )),
      const SizedBox(
        height: 10,
      ),
      _borderBuild(
          ticketStatus ?? '',
          TicketInfoWidget(
            label: S.current.movie,
            value: movieName,
          )),
      const SizedBox(
        height: 10,
      ),
      _borderBuild(
          ticketStatus ?? '',
          TicketInfoWidget(
            label: S.current.hall,
            value: hallName,
          )),
      const SizedBox(
        height: 10,
      ),
      _borderBuild(
          ticketStatus ?? '',
          TicketInfoWidget(
            label: S.current.start_time,
            value: startTime,
          )),
      const SizedBox(
        height: 10,
      ),
      _borderBuild(ticketStatus ?? '',
          TicketInfoWidget(label: S.current.seats, value: seats)),
      const SizedBox(
        height: 10,
      ),
      Container(
          width: MediaQuery.of(context).size.width - 16,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(4)),
          child: SeatListWidget(
            ticket: widget.ticket,
          )),
      const SizedBox(
        height: 56,
      ),
    ];
  }

  void _seatFilterEvent() {
    GetIt.I<Talker>()
        .debug("---  _seatFilterEvent ${widget.ticket.seats?.length}");
    BlocProvider.of<SeatListBloc>(context)
        .add(SeatFilterEvent(seats: widget.ticket.seats ?? []));
  }

  Container _borderBuild(String ticketStatus, Widget? child) {
    return Container(
      width: MediaQuery.of(context).size.width - 16,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: child,
    );
  }

  _showAlert({
    required BuildContext contextMain,
    String? title,
    String? content,
    VoidCallback? onOkPressed,
  }) {
    final content0 = content ?? '';
    showDialog(
      context: contextMain,
      builder: (context) => AlertDialog(
        title: title != null
            ? Text(title, style: const TextStyle(fontWeight: FontWeight.w600))
            : null,
        content: Text(content0),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              AutoRouter.of(context).maybePop();
              if (onOkPressed != null) {
                onOkPressed();
              }
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
