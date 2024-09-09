// lib/widgets/create_job_step_button.dart

import 'package:flutter/material.dart';
import '../../../old_common_views/skills_form/ChoiceChip/custom_chip.dart';

class StepButton extends StatelessWidget {
  final String text;
  final bool isHighlighted;
  final IconData icon;
  final bool isCompleted;
  final ValueChanged<bool> onCompleted; // New property

  const StepButton({
    required this.text,
    this.isHighlighted = false,
    required this.icon,
    this.isCompleted = false,
    required this.onCompleted, // New property
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Transform.translate(
        offset: const Offset(-50, 0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
            minHeight: 70,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: isHighlighted ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: isHighlighted ? null : Border.all(color: Colors.white70),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  icon,
                  color: isHighlighted ? Colors.orange : Colors.white,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isHighlighted ? Colors.orange : Colors.white,
                      fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                CustomChip(
                  label: const SizedBox.shrink(),
                  selected: isCompleted,
                  onSelected: (completed) => onCompleted(completed), // Notify parent
                  // backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  selectedColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StepArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Icon(
        Icons.arrow_downward,
        color: Colors.white,
      ),
    );
  }
}