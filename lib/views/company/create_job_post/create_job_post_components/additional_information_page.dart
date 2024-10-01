import 'package:blukers/views/company/Alert/job_noti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_posts_provider.dart';
import '../../../auth/common_widget/auth_input.dart';
import '../../../common_vieiws/address_form/address_form.dart';

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

  late JobNotificationHandler jobNotificationHandler;

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
    jobNotificationHandler = JobNotificationHandler();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => jp.setJobPostPagePrevious(),
        ),
        title: Text(
          AppLocalizations.of(context)!.createJobPost,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
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
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 70),
                      AddressForm(
                        streetController: _streetController,
                        cityController: _cityController,
                        stateController: _stateController,
                        postalCodeController: _postalCodeController,
                        countryController: _countryController,
                        label: AppLocalizations.of(context)!.address,
                        validate: isFormComplete,
                      ),
                      const SizedBox(height: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () => jp.setJobPostPagePrevious(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80, vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                side: const BorderSide(
                                  color: Colors.deepOrange,
                                  width: 1.0,
                                ),
                              ),
                              child: FittedBox(
                                child: Text(
                                  AppLocalizations.of(context)!.previous,
                                  style: const TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 50),
                          Flexible(
                            child: ElevatedButton(
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80, vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const FittedBox(
                                child: Text(
                                  "Post Job",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: height * .05),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
