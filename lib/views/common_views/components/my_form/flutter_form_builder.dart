import 'package:blukers/models/my_form_input_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
// import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:flutter/services.dart'; // Import this package for FilteringTextInputFormatter

import 'package:intl/intl.dart';
import 'dart:convert';

// DOCS:
// https://pub.dev/packages/flutter_form_builder
// https://pub.dev/packages/form_builder_validators
// https://pub.dev/packages/form_builder_extra_fields/
// https://pub.dev/packages/form_builder_file_picker/
// https://pub.dev/packages/form_builder_image_picker/

// The currently supported fields include:
// FormBuilderCheckbox - Single checkbox field
// FormBuilderCheckboxGroup - List of checkboxes for multiple selection
// FormBuilderChoiceChip - Creates a chip that acts like a radio button.
// FormBuilderDateRangePicker - For selection of a range of dates
// FormBuilderDateTimePicker - For Date, Time and DateTime input
// FormBuilderDropdown - Used to select one value from a list as a Dropdown
// FormBuilderFilterChip - Creates a chip that acts like a checkbox
// FormBuilderRadioGroup - Used to select one value from a list of Radio Widgets
// FormBuilderRangeSlider - Used to select a range from a range of values
// FormBuilderSlider - For selection of a numerical value on a slider
// FormBuilderSwitch - On/Off switch field
// FormBuilderTextField - A Material Design text field input

class FlutterFormBuilder extends StatefulWidget {
  final List<MyFormInputModel> inputElements;
  String submitButtonText;
  Function(Map<String, dynamic>) onSubmit;

  FlutterFormBuilder({
    Key? key,
    this.inputElements = const [],
    this.submitButtonText = 'SUBMIT',
    required this.onSubmit,
  }) : super(key: key);

  @override
  _FlutterFormBuilderState createState() => _FlutterFormBuilderState();
}

