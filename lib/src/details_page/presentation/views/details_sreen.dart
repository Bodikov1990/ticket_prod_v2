import 'package:flutter/material.dart';
import 'package:ticket_prod_v2/src/main_page/domain/entities/ticket_entity.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  TicketEntity? ticket;

  Color scaffoldColor = Colors.white;
  Color newTicketColor = const Color.fromARGB(255, 105, 225, 197);
  Color usedTicketColor = const Color.fromARGB(255, 246, 229, 82);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
