import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'create_job_post_HoverEffectButton.dart';
import 'package:google_fonts/google_fonts.dart';

class PleaseCreateCompanyProfile extends StatelessWidget {
  const PleaseCreateCompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF7FF),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 150),
            // Image Section
            Image.asset(
              'assets/images/pleaseCreateProfile.png',
              width: MediaQuery.of(context).size.width * 0.4,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 300),
            // Text and Button Section
            Container(
              padding: const EdgeInsets.all(20),
              constraints: const BoxConstraints(
                maxWidth: 450,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(0, 255, 255, 255),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header Text
                  Text(
                    'Ready To Hire?',
                    style: GoogleFonts.montserrat(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 0, 0, 0),
                      
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  // Description Text
                  Text(
                    'Set up company profile, post job and attract top talent. It’s quick and easy.',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Create Company Account Button
                  HoverEffectButton(
                    onPressed: () {
                      context.go('/createCompanyProfile');
                    },
                    icon: const Icon(
                      Icons.arrow_right_alt,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Create Company Account',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007BFF),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
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
