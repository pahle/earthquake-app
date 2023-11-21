import 'package:flutter/material.dart';
import 'dart:math';

class RulerView extends StatefulWidget {
  final double size;
  final String? magnitude;

  const RulerView({Key? key, required this.size, required this.magnitude})
      : super(key: key);

  @override
  State<RulerView> createState() => _RulerViewState();
}

class _RulerViewState extends State<RulerView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(left: 0),
      width: widget.size,
      height: widget.size,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: RulerPainter(magnitude: double.parse(widget.magnitude ?? '0.0')),
        ),
      ),
    );
  }
}

class RulerPainter extends CustomPainter {
  final double magnitude;

  RulerPainter({required this.magnitude});

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var dashPointer = width / 10;
    var dashRuler = width / 20;
    var centerX = size.width / 2 + 100;

    var dashBrush = Paint()
      ..color = Colors.white
      ..strokeWidth = 30
      ..style = PaintingStyle.stroke;

    var magnitudeBrush = Paint()
      ..color = const Color.fromARGB(255, 255, 0, 0)
      ..strokeWidth = 50
      ..style = PaintingStyle.stroke;

    for (var i = 0; i <= width; i += dashRuler.toInt()) {
      canvas.drawLine(
        Offset(centerX, i.toDouble() - 1),
        Offset(centerX, i.toDouble() + 1),
        dashBrush,
      );
    }
    canvas.drawLine(
      Offset(centerX, dashPointer * magnitude - 2),
      Offset(centerX, dashPointer * magnitude + 2),
      magnitudeBrush,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
