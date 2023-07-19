import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'dart:math' as math;
import '../Utils/colors.dart';

class CustomCircularStepper extends StatefulWidget {
  final List<String> instructions;
  int currentStep;
  final double radius;
  final double strokeWidth;
  final Color activeColor;
  final Color inactiveColor;

  CustomCircularStepper({
    @required this.instructions,
    this.currentStep = 0,
    this.radius = 50,
    this.strokeWidth = 5,
    this.activeColor = ColorSet.primaryColor,
    this.inactiveColor = Colors.grey,
  });

  @override
  _CustomCircularStepperState createState() => _CustomCircularStepperState();

  bool get isPreviousEnabled {
    return currentStep > 0;
  }

  bool get isNextEnabled {
    return currentStep < instructions.length - 1;
  }
}

class _CustomCircularStepperState extends State<CustomCircularStepper> {
  int _steps;

  @override
  void initState() {
    super.initState();
    _steps = widget.instructions.length;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double minSide =
            math.min(constraints.maxWidth, constraints.maxHeight);
        final double radius = widget.radius ?? minSide / 2 - widget.strokeWidth;
        final double maxWidth =
            constraints.maxWidth - 2 * (radius + widget.strokeWidth) - 20;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomPaint(
                      painter: _CustomCircularStepperPainter(
                        steps: _steps,
                        currentStep: widget.currentStep,
                        radius: widget.radius,
                        strokeWidth: widget.strokeWidth,
                        activeColor: widget.activeColor,
                        inactiveColor: widget.inactiveColor,
                      ),
                      size: Size.fromRadius(widget.radius),
                      child: Text(
                        '${widget.currentStep + 1} of $_steps',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: ExpandableText(
                          widget.instructions[widget.currentStep],
                          readMoreText: 'Read more',
                          readLessText: 'Read less',
                          style: Theme.of(context).textTheme.bodyMedium,
                          trim: 3,
                          linkTextStyle:
                              TextStyle(color: ColorSet.primaryColor),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
          ],
        );
      },
    );
  }
}

class _CustomCircularStepperPainter extends CustomPainter {
  final int steps;
  final int currentStep;
  final double radius;
  final double strokeWidth;
  final Color activeColor;
  final Color inactiveColor;

  _CustomCircularStepperPainter({
    this.steps,
    this.currentStep,
    this.radius,
    this.strokeWidth,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double angle = (2 * math.pi) / steps;

    final Paint activePaint = Paint()
      ..color = activeColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Paint inactivePaint = Paint()
      ..color = inactiveColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < steps; i++) {
      final bool isActive = i <= currentStep;

      final Paint paint = isActive ? activePaint : inactivePaint;

      final double startAngle =
          (math.pi / 2) - (steps * angle / 2) + (i * angle);
      final double sweepAngle = angle - 0.02;

      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_CustomCircularStepperPainter oldDelegate) {
    return oldDelegate.currentStep != currentStep;
  }
}
