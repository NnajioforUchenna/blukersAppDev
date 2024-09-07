import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionInfoPage extends StatelessWidget {
  const SubscriptionInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> loadInfo() async {
      String data = await DefaultAssetBundle.of(context)
          .loadString('assets/data/blukers_info.json');
      return json.decode(data);
    }

    return FutureBuilder<Map<String, dynamic>>(
      future: loadInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> info = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(info['welcomeTitle'],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(info['welcomeMessage'],
                    style: GoogleFonts.montserrat(fontSize: 16)),
                const SizedBox(height: 20),
                Text(info['whyRegisterTitle'],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ...info['whyRegisterPoints']
                    .map<Widget>((point) => Text('• $point',
                        style: GoogleFonts.montserrat(fontSize: 16)))
                    .toList(),
                const SizedBox(height: 20),
                Text('Subscription Plans',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                ...info['subscriptionPlans']
                    .map<Widget>((plan) => SubscriptionPlanCard(plan: plan))
                    .toList(),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Error loading info');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class SubscriptionPlanCard extends StatelessWidget {
  final Map<String, dynamic> plan;

  const SubscriptionPlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(plan['name'] + ' (' + plan['price'] + ')',
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            ...plan['features']
                .map<Widget>((feature) => Text('• $feature',
                    style: GoogleFonts.montserrat(fontSize: 16)))
                .toList(),
          ],
        ),
      ),
    );
  }
}
