import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';

class OfferCard extends StatelessWidget {
  final String title;
  final String description;
  final String route;

  const OfferCard({
    super.key,
    required this.title,
    required this.description,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(route);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Icon(
                          UniconsLine.user_plus,
                          size: 30,
                          color: ThemeColors.blukersOrangeThemeColor,
                        ),
                      ),
                      Center(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: ThemeColors.blukersOrangeThemeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: ThemeColors.grey1ThemeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: ThemeColors.grey1ThemeColor,
                ) // Pointer icon at the trailing end
              ],
            ),
          ),
        ),
      ),
    );
  }
}
