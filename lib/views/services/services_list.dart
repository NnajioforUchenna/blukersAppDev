import 'package:blukers/providers/app_versions_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../common_files/constants.dart';
import '../common_views/page_template/page_template.dart';
import 'service_card.dart';

class ServicesList extends StatelessWidget {
  const ServicesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppVersionsProvider avp = Provider.of<AppVersionsProvider>(context);

    if (!kIsWeb) {
      avp.checkForUpdate(context);
    }

    return PageTemplate(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50.0, bottom: 10.0),
              child: Text(
                'Services',
                style: GoogleFonts.montserrat(
                  fontSize: 20.0,
                  // fontWeight: FontWeight.bold,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  for (var service in listServices)
                    ServiceCard(
                      title: service['title']!,
                      description: service['description']!,
                      route: service['route']!,
                      service: service['service']!,
                      color: service['color'],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
