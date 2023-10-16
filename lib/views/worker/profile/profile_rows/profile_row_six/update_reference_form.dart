import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';

class UpdateReferenceForm extends StatefulWidget {
  final int index;
  const UpdateReferenceForm({super.key, required this.index});

  @override
  State<UpdateReferenceForm> createState() => _UpdateReferenceFormState();
}

class _UpdateReferenceFormState extends State<UpdateReferenceForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Check if the widget is still in the widget tree
      if (mounted) {
        UserProvider up = Provider.of<UserProvider>(context, listen: false);
        _nameController.text = up.references[widget.index]['name'] ?? '';
        _phoneNumberController.text =
            up.references[widget.index]['phoneNumber'] ?? '';
        _emailController.text = up.references[widget.index]['email'] ?? '';
        _relationshipController.text =
            up.references[widget.index]['relationship'] ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    UserProvider up = Provider.of<UserProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.personalReferences +
                  " #${widget.index + 1}",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.deepOrangeAccent,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            TextInputWigdet(
              label: AppLocalizations.of(context)!.name,
              maxlines: 1,
              controller: _nameController,
              onChanged: (value) {
                up.references[widget.index]['name'] = value;
              },
            ),
            const SizedBox(height: 8),
            TextInputWigdet(
              label: AppLocalizations.of(context)!.phoneNumber,
              maxlines: 1,
              controller: _phoneNumberController,
              onChanged: (value) {
                up.references[widget.index]['phoneNumber'] = value;
              },
            ),
            const SizedBox(height: 8),
            TextInputWigdet(
              label: AppLocalizations.of(context)!.email,
              maxlines: 1,
              controller: _emailController,
              onChanged: (value) {
                up.references[widget.index]['email'] = value;
              },
            ),
            const SizedBox(height: 8),
            TextInputWigdet(
              label: AppLocalizations.of(context)!.relationship,
              maxlines: 1,
              controller: _relationshipController,
              onChanged: (value) {
                up.references[widget.index]['relationship'] = value;
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  TextInputWigdet(
      {required String label,
      required int maxlines,
      required TextEditingController controller,
      required Null Function(dynamic value) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            label,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          validator: (value) =>
              value!.isEmpty ? AppLocalizations.of(context)!.required : null,
          onChanged: onChanged,
          maxLines: maxlines,
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        )
      ],
    );
  }
}
