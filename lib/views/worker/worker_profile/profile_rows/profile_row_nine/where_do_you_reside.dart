import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/styles/theme_colors.dart';
import 'list_of_countries.dart';

class WhereDoYouResidePage extends StatefulWidget {
  const WhereDoYouResidePage({super.key});

  @override
  State<WhereDoYouResidePage> createState() => _WhereDoYouResidePageState();
}

class _WhereDoYouResidePageState extends State<WhereDoYouResidePage> {
  String country = '';
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);

    double width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      child: Container(
        width:   width * (Responsive.isMobile(context) ? 0.6 :0.8),
        padding: EdgeInsets.only(
          left: Responsive.isMobile(context) ? 25 : 40,
          right: Responsive.isMobile(context) ? 25 : 40,
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),

            Center(
              child: Text(
                'Where do you reside?',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: Responsive.isMobile(context) ? 20 : 29),
              ),
            ),
            const SizedBox(
              height: 40,
            ),

            Expanded(child: ListOfCountries(
              onCountrySelected: (String selectedCountry) {
                country = selectedCountry;
              },
            )),
            const SizedBox(
              height: 40,
            ),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  up.updateUserCountry(country);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.primaryThemeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Update',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: Responsive.isMobile(context) ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            )
            // const Positioned(
            //   top: 10, // Adjust as needed
            //   left: 10, // Adjust as needed
            //   child: SmallPopButtonWidget(),
            // ),
          ],
        ),
      ),
    );
  }
}
