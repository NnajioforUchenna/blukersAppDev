class MyFormInputModel {
  final String type;
  final String name;
  final String? label;
  final String? placeholder;
  final dynamic initialValue;
  final dynamic initialValue2;
  final List<Map<String, dynamic>> options;
  final List<String> validationRules;
  final bool disabled;

  MyFormInputModel({
    required this.type,
    required this.name,
    this.label = "",
    this.placeholder = "",
    this.initialValue,
    this.initialValue2,
    this.options = const [],
    this.validationRules = const [],
    this.disabled = false,
  });
}

// options:

// validationRules:
