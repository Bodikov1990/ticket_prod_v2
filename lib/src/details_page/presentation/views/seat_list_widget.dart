// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ticket_prod_v2/src/details_page/presentation/bloc/seat_list_bloc.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/seat_entity.dart';

class SeatListWidget extends StatefulWidget {
  final List<SeatEntity>? seats;
  final SeatListBloc seatListBloc;

  const SeatListWidget({
    Key? key,
    required this.seats,
    required this.seatListBloc,
  }) : super(key: key);

  @override
  State<SeatListWidget> createState() => _SeatListWidgetState();
}

class _SeatListWidgetState extends State<SeatListWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.seats != null) {
      widget.seatListBloc.add(SeatFilterEvent(seats: widget.seats ?? []));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.seats == null || (widget.seats?.isEmpty ?? true)) {
      return Container();
    }

    return SingleChildScrollView(
        child: BlocListener<SeatListBloc, SeatListState>(
      bloc: widget.seatListBloc,
      listener: (context, state) {
        if (state is SeatActivateErrorState) {
          // _showAlert(
          //     context: context, title: state.title, content: state.message);
        } else if (state is SeatActivatedState) {
          // _showAlert(
          //     context: context, title: state.title, content: state.message);
        }
      },
      child: BlocBuilder<SeatListBloc, SeatListState>(
        bloc: widget.seatListBloc,
        builder: (context, state) {
          if (state is SeatFilteredState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  "Знаходяться в залі: ${state.activatedMapSeats.values.length}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Text(
                  "Квитки",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                for (final entry in state.soldMapSeats.entries)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: (() {
                                  widget.seatListBloc.add(
                                      SeatRemoveEvent(discountName: entry.key));
                                }),
                                child: const Icon(Icons.remove),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                '${state.soldMapSeats[entry.key]?.length ?? 0}',
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 8.0),
                              ElevatedButton(
                                onPressed: (() {
                                  widget.seatListBloc.add(
                                      SeatAddEvent(discountName: entry.key));
                                }),
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                          'Кількість квитків: ${state.allMapSeats[entry.key]?.length}'),
                      const SizedBox(height: 8.0),
                    ],
                  ),
              ],
            );
          } else if (state is SeatListActivatingState) {
            return const Center(
              child: Column(
                children: [
                  Text(
                    'Активація місць...',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    ));
  }
}
