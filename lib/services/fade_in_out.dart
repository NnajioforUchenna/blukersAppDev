import 'package:flutter/material.dart';

class FadeInOutWidget extends StatefulWidget {
  final Widget child;

  FadeInOutWidget({required this.child});

  @override
  _FadeInOutWidgetState createState() => _FadeInOutWidgetState();
}

class _FadeInOutWidgetState extends State<FadeInOutWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Adjust the duration as needed
    );

    // Create a curved animation
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Adjust the curve as needed
    );

    // Forward the animation to start with a fade-in effect
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          // Wrap the child widget you want to fade in and out with Opacity
          return Opacity(
            opacity: _animation.value, // Opacity controlled by animation
            child: widget.child,
          );
        },
      ),
    );
  }
}
