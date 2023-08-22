import 'package:blukers/views/common_views/address_form/show_suggestions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../providers/industry_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../auth/common_widget/auth_input.dart';

class AddressForm extends StatefulWidget {
  final String label;
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController postalCodeController;
  final TextEditingController countryController;
  final Function validate;

  const AddressForm({
    required this.streetController,
    required this.cityController,
    required this.stateController,
    required this.postalCodeController,
    required this.countryController,
    required this.label,
    required this.validate,
  });

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  bool _showOptions = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _initialize();
    });
  }

  void _initialize() {
    IndustriesProvider ip =
        Provider.of<IndustriesProvider>(context, listen: false);
    if (ip.isSelectedAddress) {
      widget.streetController.text = ip.selectedAddress['street'] ?? '';
      widget.cityController.text = ip.selectedAddress['city'] ?? '';
      widget.stateController.text = ip.selectedAddress['state'] ?? '';
      widget.postalCodeController.text = ip.selectedAddress['postalCode'] ?? '';
      widget.countryController.text = ip.selectedAddress['country'] ?? '';
      widget.validate();
      ip.isSelectedAddress = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColors.secondaryThemeColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Stack(
            children: [
              AuthInput(
                child: TextFormField(
                  controller: widget.streetController,
                  onChanged: (value) {
                    ip.getPredictions(value);
                    setState(() {
                      _showOptions =
                          true; // Show suggestions when there is text
                    });
                  },
                  onFieldSubmitted: (value) {
                    setState(() {
                      _showOptions =
                          false; // Hide suggestions when user submits the field
                    });
                    widget.validate();
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.street,
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
              ),
              AnimatedCrossFade(
                  firstChild: ShowSuggestions(),
                  secondChild: Container(),
                  crossFadeState: _showOptions
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 500)),
            ],
          ),
          const SizedBox(height: 20),
          _buildTextField(AppLocalizations.of(context)!.city,
              TextInputType.text, widget.cityController),
          const SizedBox(height: 20),
          _buildTextField(AppLocalizations.of(context)!.state,
              TextInputType.text, widget.stateController),
          const SizedBox(height: 20),
          _buildTextField(AppLocalizations.of(context)!.postalCode,
              TextInputType.number, widget.postalCodeController),
          const SizedBox(height: 20),
          _buildTextField(AppLocalizations.of(context)!.country,
              TextInputType.text, widget.countryController),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, TextInputType type, TextEditingController controller) {
    return AuthInput(
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          setState(() {
            _showOptions = false;
          });
          widget.validate();
        },
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
