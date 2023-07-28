import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common_widget/auth_input.dart';
import 'common_widget/company_logo.dart';
import 'common_widget/submit_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final node = FocusScope.of(context);
    String userRole = "company";

    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: Container(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // SizedBox(height: height * .2),
                      SizedBox(height: height * .125),
                      const CompanyLogo(),
                      const SizedBox(height: 30),
                      Text(
                        "Complete Your Profile",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ebGaramond(
                          color: Colors.deepOrangeAccent,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (userRole == "user") ...[
                        AuthInput(
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              node.nextFocus();
                            },
                            validator: ((value) {
                              if (value!.length == 0) {
                                return "Required";
                              } else {
                                return null;
                              }
                            }),
                            onSaved: (name) {},
                            decoration: InputDecoration(
                                hintText: "Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    )),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                        SizedBox(height: height * 0.005),
                        AuthInput(
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              node.nextFocus();
                            },
                            validator: ((value) {
                              if (value!.length == 0) {
                                return "Required";
                              } else {
                                return null;
                              }
                            }),
                            onSaved: (lastName) {},
                            decoration: InputDecoration(
                                hintText: "LastName",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    )),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                        SizedBox(height: height * 0.005),
                        // SizedBox(height: 15),
                      ],
                      if (userRole == "company") ...[
                        AuthInput(
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              node.nextFocus();
                            },
                            validator: ((value) {
                              if (value!.length == 0) {
                                return "Required";
                              } else {
                                return null;
                              }
                            }),
                            onSaved: (companyName) {},
                            decoration: InputDecoration(
                                hintText: "Company Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    )),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                        SizedBox(height: height * 0.005),
                      ],
                      SizedBox(height: height * 0.010),
                      AuthInput(
                        child: DropdownButtonFormField<String>(
                          value: "+52",
                          onChanged: (String? countryCode) {
                            // setState(() {
                            //   dropdownValue = countryCode!;
                            // });
                          },
                          onSaved: (countryCode) {},
                          validator: ((value) {
                            if (value!.length == 0) {
                              return "Required";
                            } else {
                              return null;
                            }
                          }),
                          items: [
                            {"country": "US +1", "code": "+1"},
                            {"country": "Mexico +52", "code": "+52"},
                            {"country": "Argentina +54", "code": "+54"},
                            {"country": "Belize +501", "code": "+501"},
                            {"country": "Bolivia +591", "code": "+591"},
                            {"country": "Brazil +55", "code": "+55"},
                            {"country": "Canada +1", "code": "+1"},
                            {"country": "Chile +56", "code": "+56"},
                            {"country": "Colombia +57", "code": "+57"},
                            {"country": "Costa Rica +506", "code": "+506"},
                            {"country": "Cuba +53", "code": "+53"},
                            {"country": "Curaçao +5999", "code": "+5999"},
                            {"country": "Dominica +1767", "code": "+1767"},
                            {
                              "country": "Rep. Dominicana +1 809",
                              "code": "+1809"
                            },
                            {
                              "country": "Rep. Dominicana +1 829",
                              "code": "+1829"
                            },
                            {
                              "country": "Rep. Dominicana +1 849",
                              "code": "+1849"
                            },
                            {"country": "Ecuador +593", "code": "+593"},
                            {"country": "El Salvador +503", "code": "+503"},
                            {"country": "Guatemala +502", "code": "+502"},
                            {"country": "Haiti +509", "code": "+509"},
                            {"country": "Honduras +504", "code": "+504"},
                            {"country": "Nicaragua +505", "code": "+505"},
                            {"country": "Panama +507", "code": "+507"},
                            {"country": "Paraguay +595", "code": "+595"},
                            {"country": "Peru +51", "code": "+51"},
                            {"country": "Puerto Rico +1 787", "code": "+1787"},
                            {"country": "Puerto Rico +1 939", "code": "+1939"},
                            {
                              "country": "Trinidad and Tobago +1 868",
                              "code": "+1868"
                            },
                            {"country": "Uruguay +598", "code": "+598"},
                            // {"country": "Venezuela", "code": "+58"},
                            // {"country": "XXXXXXXX", "code": "XXXX"},
                          ].map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value['code'],
                              child: Text(value["country"].toString()),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "Country Code",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                )),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.010),
                      AuthInput(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            node.nextFocus();
                          },
                          validator: ((value) {
                            if (value!.length < 10) {
                              return "Ten Digits Required";
                            }
                            if (value.length > 10) {
                              return "Ten Digits Required";
                            }
                            return null;
                          }),
                          onSaved: (phoneNumber) {},
                          decoration: InputDecoration(
                              hintText: "Phone",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  )),
                              fillColor: Colors.white,
                              filled: true),
                        ),
                      ),

                      SizedBox(height: height * 0.020),
                      const SizedBox(height: 40),
                      SubmitButton(onTap: () {}, text: "Save Profile"),
                      SizedBox(height: height * .05),
                      // SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(top: 40, left: 0, child: BackButton()),
          ],
        ),
      ),
    );
  }
}
