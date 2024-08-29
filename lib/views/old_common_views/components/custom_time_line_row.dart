import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class LineStyle {
  const LineStyle({
    this.color = Colors.grey,
    this.thickness = 4,
  });

  /// The color used to paint the line. It defaults to ([Colors.grey]).
  final Color color;

  /// The thickness from the line. It can't be bigger than ([IndicatorStyle.width])
  /// and defaults to 4.
  final double thickness;
}

class CustomTimeLineTile extends StatelessWidget {
  const CustomTimeLineTile({
    super.key,
    this.startChild,
    this.endChild,
    this.isFirst = false,
    this.isLast = false,
    required this.isPast,
    this.beforeLineStyle = const LineStyle(),
    LineStyle? afterLineStyle,
  }) : afterLineStyle = afterLineStyle ?? beforeLineStyle;
  final LineStyle beforeLineStyle;

  /// The style used to customize the line rendered after the indicator.
  /// If null, it defaults to [beforeLineStyle].
  final LineStyle afterLineStyle;

  /// The child widget positioned at the start
  final Widget? startChild;

  /// The child widget positioned at the end
  final Widget? endChild;

  /// Whether this is the first tile from the timeline.
  /// In this case, it won't be rendered a line before the indicator.
  final bool isFirst;

  /// Whether this is the last tile from the timeline.
  /// In this case, it won't be rendered a line after the indicator.
  final bool isLast;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final children = <Widget>[
          SizedBox(
            width: 20,
            child: _Indicator(
              beforeLineStyle: beforeLineStyle,
              afterLineStyle: afterLineStyle,
              isCompleted: isPast,
              isLast: isLast,
              isFirst: isFirst,
            ),
          ),
        ];

        final defaultChild = Container(height: 100);
        children.add(Expanded(child: endChild ?? defaultChild));

        return IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: children,
          ),
        );
      },
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    required this.beforeLineStyle,
    required this.afterLineStyle,
    required this.isFirst,
    required this.isLast,
    required this.isCompleted,
  });

  /// See [CustomTimeLineTile.axis]

  /// See [CustomTimeLineTile.beforeLineStyle]
  final LineStyle beforeLineStyle;

  /// See [CustomTimeLineTile.afterLineStyle]
  final LineStyle afterLineStyle;

  /// See [CustomTimeLineTile.isFirst]
  final bool isFirst;

  /// See [CustomTimeLineTile.isLast]
  final bool isLast;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    double size;
    size = max(beforeLineStyle.thickness, afterLineStyle.thickness);
    final childrenStack = <Widget>[
      SizedBox(
        height: double.infinity,
        width: size,
      )
    ];

    final painter = _TimelinePainter(
      beforeLineStyle: beforeLineStyle,
      afterLineStyle: afterLineStyle,
      isFirst: isFirst,
      isCompleted: isCompleted,
      isLast: isLast,
    );

    return CustomPaint(
      painter: painter,
      child: Stack(
        children: childrenStack,
      ),
    );
  }
}

/// A custom painter that renders a line and an indicator
class _TimelinePainter extends CustomPainter {
  _TimelinePainter({
    this.isFirst = false,
    this.isLast = false,
    this.isCompleted = false,
    required LineStyle beforeLineStyle,
    required LineStyle afterLineStyle,
  })  : beforeLinePaint = Paint()
          ..color = beforeLineStyle.color
          ..strokeWidth = beforeLineStyle.thickness,
        afterLinePaint = Paint()
          ..color = afterLineStyle.color
          ..strokeWidth = afterLineStyle.thickness;

  /// Used to paint the top line
  final Paint beforeLinePaint;

  /// Used to paint the bottom line
  final Paint afterLinePaint;

  /// Whether this paint should start the line somewhere in the middle,
  /// according to [indicatorY]. It defaults to false.
  final bool isFirst;

  /// Whether this paint should end the line somewhere in the middle,
  /// according to [indicatorY]. It defaults to false.
  final bool isLast;
  final bool isCompleted;

  @override
  void paint(Canvas canvas, Size size) {
    final centerAxis = size.width / 2;
    final position = calculateAxisPositioning(
      totalSize: size.height,
      objectSize: 0,
      axisPosition: 0.6,
    );
    if (!isCompleted) {
      beforeLinePaint.color = beforeLinePaint.color.withOpacity(.4);
    }

    if (!isLast) {
      _drawLine(size, canvas, centerAxis, position);
      // if (isCompleted) {

      // } else {
      //   _drawDashedLine(size, canvas, centerAxis, position);
      // }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawLine(
      Size size, Canvas canvas, double centerAxis, AxisPosition position) {
    const double radius = 15.0; // Radius of the curve
    final Path path = Path();
    beforeLinePaint
      ..style = PaintingStyle.stroke // Stroke painting style for border
      ..strokeWidth = 2.0;
    const double dashWidth = 5.0; // Width of each dash
    const double dashSpace = 3.0; // Space between each dash

    path.moveTo(size.width, position.secondSpace.start - radius);
    path.arcToPoint(
      Offset(size.width - radius, position.secondSpace.start),
      radius: const Radius.circular(radius),
      clockwise: false,
    );
    path.moveTo(size.width - radius, position.secondSpace.start);
    // Draw a straight line downwards
    final lineSize = position.secondSpace.end +
        position.secondSpace.start -
        (position.secondSpace.size);
    path.lineTo(size.width - radius, lineSize);

    path.arcToPoint(
      Offset(size.width, lineSize + radius),
      radius: const Radius.circular(radius),
      clockwise: false,
    );
    // Compute the metrics once
    if (!isCompleted) {
      for (PathMetric pathMetric in path.computeMetrics()) {
        double totalLength = pathMetric.length;
        for (double i = 0; i < totalLength; i += dashWidth + dashSpace) {
          double end = (i + dashWidth).clamp(0, totalLength);
          Path extractedPath = pathMetric.extractPath(i, end);
          canvas.drawPath(extractedPath, beforeLinePaint);
        }
      }
      return;
    }
    canvas.drawPath(path, beforeLinePaint);
  }
}

/// Given an axis that has an object positioned somewhere between the start and
/// end point, this represents the different sizes and coordinates of this axis.
@immutable
class AxisPosition {
  const AxisPosition({
    required this.firstSpace,
    required this.objectSpace,
    required this.secondSpace,
  });

