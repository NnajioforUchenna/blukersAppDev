import 'package:blukers/models/my_form_input_model.dart';

class MyFormModel {
  final String? titleText;
  final String? subtitleText;
  final String? descriptionText;
  final dynamic footerText;
  final dynamic submitButtonText;
  final List<MyFormInputModel>? inputElements;

  MyFormModel({
    this.titleText = "",
    this.subtitleText = "",
    this.descriptionText = "",
    this.footerText = "",
    this.submitButtonText = "",
    required this.inputElements,
  });
}
