import 'package:flutter/material.dart';

import 'show_service_dialog.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String servicesDesc;
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
    required this.color, required this.servicesDesc,
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
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFF5F5F5), width: 1.9), // Black border
          borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners
        ),
        height: height * 0.13,

        child: ListTile(
          trailing: const Icon(Icons.navigate_next),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8.0), // Adjust the height to increase/decrease space
              Text(
                servicesDesc,
                style: const TextStyle(color: Colors.grey, fontSize: 12), // Optional: Style subtitle text
              ),
            ],
          ),
        ),
      ),
    );
  }
}
