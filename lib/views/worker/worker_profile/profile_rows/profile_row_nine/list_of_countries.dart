import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../common_files/countries.dart';
import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../services/responsive.dart';

class ListOfCountries extends StatefulWidget {
  final Function(String) onCountrySelected;
  const ListOfCountries({super.key, required this.onCountrySelected});

  @override
  State<ListOfCountries> createState() => _ListOfCountriesState();
}

class _ListOfCountriesState extends State<ListOfCountries> {
  String selectedCountry = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    UserProvider up = Provider.of<UserProvider>(context);
    if (up.appUser != null && up.appUser!.whereYouReside.isNotEmpty) {
      selectedCountry = up.appUser!.whereYouReside;
    }
    return SingleChildScrollView(
        child: Column(
      children: [
        // ...industries.map((industry) {
        ...Countries.map((country) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedCountry = country;
                widget.onCountrySelected(country);
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 14),
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xFFD0D0D5))),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      country,
                      style: GoogleFonts.montserrat(
                        color: ThemeColors.black1ThemeColor,
                        fontSize: Responsive.isMobile(context) ? 16 : 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: Checkbox(
                        side:
                            const BorderSide(color: ThemeColors.ash, width: 1),
                        activeColor: ThemeColors.primaryThemeColor,
                        value: country == selectedCountry,
                        onChanged: (value) {}),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    ));
  }
}