class _FlutterFormBuilderState extends State<FlutterFormBuilder> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  List<String> _selectedChips = [];
  String? _selectedChip;

  DateTime _selectedDateTime = DateTime.now();
  DateTime? _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime = TimeOfDay.now();
  // DateTimeRange _selectedDateRange = DateTimeRange(
  //   start: DateTime(0001),
  //   end: DateTime(9999),
  // );
  // Start Date: TODAY - End Date: TOMORROW
  DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 1,
    ),
  );

  String? selectedValue; // Store the selected value
  var options = ["Option 1", "Option 2", "Option 3"];
  List<String> selectedOptions = [];
  String? selectedOption;
  RangeValues? _sliderValues = RangeValues(25, 75);
  double? _sliderValue = 50.0;
  bool? _switchValue = false;

  double _formattedDecimalValue =
      0.00; // Initialized with 0.00, change as needed.

  TextEditingController _textEditingController = TextEditingController();
  String _textFieldValue = "";

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        _textFieldValue = _textEditingController.text;
      });
    });
  }

  Map<String, dynamic> formFieldValues = {};

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: <Widget>[
          ...widget.inputElements
              .map((inputElement) => buildFormInput(inputElement))
              .toList(),
          const SizedBox(height: 20),
          buildFormSubmitButton(
              context, widget.submitButtonText, widget.onSubmit)
        ],
      ),
    );
  }

  Widget buildFormInput(MyFormInputModel inputElement) {
    switch (inputElement.type) {
      case 'email':
        return FormBuilderTextField(
          name: inputElement.name,
          decoration: InputDecoration(
            labelText: inputElement.label,
            hintText: inputElement.placeholder,
          ),
          initialValue: inputElement.initialValue ?? '',
          onChanged: (value) {
            formFieldValues[inputElement.name] = value; // Update the map
          },
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
        );

      case 'password':
        return FormBuilderTextField(
          name: inputElement.name,
          decoration: InputDecoration(
            labelText: inputElement.label,
            hintText: inputElement.placeholder,
          ),
          initialValue: inputElement.initialValue ?? '',
          onChanged: (value) {
            formFieldValues[inputElement.name] = value; // Update the map
          },
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
          obscureText: true,
        );

      case 'textfield':
        return FormBuilderTextField(
          name: inputElement.name,
          // controller: _textEditingController,
          decoration: InputDecoration(
            labelText: inputElement.label,
            hintText: inputElement.placeholder,
          ),
          initialValue: inputElement.initialValue ?? '',
          onChanged: (value) {
            formFieldValues[inputElement.name] = value; // Update the map
          },
          validator: FormBuilderValidators.compose([
            if (inputElement.validationRules.contains('required'))
              FormBuilderValidators.required(),
            if (inputElement.validationRules.contains('maxLength100'))
              FormBuilderValidators.maxLength(100),
          ]),
        );

      case 'number':
        return FormBuilderTextField(
          name: inputElement.name,
          // controller: _textEditingController,
          decoration: InputDecoration(
            labelText: inputElement.label,
            hintText: inputElement.placeholder,
          ),
          initialValue: inputElement.initialValue ?? '',
          onChanged: (value) {
            formFieldValues[inputElement.name] = value; // Update the map
          },
          validator: FormBuilderValidators.compose([
            if (inputElement.validationRules.contains('required'))
              FormBuilderValidators.required(),
            if (inputElement.validationRules.contains('maxLength100'))
              FormBuilderValidators.maxLength(100),
          ]),
          // Set the keyboardType to accept only numbers
          keyboardType: TextInputType.number,
          // inputFormatters: [
          //   FilteringTextInputFormatter.digitsOnly, // Allow only numeric input
          // ],
        );

      case 'integer':
        return FormBuilderTextField(
          name: inputElement.name,
          // controller: _textEditingController,
          decoration: InputDecoration(
            labelText: inputElement.label,
            hintText: inputElement.placeholder,
          ),
          initialValue: inputElement.initialValue ?? '',
          onChanged: (value) {
            formFieldValues[inputElement.name] = value; // Update the map
          },
          validator: FormBuilderValidators.compose([
            if (inputElement.validationRules.contains('required'))
              FormBuilderValidators.required(),
            if (inputElement.validationRules.contains('maxLength100'))
              FormBuilderValidators.maxLength(100),
          ]),
          // Set the keyboardType to accept only numbers
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Allow only numeric input
          ],
        );

      case 'decimal':
        return FormBuilderTextField(
          name: inputElement.name,
          // controller: _textEditingController,
          decoration: InputDecoration(
            labelText: inputElement.label,
            hintText: inputElement.placeholder,
          ),
          initialValue: inputElement.initialValue ?? '',
          onChanged: (value) {
            formFieldValues[inputElement.name] = value; // Update the map
            // try {
            //   if (value != null) {
            //     // String value2 = double.parse(value.toString());
            //     // double value3 = double.parse(value2);
            //     // String value4 = double.parse(value3.toStringAsFixed(2));
            //     // Round to two decimal places
            //     // _formattedDecimalValue = double.parse(value.toStringAsFixed(2));
            //     // _controller.text = _formattedDecimalValue.toString();
            //     // value = _formattedDecimalValue;
            //   }
            // } catch (e) {
            //   // Handle parsing errors, e.g., if the input is not a valid number
            //   // Set a default value or an error message
            //   _formattedDecimalValue = 0.0;
            //   // _controller.text = ''; // Clear the input field on error
            // }
            // setState(() {
            //   _formattedDecimalValue = _formattedDecimalValue;
            // });
          },
          validator: FormBuilderValidators.compose([
            if (inputElement.validationRules.contains('required'))
              FormBuilderValidators.required(),
            if (inputElement.validationRules.contains('maxLength100'))
              FormBuilderValidators.maxLength(100),
          ]),
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ), // Allow numbers with decimals
          inputFormatters: [
            // Allow numbers with up to 2 decimal places
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d+\.?\d{0,2}$'),
            ),
          ],
        );

      case 'textarea':
        return FormBuilderTextField(
          name: inputElement.name,
          // controller: _textEditingController,
          decoration: InputDecoration(
            labelText: inputElement.label,
            hintText: inputElement.placeholder,
          ),
          initialValue: inputElement.initialValue ?? '',
          onChanged: (value) {
            formFieldValues[inputElement.name] = value; // Update the map
          },
          validator: FormBuilderValidators.compose([
            if (inputElement.validationRules.contains('required'))
              FormBuilderValidators.required(),
            if (inputElement.validationRules.contains('maxLength100'))
              FormBuilderValidators.maxLength(100),
          ]),
          maxLines: 8,
        );

      case 'radio':
        return FormBuilderRadioGroup(
          name: inputElement.name,
          decoration: InputDecoration(
            labelText: inputElement.label,
          ),
          initialValue: inputElement.initialValue ?? [],
          onChanged: (value) {
            setState(() {
              selectedOption = value.toString();
              formFieldValues[inputElement.name] = value;
            });
          },
          options: inputElement.options!
              .map((option) => FormBuilderFieldOption(
                    value: option['value'].toString(),
                    child: Text(option['text'].toString()),
                  ))
              .toList(),
          validator: FormBuilderValidators.compose([
            if (inputElement.validationRules.contains('required'))
              FormBuilderValidators.required(),
          ]),
        );

      case 'checkbox':
        if (inputElement.options != null) {
          return FormBuilderCheckboxGroup<dynamic>(
            name: inputElement.name,
            decoration: InputDecoration(
              labelText: inputElement.label,
            ),
            initialValue: inputElement.initialValue ?? [],
            onChanged: (value) {
              formFieldValues[inputElement.name] = value; // Update the map
            },
            options: inputElement.options!
                .map((option) => FormBuilderFieldOption(
                      value: option['value'].toString(),
                      child: Text(option['text'].toString()),
                    ))
                .toList(),
            validator: FormBuilderValidators.compose([
              if (inputElement.validationRules.contains('required'))
                FormBuilderValidators.required(),
            ]),
          );
        } else {
          return const Text('Checkbox options not provided.');
        }

      case 'dropdown':
        if (inputElement.options != null) {
          return FormBuilderDropdown(
            // name: inputElement.label!.toLowerCase().replaceAll(' ', '_'),
            name: inputElement.name,
            decoration: InputDecoration(
              labelText: inputElement.label,
            ),
            initialValue: inputElement.initialValue ?? '',
            onChanged: (value) {
              formFieldValues[inputElement.name] = value; // Update the map
            },
            items: inputElement.options
                .map((option) => DropdownMenuItem(
                      value: option['value'].toString(),
                      child: Text(option['text'].toString()),
                    ))
                .toList(),
            validator: FormBuilderValidators.compose([
              if (inputElement.validationRules.contains('required'))
                FormBuilderValidators.required(),
            ]),
          );
        } else {
          return const Text('Dropdown options not provided.');
        }

      case 'filterChip':
        if (inputElement.options != null) {
          return FormBuilderFilterChip<dynamic>(
            name: inputElement.name,
            options: inputElement.options!
                .map((option) => FormBuilderChipOption(
                      value: option['value'].toString(),
                      child: Text(option['text'].toString()),
                    ))
                .toList(),
            initialValue: inputElement.initialValue ?? [],
            onChanged: (dynamic selectedChips) {
              // selectedChips = selectedChips.toString();
              setState(() {
                _selectedChips = selectedChips!;
              });
              formFieldValues[inputElement.name] = selectedChips;
            },
            decoration: InputDecoration(
              labelText: inputElement.label,
            ),
            selectedColor: const Color.fromARGB(
              255,
              34,
              255,
              107,
            ), // Customize the selected chip color
            spacing: 10.0, // Adjust spacing between chips
            validator: FormBuilderValidators.compose([
              if (inputElement.validationRules.contains('required'))
                FormBuilderValidators.required(),
            ]),
          );
        } else {
          return const Text('filterChip options not provided.');
        }

      case 'choiceChip':
        if (inputElement.options != null) {
          return FormBuilderChoiceChip<dynamic>(
            name: inputElement.name,
            // initialValue: inputElement.initialValue ?? "",
            decoration: InputDecoration(
              labelText: inputElement.label,
            ),
            options: inputElement.options!
                .map((option) => FormBuilderChipOption(
                      value: option['value'].toString(),
                      child: Text(option['text'].toString()),
                    ))
                .toList(),
            selectedColor: Colors.blue, // Customize the selected chip color
            spacing: 10.0, // Adjust spacing between chips
            // initialValue: inputElement.initialValue ?? [],
            initialValue: inputElement.initialValue ?? "",
            onChanged: (selectedValue) {
              setState(() {
                _selectedChip = selectedValue;
              });
              formFieldValues[inputElement.name] = selectedValue;
            },
            validator: FormBuilderValidators.compose([
              if (inputElement.validationRules.contains('required'))
                FormBuilderValidators.required(),
            ]),
          );
        } else {
          return const Text('choiceChip options not provided.');
        }

      case 'datePicker':
        return FormBuilderDateTimePicker(
          name: inputElement.name,
          inputType: InputType.date,
          format: DateFormat('MM/dd/yyyy'),
          decoration: InputDecoration(
            labelText: inputElement.label,
          ),
          initialValue: inputElement.initialValue ?? DateTime.now(),
          onChanged: (DateTime? newDate) {
            if (newDate != null) {
              setState(() {
                _selectedDate = newDate;
              });
            }
            formFieldValues[inputElement.name] = newDate;
          },
          validator: FormBuilderValidators.compose([
            if (inputElement.validationRules.contains('required'))
              FormBuilderValidators.required(),
          ]),
        );

      case 'timePicker':
        return FormBuilderDateTimePicker(
          name: inputElement.name,
          inputType: InputType.time,
          format: DateFormat('hh:mm a'),
          decoration: InputDecoration(
            labelText: inputElement.label,
          ),
          initialValue: inputElement.initialValue ??
              DateTime(
                _selectedDate!.year,
                _selectedDate!.month,
                _selectedDate!.day,
                _selectedTime!.hour,
                _selectedTime!.minute,
              ),
          onChanged: (DateTime? newDateTime) {
            if (newDateTime != null) {
              setState(() {
                _selectedTime = TimeOfDay.fromDateTime(newDateTime);
              });
              formFieldValues[inputElement.name] =
                  TimeOfDay.fromDateTime(newDateTime);
            }
          },
          validator: FormBuilderValidators.compose([
            if (inputElement.validationRules.contains('required'))
              FormBuilderValidators.required(),
          ]),
        );

      case 'dateTimePicker':
        return FormBuilderDateTimePicker(
          name: inputElement.name,
          inputType: InputType.both,
          format: DateFormat('MM/dd/yyyy hh:mm a'),
          decoration: InputDecoration(
            labelText: inputElement.label,
          ),
          initialDate: inputElement.initialValue ?? DateTime.now(),
          initialValue: inputElement.initialValue ?? DateTime.now(),
          onChanged: (DateTime? newDateTime) {
            if (newDateTime != null) {
              setState(() {
                _selectedDateTime = newDateTime;
              });
              formFieldValues[inputElement.name] = newDateTime;
            }
          },
          validator: FormBuilderValidators.compose([
            if (inputElement.validationRules.contains('required'))
              FormBuilderValidators.required(),
          ]),
        );

      case 'dateRangePicker':
        return FormBuilderDateRangePicker(
          name: inputElement.name,
          initialValue: inputElement.initialValue ?? _selectedDateRange,
          firstDate: inputElement.initialValue ?? _selectedDateRange.start,
          lastDate: inputElement.initialValue2 ?? _selectedDateRange.end,
          format: DateFormat('MM/dd/yyyy'),
          decoration: InputDecoration(
            labelText: inputElement.label,
          ),
          onChanged: (DateTimeRange? newDateRange) {
            if (newDateRange != null) {
              setState(() {
                _selectedDateRange = newDateRange;
              });
            }
            formFieldValues[inputElement.name] = newDateRange;
          },
          validator: FormBuilderValidators.compose([
            if (inputElement.validationRules.contains('required'))
              FormBuilderValidators.required(),
          ]),
        );

      case 'rangeSlider':
        return FormBuilderRangeSlider(
          name: inputElement.name,
          initialValue: inputElement.initialValue ?? _sliderValues,
          min: 0,
          max: 100,
          divisions: 100,
          decoration: InputDecoration(
            labelText: inputElement.label,
          ),
          onChanged: (values) {
            setState(() {
              _sliderValues = values;
            });
            formFieldValues[inputElement.name] = values;
          },
          validator: FormBuilderValidators.compose([
            if (inputElement.validationRules.contains('required'))
              FormBuilderValidators.required(),
          ]),
        );

      case 'slider':
        return FormBuilderSlider(
          name: inputElement.name,
          initialValue: _sliderValue ?? 50.0, // Provide a default value
          // initialValue: inputElement.initialValue ?? _sliderValue,
          min: 0,
          max: 100,
          divisions: 100,
          decoration: InputDecoration(
            labelText: inputElement.label,
          ),
          onChanged: (value) {
            setState(() {
              _sliderValue = value;
            });
            formFieldValues[inputElement.name] = value;
          },
          validator: FormBuilderValidators.compose([
            if (inputElement.validationRules.contains('required'))
              FormBuilderValidators.required(),
          ]),
        );

      case 'switch':
        return FormBuilderSwitch(
          name: inputElement.name,
          // initialValue: _switchValue,
          initialValue: inputElement.initialValue ?? _switchValue,
          title: Text(inputElement.label ?? 'On/Off'),
          decoration: InputDecoration(
            labelText: inputElement.label,
          ),
          onChanged: (value) {
            setState(() {
              _switchValue = value;
            });
            formFieldValues[inputElement.name] = value;
          },
          validator: FormBuilderValidators.compose([
            if (inputElement.validationRules.contains('required'))
              FormBuilderValidators.required(),
          ]),
        );

      // -----------------------------------

      default:
        return Text('Invalid input type: ${inputElement.type}');
    }
  }

  Widget buildFormSubmitButton(context, submitButtonText, onSubmit) {
    // return ElevatedButton(
    //   onPressed: () => _handleOnSubmit(onSubmit),
    //   child: Text(submitButtonText),
    // );
    return Container(
      width: double.infinity, // Makes the button expand to full width
      height: 50,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.blue.shade800),
        ),
        onPressed: () => _handleOnSubmit(onSubmit),
        child: Text(
          submitButtonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    // return MaterialButton(
    //   color: Theme.of(context).colorScheme.secondary,
    //   onPressed: () => _handleOnSubmit(onSubmit),
    //   child: Text(submitButtonText),
    // );
  }

  void _handleOnSubmit(onSubmit) {
    // Validate and save the form values
    _formKey.currentState?.saveAndValidate();
    var savedAndValidatedValues = _formKey.currentState?.value;
    debugPrint(savedAndValidatedValues.toString());

    // On another side, can access all field values without saving form with instantValues
    _formKey.currentState?.validate();
    var notSavedInstantValues = _formKey.currentState?.instantValue;
    debugPrint(notSavedInstantValues.toString());

    onSubmit(savedAndValidatedValues);
  }

  Map<String, dynamic> getFormValues() {
    // Map<String, dynamic> mapValue = json.decode(formFieldValues);
    // Map<String, dynamic> mapValue = formFieldValues as Map<String, dynamic>;
    return formFieldValues;
  }
}
