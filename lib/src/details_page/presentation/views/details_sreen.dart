// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ticket_prod_v2/src/details_page/presentation/bloc/details_bloc.dart';
import 'package:ticket_prod_v2/src/details_page/presentation/bloc/seat_list_bloc.dart';
import 'package:ticket_prod_v2/src/details_page/presentation/views/seat_list_widget.dart';
import 'package:ticket_prod_v2/src/details_page/presentation/views/ticket_info_widget.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/seat_entity.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/ticket_entity.dart';

@RoutePage()
class DetailsScreen extends StatefulWidget {
  final TicketEntity ticket;
  final void Function(bool) onTapOk;

  const DetailsScreen({
    Key? key,
    required this.ticket,
    required this.onTapOk,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _detailsBloc = DetailsBloc();
  final _seatListBloc = SeatListBloc();

  Color scaffoldColor = Colors.white;
  Color newTicketColor = const Color.fromARGB(255, 105, 225, 197);
  Color usedTicketColor = const Color.fromARGB(251, 247, 240, 172);

  String? id = '';

  @override
  void initState() {
    super.initState();
    _detailsBloc
        .add(DetailsCheckTicketStatusEvent(ticketEntity: widget.ticket));
  }

  void _activateSeats() {
    if (id != null) {
      _seatListBloc.add(SeatActivateEvent(ticketID: id ?? ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailsBloc, DetailsState>(
      bloc: _detailsBloc,
      listener: (context, state) {
        if (state is DetailsTicketStatusError) {
          _showAlert(
              context: context, title: state.title, content: state.message);
        }
      },
      child: BlocBuilder<DetailsBloc, DetailsState>(
        bloc: _detailsBloc,
        builder: (context, state) {
          Color backgroundColor = scaffoldColor;

          if (state is DetailsTicketStatusNew) {
            backgroundColor = newTicketColor;
            id = state.ticketEntity.id;
          } else if (state is DetailsTicketStatusActivated) {
            backgroundColor = usedTicketColor;
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text("Детали билета"),
            ),
            backgroundColor: backgroundColor,
            body: _buildBodyBasedOnState(state),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                widget.onTapOk(true);
                _activateSeats();
                context.popRoute();
              },
              child: const Text('OK'),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBodyBasedOnState(DetailsState state) {
    if (state is DetailsTicketStatusNew ||
        state is DetailsTicketStatusActivated) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildTicketInfoWidgets(state),
          ),
        ),
      );
    } else {
      return const Center(
        child: Text('Загрузка данных или сообщение об ошибке'),
      );
    }
  }

  List<Widget> _buildTicketInfoWidgets(DetailsState state) {
    String ticketStatus = '';
    String movieName = '';
    String hallName = '';
    String startTime = '';
    String seats = '';

    List<SeatEntity>? seatsList = [];
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
      seatsList = state.ticketEntity.seats;
    }
    return [
      borderBuild(
          ticketStatus,
          TicketInfoWidget(
            label: "Статус",
            value: ticketStatus,
          )),
      const SizedBox(
        height: 10,
      ),
      borderBuild(
          ticketStatus,
          TicketInfoWidget(
            label: 'Фильм',
            value: movieName,
          )),
      const SizedBox(
        height: 10,
      ),
      borderBuild(
          ticketStatus,
          TicketInfoWidget(
            label: 'Зал',
            value: hallName,
          )),
      const SizedBox(
        height: 10,
      ),
      borderBuild(
          ticketStatus,
          TicketInfoWidget(
            label: 'Начало сеанса',
            value: startTime,
          )),
      const SizedBox(
        height: 10,
      ),
      borderBuild(ticketStatus, TicketInfoWidget(label: 'Места', value: seats)),
      Container(
          width: MediaQuery.of(context).size.width - 16,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(4)),
          child: SeatListWidget(seats: seatsList, seatListBloc: _seatListBloc))
    ];
  }

  Container borderBuild(String ticketStatus, Widget? child) {
    return Container(
      width: MediaQuery.of(context).size.width - 16,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: child,
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
