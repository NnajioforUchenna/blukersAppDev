import 'package:flutter/material.dart';

class NoJobsFoundCard extends StatefulWidget {
  final String nameSearch;
  final String locationSearch;

  const NoJobsFoundCard({
    super.key,
    required this.nameSearch,
    required this.locationSearch,
  });

  @override
  _NoJobsFoundCardState createState() => _NoJobsFoundCardState();
}

class _NoJobsFoundCardState extends State<NoJobsFoundCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Transform(
        transform: Matrix4.translationValues(0, _isHovering ? -5 : 0, 0),
        child: Card(
          elevation: _isHovering ? 10 : 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  left: BorderSide(
                    width: 15,
                    color: Colors.red, // Using red to indicate no jobs found.
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Oops!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'No more jobs to load based on these parameters:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Search Term: ${widget.nameSearch}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Location: ${widget.locationSearch}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
