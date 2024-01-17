import 'package:flutter/material.dart';

class SeancesListTile extends StatefulWidget {
  final String startTime;
  final String movie;
  final String endTime;
  final String hall;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isExistBuy;

  const SeancesListTile({
    super.key,
    required this.startTime,
    required this.movie,
    required this.endTime,
    required this.hall,
    this.backgroundColor,
    this.textColor,
    required this.isExistBuy,
  });

  @override
  State<SeancesListTile> createState() => _SeancesListTileState();
}

class _SeancesListTileState extends State<SeancesListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.backgroundColor ?? Colors.white,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _buildTimeColumn(widget.startTime, widget.hall),
            _buildMovieTitle(widget.movie),
            _buildEndTimeAndIcon(widget.endTime, widget.isExistBuy),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeColumn(String startTime, String hall) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            startTime,
            style: TextStyle(
                color: widget.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            hall,
            style: TextStyle(color: widget.textColor, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieTitle(String movie) {
    return Expanded(
      child: Text(
        movie,
        style: TextStyle(
            color: widget.textColor, fontSize: 20, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildEndTimeAndIcon(String endTime, bool isExistBuy) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            endTime,
            style: TextStyle(
                color: widget.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          if (isExistBuy)
            const Icon(Icons.check_circle, color: Colors.green, size: 24),
        ],
      ),
    );
  }
}
