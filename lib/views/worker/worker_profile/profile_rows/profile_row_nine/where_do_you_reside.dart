import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/styles/theme_colors.dart';
import '../../../../old_common_views/small_pop_button_widget.dart';
import 'list_of_countries.dart';

class WhereDoYouResidePage extends StatelessWidget {
  const WhereDoYouResidePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      insetPadding:
          const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 80),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: height * 0.03,
              bottom: height * 0.03,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: height * 0.05, bottom: height * 0.025),
                  child: Text(
                    'Where do you reside?',
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: ThemeColors.secondaryThemeColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: height * 0.5, child: const ListOfCountries()),
                const Spacer(),
                Container(
                  height: height * 0.03,
                  width: width * 0.23,
                  margin: EdgeInsets.only(top: height * 0.03, bottom: 30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: ThemeColors.secondaryThemeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Update',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 10, // Adjust as needed
            left: 10, // Adjust as needed
            child: SmallPopButtonWidget(),
          ),
        ],
      ),
    );
  }
}
