// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ticket_prod_v2/generated/l10n.dart';
import 'package:ticket_prod_v2/src/details_page/presentation/bloc/details_bloc.dart';
import 'package:ticket_prod_v2/src/details_page/presentation/bloc/seat_list_bloc.dart';

import 'package:ticket_prod_v2/src/main_page/domain/entities/ticket_entity.dart';

class SeatListWidget extends StatelessWidget {
  final TicketEntity ticket;

  const SeatListWidget({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: BlocListener<SeatListBloc, SeatListState>(
      listener: (context, state) {
        if (state is SeatActivateErrorState) {
          BlocProvider.of<DetailsBloc>(context)
              .add(DetailsCheckTicketStatusEvent(ticketEntity: ticket));
        } else if (state is SeatActivatedState) {
          // _showAlert(
          //     context: context, title: state.title, content: state.message);
        }
      },
      child: BlocBuilder<SeatListBloc, SeatListState>(
        builder: (context, state) {
          if (state is SeatFilteredState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  "${S.current.in_the_hall}: ${state.activatedSeats.length}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  ticket.status == 3 ? "" : S.current.tickets,
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                                  BlocProvider.of<SeatListBloc>(context).add(
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
                                  BlocProvider.of<SeatListBloc>(context).add(
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
                          '${S.current.tickets_count}: ${state.allMapSeats[entry.key]?.length}'),
                      const SizedBox(height: 8.0),
                    ],
                  ),
              ],
            );
          } else if (state is SeatListActivatingState) {
            return Center(
              child: Column(
                children: [
                  Text(
                    S.current.seats_activating,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const CircularProgressIndicator(),
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
