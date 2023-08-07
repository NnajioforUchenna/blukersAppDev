import 'package:bulkers/utils/styles/index.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../common_widget/auth_input.dart';
import '../common_widget/submit_button.dart';

class ContantInformationPage extends StatefulWidget {
  const ContantInformationPage({super.key});

  @override
  State<ContantInformationPage> createState() => _ContantInformationPageState();
}

class _ContantInformationPageState extends State<ContantInformationPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _countryController = TextEditingController();
  String ext = '+52';

  void _onCountryChange(CountryCode countryCode) {
    print("New Country selected: " + countryCode.toString());
  }

  // Implementation of isFormComplete method
  bool isFormComplete() {
    return _phoneController.text.isNotEmpty &&
        _streetController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _stateController.text.isNotEmpty &&
        _postalCodeController.text.isNotEmpty &&
        _countryController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    UserProvider up = Provider.of<UserProvider>(context);
    String initialSelection = up.userRole == 'company' ? '+1' : '+52';
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Positioned(
            top: -MediaQuery.of(context).size.height * .15,
            right: -MediaQuery.of(context).size.width * .4,
            child: Container(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Contact Information Page",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ebGaramond(
                        color: Colors.deepOrangeAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            child: AuthInput(
                              child: Center(
                                child: CountryCodePicker(
                                  onChanged: (value) {
                                    ext = value.toString();
                                    _onCountryChange(value);
                                  },
                                  initialSelection: initialSelection,
                                  favorite: const ['+1', '+52', 'FR'],
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 4,
                          child: AuthInput(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              validator: ((value) {
                                if (value!.length < 10) {
                                  return "Ten Digits Required";
                                }
                                if (value.length > 10) {
                                  return "Ten Digits Required";
                                }
                                return null;
                              }),
                              controller: _phoneController,
                              onChanged: (value) {
                                setState(() {
                                  isFormComplete();
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: "Phone",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: ThemeColors.secondaryThemeColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Address',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          _buildTextField(
                              "Street", TextInputType.text, _streetController),
                          const SizedBox(height: 20),
                          _buildTextField(
                              "City", TextInputType.text, _cityController),
                          const SizedBox(height: 20),
                          _buildTextField(
                              "State", TextInputType.text, _stateController),
                          const SizedBox(height: 20),
                          _buildTextField("Postal Code", TextInputType.number,
                              _postalCodeController),
                          const SizedBox(height: 20),
                          _buildTextField("Country", TextInputType.text,
                              _countryController),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    SubmitButton(
                      onTap: () {
                        up.addingContactInformation(
                          ext,
                          _phoneController.text,
                          _streetController.text,
                          _cityController.text,
                          _stateController.text,
                          _postalCodeController.text,
                          _countryController.text,
                        );
                      },
                      text: "Save To Profile",
                      isDisabled: !isFormComplete(),
                    ),
                    SizedBox(height: height * .05),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, TextInputType type, TextEditingController controller) {
    return AuthInput(
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        onChanged: (value) {
          setState(() {
            isFormComplete();
          });
        },
        decoration: InputDecoration(
          hintText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }
}
