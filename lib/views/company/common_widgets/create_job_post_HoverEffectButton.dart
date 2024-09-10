import 'package:flutter/material.dart';

class HoverEffectButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final Widget label;

  const HoverEffectButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
    required ButtonStyle style,
  }) : super(key: key);

  @override
  _HoverEffectButtonState createState() => _HoverEffectButtonState();
}

class _HoverEffectButtonState extends State<HoverEffectButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _bounceAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _animationController.forward();
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        _animationController.reverse();
        setState(() {
          _isHovered = false;
        });
      },
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(30, 117, 187, 1),
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.label,
            const SizedBox(width: 10), // Add spacing between text and icon
            AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _isHovered ? _bounceAnimation.value : 1.0,
                  child: child,
                );
              },
              child: widget.icon,
            ),
          ],
        ),
      ),
    );
  }
}
