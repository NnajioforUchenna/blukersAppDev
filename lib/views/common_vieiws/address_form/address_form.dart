import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../providers/industry_provider.dart';
import '../../auth/common_widget/auth_input.dart';

class AddressForm extends StatefulWidget {
  final String label;
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController postalCodeController;
  final TextEditingController countryController;
   final bool enabled;
  final Function validate;

  const AddressForm({
    super.key,
    required this.streetController,
    required this.cityController,
    required this.stateController,
    this.enabled = true,
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    return SizedBox(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.black12),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.label,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepOrange,)),
            const SizedBox(height: 10),
            Stack(
              children: [
                AuthInput(
                  child: TextFormField(
                    controller: widget.streetController,
                    onChanged: (value) {
                      // ip.getPredictions(value);
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
                    firstChild: Container(), // ShowSuggestions()
                    secondChild: Container(),
                    crossFadeState: _showOptions
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 500)),
              ],
            ),
            const SizedBox(height: 45),
            _buildTextField(AppLocalizations.of(context)!.city,
                TextInputType.text, widget.cityController),
            const SizedBox(height: 45),
            _buildTextField(AppLocalizations.of(context)!.state,
                TextInputType.text, widget.stateController),
            const SizedBox(height: 45),
            _buildTextField(AppLocalizations.of(context)!.postalCode,
                TextInputType.number, widget.postalCodeController),
            const SizedBox(height: 45),
            _buildTextField(AppLocalizations.of(context)!.country,
                TextInputType.text, widget.countryController),
          ],
        ),
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
