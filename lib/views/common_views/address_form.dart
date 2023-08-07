import 'package:flutter/material.dart';

import '../../utils/styles/theme_colors.dart';
import '../auth/common_widget/auth_input.dart';

class AddressForm extends StatelessWidget {
  final String label;
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController postalCodeController;
  final TextEditingController countryController;

  const AddressForm({
    required this.streetController,
    required this.cityController,
    required this.stateController,
    required this.postalCodeController,
    required this.countryController,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColors.secondaryThemeColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildTextField("Street", TextInputType.text, streetController),
          const SizedBox(height: 20),
          _buildTextField("City", TextInputType.text, cityController),
          const SizedBox(height: 20),
          _buildTextField("State", TextInputType.text, stateController),
          const SizedBox(height: 20),
          _buildTextField(
              "Postal Code", TextInputType.number, postalCodeController),
          const SizedBox(height: 20),
          _buildTextField("Country", TextInputType.text, countryController),
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
}
