import 'package:flutter/material.dart';

class DesktopFiltersSection extends StatelessWidget {
  final bool isExpandedFilters;
  final Function(bool) onFilterExpandedChange;

  const DesktopFiltersSection({
    Key? key,
    required this.isExpandedFilters,
    required this.onFilterExpandedChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // Toggle the filter expanded state
          onFilterExpandedChange(!isExpandedFilters);

          // Show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.white, // Set background color to pure white
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7, 
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Your dialog content goes here
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Filters Content Here',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Add other widgets to the dialog as needed
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.filter_list, size: 14, color: Color.fromRGBO(27, 117, 187, 1)),
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
    );
  }
}
