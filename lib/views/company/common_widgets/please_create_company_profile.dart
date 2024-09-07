import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_job_post_HoverEffectButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PleaseCreateCompanyProfile extends StatelessWidget {
  const PleaseCreateCompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

 
    final bool isSmallScreen = screenWidth < 800;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: isSmallScreen
              ? SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Add some top padding to push content up
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0), 
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Header Text
                            Text(
                             AppLocalizations.of(context)!.readytohire,
                             
                              style: GoogleFonts.montserrat(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            // Description Text
                            Text(
                              AppLocalizations.of(context)!.createCompanyProfile,
                              style: GoogleFonts.montserrat(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'It’s quick and easy.',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 110),
                      // Image at the center
                      Image.asset(
                        'assets/images/pleaseCreateProfile.png',
                        width: screenWidth * 0.6,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 60),
                      // Create Company Account Button
                      HoverEffectButton(
                        onPressed: () {
                          context.go('/createCompanyProfile');
                        },
                        icon: const Icon(
                          Icons.arrow_right_alt,
                          color: Colors.white,
                        ),
                        label: Text(
                          AppLocalizations.of(context)!.createCompanyProfile,
                          style: const TextStyle(
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
              )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 5),
                    // Image Section
                    SizedBox(
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.6,
                    
                      child: Image.asset(
                        'assets/images/pleaseCreateProfile.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 100),
                    // Text and Button Section
                    Flexible(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        constraints: const BoxConstraints(
                          maxWidth: 450,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color:  Color(0xFFFFFFFF),
                                
                              blurRadius: 10,
                              offset: Offset(0, 5),
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
                               AppLocalizations.of(context)!.readytohire,
                              style: GoogleFonts.montserrat(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            // Description Text
                            Text(
                               AppLocalizations.of(context)!.quickandeasy,
                             
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 30),
                            // Create Company Account Button
                            HoverEffectButton(
                              onPressed: () {
                                context.go('/createCompanyProfile');
                              },
                              icon: const Icon(
                                Icons.arrow_right_alt,
                                color: Colors.white,
                              ),
                              label:  Text(
                                AppLocalizations.of(context)!.createCompanyProfile,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF007BFF),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 40.0),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
