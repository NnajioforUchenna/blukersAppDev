import '../../../../../providers/user_provider_parts/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common_files/countries.dart';
import 'custom_check_box.dart';

class ListOfCountries extends StatefulWidget {
  const ListOfCountries({super.key});

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
              print(country);
              setState(() {
                selectedCountry = country;
                up.updateUserCountry(country);
              });
            },
            child: Container(
              height: 30,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 3),
              padding: EdgeInsets.only(left: width * 0.075, right: width * 0.1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Countries.indexOf(country) % 2 == 0
                    ? Colors.grey[200]
                    : Colors.transparent,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      country,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  CustomCheckbox(value: country == selectedCountry),
                ],
              ),
            ),
          );
        }),
      ],
    ));
  }
}
