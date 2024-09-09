import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final Widget label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final Color selectedColor;

  const CustomChip({
    Key? key,
    required this.label,
    required this.selected,
    required this.onSelected,
    required this.selectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(!selected),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? selectedColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          border: selected ? Border.all(color: selectedColor) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            label,
            if (selected)
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 5, 146, 10),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 10,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
