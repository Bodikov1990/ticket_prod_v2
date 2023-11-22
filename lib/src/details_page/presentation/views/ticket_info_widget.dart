import 'package:flutter/material.dart';

class TicketInfoWidget extends StatelessWidget {
  final String label;
  final String? value;

  const TicketInfoWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value ?? '',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
