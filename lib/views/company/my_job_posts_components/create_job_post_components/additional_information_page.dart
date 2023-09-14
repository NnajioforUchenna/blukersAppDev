import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/common_views/address_form/address_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_posts_provider.dart';
import '../../../auth/common_widget/auth_input.dart';

class AdditionalInformationPage extends StatefulWidget {
  const AdditionalInformationPage({super.key});

  @override
  State<AdditionalInformationPage> createState() =>
      _AdditionalInformationPageState();
}

class _AdditionalInformationPageState extends State<AdditionalInformationPage> {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _countryController = TextEditingController();

  // Implementation of isFormComplete method
  bool isFormComplete() {
    return _streetController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _stateController.text.isNotEmpty &&
        _countryController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);

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
                    const Text(
                      "Additional Information Page",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AddressForm(
                        streetController: _streetController,
                        cityController: _cityController,
                        stateController: _stateController,
                        postalCodeController: _postalCodeController,
                        countryController: _countryController,
                        label: "Address",
                        validate: isFormComplete),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            jp.setJobPostPagePrevious();
                          },
                          child: const Text("Previous"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ThemeColors.secondaryThemeColor),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (isFormComplete() &&
                                _formKey.currentState!.validate()) {
                              jp.updateUserAddress(
                                  _streetController.text,
                                  _cityController.text,
                                  _stateController.text,
                                  _postalCodeController.text,
                                  _countryController.text);
                            } else {
                              EasyLoading.showError(
                                  'Please fill all the fields');
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ThemeColors.secondaryThemeColor),
                          ),
                          child: const Text("Submit"),
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
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }
}
