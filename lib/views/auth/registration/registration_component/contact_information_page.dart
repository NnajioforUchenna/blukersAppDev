import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../services/responsive.dart';
import '../../common_widget/auth_input.dart';
import '../../common_widget/submit_button.dart';

class ContantInformationPage extends StatefulWidget {
  const ContantInformationPage({super.key});

  @override
  State<ContantInformationPage> createState() => _ContantInformationPageState();
}

class _ContantInformationPageState extends State<ContantInformationPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  void _onCountryChange(CountryCode countryCode) {
    print("New Country selected: $countryCode");
  }

  isFormComplete() {
    setState(() {
      isValidate = _phoneController.text.isNotEmpty;
    });
  }

  String ext = '+52';
  bool isValidate = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    UserProvider up = Provider.of<UserProvider>(context);
    String initialSelection = up.userRole == 'company' ? '+1' : '+52';
    return Container(
      color: Colors.white,
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.7),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
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
                                return AppLocalizations.of(context)!
                                    .tenDigitsRequired;
                              }
                              if (value.length > 10) {
                                return AppLocalizations.of(context)!
                                    .tenDigitsRequired;
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
                                hintText: AppLocalizations.of(context)!.phone,
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
                  const SizedBox(height: 20),
                  SubmitButton(
                    onTap: () {
                      up.addingContactInformation(ext, _phoneController.text);
                    },
                    text: AppLocalizations.of(context)!.saveProfile,
                    isDisabled: !isValidate,
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ),
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
  }
}
