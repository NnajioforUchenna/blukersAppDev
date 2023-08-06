import 'package:flutter/material.dart';

class JobTimeline extends StatefulWidget {
  @override
  State<JobTimeline> createState() => _JobTimelineState();
}

class _JobTimelineState extends State<JobTimeline> {
  @override
  Widget build(BuildContext context) {
    return ListView();
  }

  Widget _buildTimelineStep(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Center(
              child: Icon(Icons.check, size: 12, color: Colors.white),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
