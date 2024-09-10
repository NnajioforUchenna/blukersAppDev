import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:csc_picker/csc_picker.dart'; // Make sure to import the CSCPicker package

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
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.deepOrange),
          ),
          const SizedBox(height: 40),

          // CSCPicker for country, state, city comes first with white dropdowns
          Material(
            color: Colors.white,
            // Change this to your desired background color
            child: Padding(
              padding: const EdgeInsets.all(
                  16.0), // Add padding around the entire widget
              child: Column(
                children: [
                  CSCPicker(
                    layout: Layout.vertical,
                    flagState: CountryFlag.ENABLE,
                    onCountryChanged: (country) {
                      setState(() {
                        widget.countryController.text = country;
                      });
                      widget.validate();
                    },
                    onStateChanged: (state) {
                      setState(() {
                        widget.stateController.text = state ?? '';
                      });
                      widget.validate();
                    },
                    onCityChanged: (city) {
                      setState(() {
                        widget.cityController.text = city ?? '';
                      });
                      widget.validate();
                    },
                    countrySearchPlaceholder: "Country",
                    stateSearchPlaceholder: "State",
                    citySearchPlaceholder: "City",
                    countryDropdownLabel: "Select Country",
                    stateDropdownLabel: "Select State",
                    cityDropdownLabel: "Select City",
                    dropdownDialogRadius: 12.0,
                    searchBarRadius: 30.0,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    disabledDropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey[200],
                    ),
                  ),
                  // Add space between dropdowns
                ],
              ),
            ),
          ),

          SizedBox(
            width: 553,
            child: Stack(
              children: [
                AuthInput(
                  child: TextFormField(
                    controller: widget.streetController,
                    onChanged: (value) {
                      setState(() {
                        _showOptions =
                            true; // Show suggestions when there is text
                      });
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        _showOptions = false;
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
                  firstChild: Container(),
                  secondChild: Container(),
                  crossFadeState: _showOptions
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 500),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Postal Code input field
          _buildTextField(AppLocalizations.of(context)!.postalCode,
              TextInputType.text, widget.postalCodeController),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, TextInputType type, TextEditingController controller) {
    return SizedBox(
      width: 553,
      child: AuthInput(
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            setState(() {
              _showOptions = false;
            });
            widget.validate();
          },
          keyboardType: TextInputType.number, // Set keyboard type to number
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter
                .digitsOnly, // Restrict input to digits only
          ],
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
      ),
    );
  }
}
