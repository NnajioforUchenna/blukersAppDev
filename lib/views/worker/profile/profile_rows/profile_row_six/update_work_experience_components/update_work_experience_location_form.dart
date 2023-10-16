import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UpdateWorkExperienceLocationForm extends StatefulWidget {
  final int intialIndex;
  const UpdateWorkExperienceLocationForm(
      {super.key, required this.intialIndex});

  @override
  State<UpdateWorkExperienceLocationForm> createState() =>
      _UpdateWorkExperienceLocationFormState();
}

class _UpdateWorkExperienceLocationFormState
    extends State<UpdateWorkExperienceLocationForm> {
  final TextEditingController cityController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check if the widget is still in the widget tree
      if (mounted) {
        UserProvider up = Provider.of<UserProvider>(context, listen: false);
        cityController.text =
            up.workExperiences[widget.intialIndex]['city'] ?? '';
        stateController.text =
            up.workExperiences[widget.intialIndex]['state'] ?? '';
        countryController.text =
            up.workExperiences[widget.intialIndex]['country'] ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    UserProvider up = Provider.of<UserProvider>(context);

    return Row(
      children: [
        // City Input
        Expanded(
          child: TextInputWigdet(
            label: AppLocalizations.of(context)!.city,
            maxlines: 1,
            controller: cityController,
            onChanged: (value) {
              up.workExperiences[widget.intialIndex]['city'] = value;
            },
          ),
        ),
        const SizedBox(width: 10),
        // State Input
        Expanded(
            child: TextInputWigdet(
                label: AppLocalizations.of(context)!.state,
                maxlines: 1,
                controller: stateController,
                onChanged: (value) {
                  up.workExperiences[widget.intialIndex]['state'] = value;
                })),
        const SizedBox(width: 10),
        // Country Input
        Expanded(
            child: TextInputWigdet(
                label: AppLocalizations.of(context)!.country,
                maxlines: 1,
                controller: countryController,
                onChanged: (value) {
                  up.workExperiences[widget.intialIndex]['country'] = value;
                })),
      ],
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
