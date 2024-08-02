import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/company_provider.dart';
import '../../../auth/common_widget/auth_input.dart';
import '../../../common_vieiws/address_form/address_form.dart';
import '../../../worker/create_worker_profile/create_worker_profile_components/timeline_navigation_button.dart';

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

  String ext = '+1';

  void _onCountryChange(CountryCode countryCode) {
    ext = countryCode.toString();
  }

  // Implementation of isFormComplete method
  bool isFormComplete() {
    return _customerServicePhoneController.text.isNotEmpty &&
        _streetController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _stateController.text.isNotEmpty &&
        _countryController.text.isNotEmpty;
  }

  ScrollController scrollCtrl = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CompanyProvider cp = Provider.of<CompanyProvider>(context, listen: false);
      ext = cp.previousParams['ext'] ?? '+1';
      _customerServicePhoneController.text =
          cp.previousParams['phoneNumber'] ?? '';
      _streetController.text = cp.previousParams['street'] ?? '';
      _cityController.text = cp.previousParams['city'] ?? '';
      _stateController.text = cp.previousParams['state'] ?? '';
      _postalCodeController.text = cp.previousParams['postalCode'] ?? '';
      _countryController.text = cp.previousParams['country'] ?? '';
      //added this listner to dismiss keyboard when scroll
      scrollCtrl.addListener(() {
        print('scrolling');
      });
      scrollCtrl.position.isScrollingNotifier.addListener(() {
        if (!scrollCtrl.position.isScrollingNotifier.value) {
          print('scroll is stopped');
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
          print('scroll is started');
        }
      });
    });
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
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              controller: scrollCtrl,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
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
                                  return AppLocalizations.of(context)!
                                      .tenDigitsRequired;
                                }
                                if (value.length > 10) {
                                  return AppLocalizations.of(context)!
                                      .tenDigitsRequired;
                                }
                                return null;
                              },
                              controller: _customerServicePhoneController,
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
                    AddressForm(
                      streetController: _streetController,
                      cityController: _cityController,
                      stateController: _stateController,
                      postalCodeController: _postalCodeController,
                      countryController: _countryController,
                      label: AppLocalizations.of(context)!.headOfficeAddress,
                      validate: isFormComplete,
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TimelineNavigationButton(
                          isSelected: true,
                          onPress: () => cp.companyProfileBackPage(),
                          navDirection: "back",
                        ),
                        TimelineNavigationButton(
                          isSelected: true,
                          onPress: () {
                            if (_formKey.currentState!.validate() &&
                                isFormComplete()) {
                              cp.addContactDetails(
                                ext,
                                _customerServicePhoneController.text,
                                _streetController.text,
                                _cityController.text,
                                _stateController.text,
                                _postalCodeController.text,
                                _countryController.text,
                              );
                            } else {
                              EasyLoading.showError(
                                  "Please fill all the fields");
                            }
                          },
                        ),
                      ],
                    ),
                    // SizedBox(height: height * .05),
                    const SizedBox(height: 150),
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