  final AxisCoordinates firstSpace;
  final AxisCoordinates objectSpace;
  final AxisCoordinates secondSpace;

  double get totalSize => firstSpace.size + objectSpace.size + secondSpace.size;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AxisPosition &&
          runtimeType == other.runtimeType &&
          firstSpace == other.firstSpace &&
          objectSpace == other.objectSpace &&
          secondSpace == other.secondSpace;

  @override
  int get hashCode =>
      firstSpace.hashCode ^ objectSpace.hashCode ^ secondSpace.hashCode;

  @override
  String toString() {
    return 'AxisPosition{'
        'firstSpace: $firstSpace, '
        'objectSpace: $objectSpace, '
        'secondSpace: $secondSpace}';
  }
}

/// The coordinates to position an object into an axis.
@immutable
class AxisCoordinates {
  const AxisCoordinates({
    required this.start,
    required this.end,
  })  : size = end - start,
        assert(
          end >= start,
          'The end coordinate must be bigger or equals than the start coordinate',
        );

  factory AxisCoordinates.zero() {
    return const AxisCoordinates(start: 0, end: 0);
  }

  /// The position it starts
  final double start;

  /// The position it ends
  final double end;

  /// The sum of space between [start] and [end]
  final double size;

  double get center => start + (size / 2);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AxisCoordinates &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end &&
          size == other.size;

  @override
  int get hashCode => start.hashCode ^ end.hashCode ^ size.hashCode;

  @override
  String toString() {
    return 'AxisCoordinates{start: $start, end: $end, size: $size}';
  }
}

/// Given an axis (x or y) of [totalSize], this will calculate how to position
/// an object in the axis based on its [objectSize] and the [axisPosition].
/// If the object exceed the [totalSize] at the top or the bottom, it will
/// be aligned at the start or at the end with [_alignObject].
AxisPosition calculateAxisPositioning({
  required double totalSize,
  required double objectSize,
  required double axisPosition,
}) {
  if (axisPosition < 0.0 || axisPosition > 1.0) {
    throw AssertionError('The axisPosition must be provided and must be a value'
        ' between 0.0 and 1.0 inclusive');
  }

  if (objectSize >= totalSize) {
    return _alignObject(
      totalSize: totalSize,
      objectSize: objectSize,
      alignEnd: true,
      alignStart: true,
    );
  }

  final objectCenter = totalSize * axisPosition;
  final objectHalfSize = objectSize / 2;

  final firstSize = objectCenter - objectHalfSize;
  if (firstSize < 0) {
    return _alignObject(
      totalSize: totalSize,
      objectSize: objectSize,
      alignStart: true,
    );
  }

  final secondSize = totalSize - objectCenter - objectHalfSize;
  if (secondSize < 0) {
    return _alignObject(
      totalSize: totalSize,
      objectSize: objectSize,
      alignEnd: true,
    );
  }

  return AxisPosition(
    firstSpace: AxisCoordinates(start: 0, end: firstSize),
    objectSpace: AxisCoordinates(start: firstSize, end: firstSize + objectSize),
    secondSpace: AxisCoordinates(start: firstSize + objectSize, end: totalSize),
  );
}

AxisPosition _alignObject({
  required double totalSize,
  required double objectSize,
  bool alignStart = false,
  bool alignEnd = false,
}) {
  if (alignStart == false && alignEnd == false) {
    throw AssertionError('Either alignTop or alignBottom must be true');
  }

  if (alignStart && alignEnd) {
    return AxisPosition(
      firstSpace: AxisCoordinates.zero(),
      objectSpace: AxisCoordinates(start: 0, end: totalSize),
      secondSpace: AxisCoordinates.zero(),
    );
  }

  return AxisPosition(
    firstSpace: alignStart
        ? AxisCoordinates.zero()
        : AxisCoordinates(start: 0, end: totalSize - objectSize),
    objectSpace: alignStart
        ? AxisCoordinates(start: 0, end: objectSize)
        : AxisCoordinates(start: totalSize - objectSize, end: totalSize),
    secondSpace: alignEnd
        ? AxisCoordinates(start: totalSize, end: totalSize)
        : AxisCoordinates(start: objectSize, end: totalSize),
  );
}
