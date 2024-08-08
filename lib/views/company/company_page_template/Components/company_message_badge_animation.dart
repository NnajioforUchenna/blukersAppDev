import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../providers/company_chat_provider.dart';

class CompanyMessageBadgeAnimation extends StatefulWidget {
  final Widget child;
  const CompanyMessageBadgeAnimation({super.key, required this.child});

  @override
  State<CompanyMessageBadgeAnimation> createState() =>
      _CompanyMessageBadgeAnimationState();
}

class _CompanyMessageBadgeAnimationState
    extends State<CompanyMessageBadgeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _animationController.forward(from: 0).then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    CompanyChatProvider wp = Provider.of<CompanyChatProvider>(context);
    int messageCount = wp.unreadMessageCount;
    if (messageCount > 0) {
      _startAnimation();
    }
    return InkWell(
      onTap: () {
        _startAnimation();
        // delay for animation to complete
        Future.delayed(const Duration(milliseconds: 1000), () {
          context.go('/companyChat');
        });
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_animation.value * 0.5),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
