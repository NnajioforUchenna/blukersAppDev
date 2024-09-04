import 'package:flutter/material.dart';

class OnHover extends StatefulWidget {
  final Widget child;
  const OnHover({super.key, required this.child});

  @override
  State<OnHover> createState() => _OnHoverState();
}

class _OnHoverState extends State<OnHover> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        // padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: _isHovering ? Colors.grey.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Transform(
            transform: Matrix4.translationValues(0, _isHovering ? -5 : 0, 0),
            child: InkWell(child: widget.child)),
      ),
    );
  }
}
