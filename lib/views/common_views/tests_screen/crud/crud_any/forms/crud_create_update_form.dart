import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart'; // Import the flutter_easyloading package
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

import 'package:blukers/providers/product_providers/product_provider.dart';
import 'package:blukers/models/product_models/product_model.dart';

import 'package:blukers/models/my_form_input_model.dart';

import 'package:blukers/views/common_views/components/my_form/my_form.dart';

class CRUDCreateUpdateForm extends StatefulWidget {
  List<MyFormInputModel> inputElements;
  Function(Map<String, dynamic>) onSubmit;
  String submitButtonText;

  CRUDCreateUpdateForm({
    Key? key,
    required this.inputElements,
    required this.onSubmit,
    this.submitButtonText = "SUBMIT",
  }) : super(key: key);

  @override
  _CRUDCreateUpdateFormState createState() => _CRUDCreateUpdateFormState();
}

class _CRUDCreateUpdateFormState extends State<CRUDCreateUpdateForm> {
  @override
  Widget build(BuildContext context) {
    return buildForm(context);
  }

  Widget buildForm(context) {
    return MyForm(
      padding: const EdgeInsets.all(10),
      inputElements: widget.inputElements,
      // titleText: 'PRODUCT CREATE/EDIT',
      // subtitleText: 'subtitle text',
      // descriptionText: 'description text',
      // footerText: 'footer text',
      submitButtonText: widget.submitButtonText,
      onSubmit: (formValues) {
        widget.onSubmit(formValues);
      },
    );
  }
}
