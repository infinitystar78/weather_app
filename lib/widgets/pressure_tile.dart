import 'package:flutter/material.dart';

class PressureTile extends StatelessWidget {
  final int pressure;

  const PressureTile({Key? key, required this.pressure}) : super(key: key);

  double getPressurePercentage() {
    return (pressure - 980) / (1050 - 980);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circle
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              shape: BoxShape.circle,
            ),
          ),
          // "Low" label
          const Positioned(
            left: 0,
            child: Text(
              "Low",
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
          // "High" label
          const Positioned(
            right: -1,
            child: Text(
              "High",
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
          // Pressure indicator arrow
          Positioned(
            bottom: 100, // Adjusted positioning
            child: Transform.rotate(
              angle: getPressurePercentage() * 2 * 3.14 - 3.14,
              child: CustomPaint(
                painter: ArrowPainter(),
                child: Container(
                  height: 40, // Reduced height
                  width: 2.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Pressure value
          Text(
            "$pressure hPa",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    // Arrow head
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 5, 10), paint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 + 5, 10), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
