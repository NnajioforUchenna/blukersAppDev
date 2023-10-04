import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: color,
        child: Container(
          height: height * 0.13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      title.toUpperCase(),
                      style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ) // Pointer icon at the trailing end
              ],
            ),
          ),
        ),
      ),
    );
  }
}
