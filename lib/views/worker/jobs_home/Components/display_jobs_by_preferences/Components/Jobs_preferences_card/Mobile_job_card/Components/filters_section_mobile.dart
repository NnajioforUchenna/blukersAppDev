// filters_section.dart

import 'package:flutter/material.dart';

class FiltersSection extends StatelessWidget {
  final bool isExpandedFilters;
  final VoidCallback onToggleFilters;

  const FiltersSection({
    Key? key,
    required this.isExpandedFilters,
    required this.onToggleFilters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: onToggleFilters,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.filter_list,
                    size: 14,
                    color: Color.fromRGBO(27, 117, 187, 1),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Filters',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    isExpandedFilters ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isExpandedFilters)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Filter options go here..'),
          ),
      ],
    );
  }
}
