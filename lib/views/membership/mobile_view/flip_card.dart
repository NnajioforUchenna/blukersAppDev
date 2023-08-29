import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  final bool shouldFlip;

  const FlipCard({
    Key? key,
    required this.front,
    required this.back,
    this.shouldFlip = false,
  }) : super(key: key);

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showFront = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showFront = !_showFront;
        });
        // _controller.reverse();
      }
    });

    _startOrStopFlipping();
  }

  @override
  void didUpdateWidget(FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldFlip != oldWidget.shouldFlip) {
      _startOrStopFlipping();
    }
  }

  _startOrStopFlipping() {
    if (widget.shouldFlip) {
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        _controller.forward();
      });
    } else {
      _timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(math.pi * _controller.value),
          child: _controller.value < 0.5 ? widget.front : widget.back,
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }
}
