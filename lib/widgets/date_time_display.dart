import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeDisplay extends StatelessWidget {
  const DateTimeDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    // Formats
    String formattedDate = DateFormat('EEE d MMMM y').format(now);
    String formattedTime = DateFormat('h:mm a').format(now);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$formattedDate , $formattedTime',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.blue),
        ),
      ],
    );
  }
}
