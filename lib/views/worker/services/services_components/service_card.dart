import 'package:flutter/material.dart';

import 'show_service_dialog.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final String route;
  final Widget service;
  final Color color;

  const ServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.route,
    required this.service,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => ShowServiceDialog(
                  service: service,
                ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: const Color(0xFFF5F5F5), width: 1.9),
          // Black border
          borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners
        ),
        height: height * 0.13,
        child: Center(
          child: ListTile(
            trailing: const Icon(Icons.navigate_next, color: Colors.white,),
            title: Center(
              child: Text(
                title.toUpperCase(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
