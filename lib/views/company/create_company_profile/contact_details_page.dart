import 'package:bulkers/providers/company_provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../utils/styles/theme_colors.dart';
import '../../auth/common_widget/auth_input.dart';
import '../../common_views/address_form/address_form.dart';
import '../../common_views/address_form/validate_address.dart';

class ContactDetailsPage extends StatefulWidget {
  const ContactDetailsPage({super.key});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _customerServicePhoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _countryController = TextEditingController();

  String ext = '+52';

  void _onCountryChange(CountryCode countryCode) {
    ext = countryCode.toString();
  }

  // Implementation of isFormComplete method
  bool isFormComplete() {
    return _customerServicePhoneController.text.isNotEmpty &&
        _streetController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _stateController.text.isNotEmpty &&
        _postalCodeController.text.isNotEmpty &&
        _countryController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
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
                      "Contact Details Page",
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
                                  onChanged: _onCountryChange,
                                  initialSelection: '+1',
                                  favorite: const ['+1', 'FR'],
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
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.length < 10) {
                                  return "Ten Digits Required";
                                }
                                if (value.length > 10) {
                                  return "Ten Digits Required";
                                }
                                return null;
                              },
                              controller: _customerServicePhoneController,
                              decoration: InputDecoration(
                                  hintText: "Customer Service Phone Number",
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
                    AddressForm(
                      streetController: _streetController,
                      cityController: _cityController,
                      stateController: _stateController,
                      postalCodeController: _postalCodeController,
                      countryController: _countryController,
                      label: 'Head Office Address',
                      validate: isFormComplete,
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                isFormComplete()) {
                              ValidateAddress(
                                _streetController.text,
                                _cityController.text,
                                _stateController.text,
                                _postalCodeController.text,
                                _countryController.text,
                              );
                              // cp.addContactDetails(
                              //   ext,
                              //   _customerServicePhoneController.text,
                              //   _streetController.text,
                              //   _cityController.text,
                              //   _stateController.text,
                              //   _postalCodeController.text,
                              //   _countryController.text,
                              // );
                            } else {
                              EasyLoading.showError(
                                  "Please fill all the fields");
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ThemeColors.secondaryThemeColor),
                          ),
                          child: const Text("Next"),
                        ),
                      ],
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

  @override
  void dispose() {
    _customerServicePhoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();

    super.dispose();
  }
}
