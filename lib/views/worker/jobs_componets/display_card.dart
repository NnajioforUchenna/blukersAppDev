import 'package:flutter/material.dart';

import '../../../utils/styles/theme_colors.dart';

class DisplayCard extends StatelessWidget {
  final String? timeAgo;
  final String? title;
  final String? salaryRange;
  final String? salaryType;
  final String? companyName;
  final String? location;
  final String? companyLogo;
  final VoidCallback? onTap;

  const DisplayCard({
    Key? key,
    this.timeAgo,
    this.title,
    this.salaryRange,
    this.salaryType,
    this.companyName,
    this.location,
    this.companyLogo,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          side:
              const BorderSide(color: ThemeColors.primaryThemeColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 0), // Adjust for spacing
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15), // Add padding for larger appearance
          title: Text(
            title ?? '', // Handle null title
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ThemeColors.primaryThemeColor,
            ),
          ),
          subtitle: Text(salaryRange ?? ''), // Handle null salaryRange
          leading: Container(
            width: 50, // Adjust size as necessary
            height: 50, // Adjust size as necessary
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), // Rounded rectangle
                image: DecorationImage(
                  image: NetworkImage(companyLogo ??
                      "https://picsum.photos/200/300"), // Handle null companyLogo
                  fit: BoxFit.cover,
                )),
          ),
          trailing: Text(companyName ?? ''), // Handle null companyName
          // Add more details for each worker, if needed
        ),
      ),
    );
  }
}
