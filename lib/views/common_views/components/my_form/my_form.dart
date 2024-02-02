// Purpose of this file, is rendering a form by receiving just a configurations Map object

import 'package:blukers/models/my_form_input_model.dart';
import 'package:flutter/material.dart';

// import 'custom_form/custom_form.dart';
import 'flutter_form_builder.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ignore: slash_for_doc_comments
/**
  ***** EXAMPLE *****
  MyForm(
    padding: const EdgeInsets.all(50),
    titleText: 'title text',
    subtitleText: 'subtitle text',
    descriptionText: 'description text',
    footerText: 'footer text',
    submitButtonText: 'LOGIN',
    inputElements: [
      MyFormInputModel(
        type: 'email',
        name: 'email',
        label: 'Enter your email',
        placeholder: 'user@example.com',
        // initialValue: 'name@company.com',
      ),
      MyFormInputModel(
        type: 'password',
        name: 'password',
        label: 'Enter your password',
        placeholder: '12345678',
        // initialValue: 'hello2024',
      ),
    ],
    onSubmit: (formValues) {
      print('Test: Form Key/Values');
      print(formValues);
    },
  );
  ***** OUTPUT *****
  {email: user@@mail.com, password: 1234456}
 */

class MyForm extends StatelessWidget {
  EdgeInsets padding;
  String titleText;
  String subtitleText;
  String descriptionText;
  String footerText;
  String submitButtonText;
  List<MyFormInputModel> inputElements;
  Function(Map<String, dynamic>) onSubmit;

  MyForm({
    this.padding = const EdgeInsets.all(30.0),
    this.titleText = '',
    this.subtitleText = '',
    this.descriptionText = '',
    this.footerText = '',
    this.submitButtonText = 'Submit',
    List<MyFormInputModel>? inputElements,
    required this.onSubmit,
  }) : inputElements = inputElements ?? inputElementsExample;

  static void _defaultOnSubmit(Map<String, dynamic> values) {
    // Default behavior: Print all values
    print("Default onSubmit: $values");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Column(
          children: [
            if (titleText.toString().length > 0) Text(titleText),
            if (subtitleText.toString().length > 0) Text(subtitleText),
            if (descriptionText.toString().length > 0) Text(descriptionText),
            buildInputElements(context, submitButtonText, onSubmit),
            if (footerText.toString().length > 0) Text(footerText),
          ],
        ));
  }

  Widget buildInputElements(context, submitButtonText, onSubmit) {
    return FlutterFormBuilder(
      inputElements: inputElements,
      submitButtonText: submitButtonText,
      onSubmit: onSubmit,
    );
  }

  Widget buildInputElementsColumn(context, submitButtonText, onSubmit) {
    return Column(
      children: [
        FlutterFormBuilder(
          inputElements: inputElements,
          submitButtonText: submitButtonText,
          onSubmit: onSubmit,
        ),
      ],
    );
  }
}

List<MyFormInputModel> inputElementsExample = [
  MyFormInputModel(
    type: 'email',
    name: 'email',
    label: 'Enter your email',
    placeholder: 'user@example.com',
    // initialValue: 'name@company.com',
  ),
  MyFormInputModel(
    type: 'password',
    name: 'password',
    label: 'Enter your password',
    placeholder: '12345678',
    // initialValue: '0987654321',
  ),
  MyFormInputModel(
    type: 'textfield',
    name: 'short_description',
    label: 'Add a short description',
    placeholder: 'Lorem ipsum...',
    // initialValue: 'short description',
    validationRules: ['required'],
  ),
  MyFormInputModel(
    type: 'textarea',
    name: 'large_description',
    label: 'Add a large description',
    placeholder: 'Lorem ipsum isset it dolor asumet inapmet is...',
    // initialValue: 'large description',
    validationRules: ['required'],
  ),
  MyFormInputModel(
    type: 'radio',
    name: 'radio',
    label: 'Select one option',
    placeholder: '',
    initialValue: "2",
    options: [
      {"text": "Text 1", "value": 1},
      {"text": "Text 2", "value": 2},
      {"text": "Text 3", "value": 3},
    ],
    validationRules: ['required'],
  ),
  MyFormInputModel(
    type: 'checkbox',
    name: 'checkbox',
    label: 'Select the options that apply',
    placeholder: '',
    // initialValue: ["1", "3"],
    options: [
      {"text": "Text 1", "value": 1},
      {"text": "Text 2", "value": 2},
      {"text": "Text 3", "value": 3},
    ],
    validationRules: ['required'],
  ),
  MyFormInputModel(
    type: 'dropdown',
    name: 'dropdown',
    label: 'Select one option',
    placeholder: '',
    // initialValue: '2',
    options: [
      {"text": "Text 1", "value": 1},
      {"text": "Text 2", "value": 2},
      {"text": "Text 3", "value": 3},
    ],
    validationRules: ['required'],
  ),
  MyFormInputModel(
    type: 'filterChip',
    name: 'filterChip',
    label: 'Select the options that apply',
    placeholder: '',
    // initialValue: ['1', '3'],
    options: [
      {"text": "Text 1", "value": 1},
      {"text": "Text 2", "value": 2},
      {"text": "Text 3", "value": 3},
    ],
    validationRules: ['required'],
  ),
  MyFormInputModel(
    type: 'choiceChip',
    name: 'choiceChip',
    label: 'Select one option',
    placeholder: '',
    // initialValue: '2',
    options: [
      {"text": "Text 1", "value": 1},
      {"text": "Text 2", "value": 2},
      {"text": "Text 3", "value": 3},
    ],
    validationRules: ['required'],
  ),
  MyFormInputModel(
    type: 'datePicker',
    name: 'datePicker',
    label: 'Select your birth date',
    placeholder: '',
    // initialValue: '2',
    validationRules: ['required'],
  ),
  MyFormInputModel(
    type: 'timePicker',
    name: 'timePicker',
    label: 'Select your birth hour',
    placeholder: '',
    // initialValue: '2',
    validationRules: ['required'],
  ),
  MyFormInputModel(
    type: 'dateTimePicker',
    name: 'dateTimePicker',
    label: 'Select your birth date and hour',
    placeholder: '',
    // initialValue: '2',
    validationRules: ['required'],
  ),
  MyFormInputModel(
    type: 'dateRangePicker',
    name: 'dateRangePicker',
    label: 'Select arrival and departure dates',
    placeholder: '',
    // initialValue: '2',
    validationRules: ['required'],
  ),
  MyFormInputModel(
    type: 'rangeSlider',
    name: 'rangeSlider',
    label: 'Select a range',
    placeholder: '',
    // initialValue: DateTimeRange(
    //   start: DateTime(
    //     DateTime.now().year,
    //     DateTime.now().month,
    //     DateTime.now().day - 2,
    //   ),
    //   end: DateTime(
    //     DateTime.now().year,
    //     DateTime.now().month,
    //     DateTime.now().day + 7,
    //   ),
    // ),
    validationRules: ['required'],
  ),
  MyFormInputModel(
    type: 'slider',
    name: 'slider',
    label: 'Select a vaue',
    placeholder: '',
    // initialValue: 10,
    // initialValue2: 1000,
    validationRules: ['required'],
  ),
  MyFormInputModel(
    type: 'switch',
    name: 'switch',
    label: 'Yer or no?',
    placeholder: '',
    // initialValue: '2',
    validationRules: ['required'],
  ),
];
