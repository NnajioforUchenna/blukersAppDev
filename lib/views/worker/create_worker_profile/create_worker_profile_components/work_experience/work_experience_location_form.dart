import 'package:blukers/providers/create_worker_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../auth/common_widget/auth_input.dart';

class WorkExperienceLocationForm extends StatefulWidget {
  final int intialIndex;

  const WorkExperienceLocationForm({super.key, required this.intialIndex});

  @override
  State<WorkExperienceLocationForm> createState() =>
      _WorkExperienceLocationFormState();
}

class _WorkExperienceLocationFormState
    extends State<WorkExperienceLocationForm> {
  final TextEditingController cityController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check if the widget is still in the widget tree
      if (mounted) {
        // WorkersProvider wp =
        //     Provider.of<WorkersProvider>(context, listen: false);

        CreateWorkerProfileProvider wp =
            Provider.of<CreateWorkerProfileProvider>(context, listen: false);

        cityController.text =
            wp.workExperience[widget.intialIndex]['city'] ?? '';
        stateController.text =
            wp.workExperience[widget.intialIndex]['state'] ?? '';
        countryController.text =
            wp.workExperience[widget.intialIndex]['country'] ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    // WorkersProvider wp = Provider.of<WorkersProvider>(context);
    CreateWorkerProfileProvider wp =
        Provider.of<CreateWorkerProfileProvider>(context);

    return Row(
      children: [
        // City Input
        Expanded(
          child: AuthInput(
            child: TextFormField(
              controller: cityController,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => node.nextFocus(),
              validator: (value) => value!.isEmpty
                  ? AppLocalizations.of(context)!.required
                  : null,
              onChanged: (value) {
                wp.workExperience[widget.intialIndex]['city'] = value;
              },
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.city,
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
        ),
        const SizedBox(width: 10),
        // State Input
        Expanded(
          child: AuthInput(
            child: TextFormField(
              controller: stateController,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => node.nextFocus(),
              validator: (value) => value!.isEmpty
                  ? AppLocalizations.of(context)!.required
                  : null,
              onChanged: (value) {
                wp.workExperience[widget.intialIndex]['state'] = value;
              },
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.state,
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
        ),
        const SizedBox(width: 10),
        // Country Input
        Expanded(
          child: AuthInput(
            child: TextFormField(
              controller: countryController,
              textInputAction: TextInputAction.done,
              onEditingComplete: () => node.unfocus(),
              validator: (value) => value!.isEmpty
                  ? AppLocalizations.of(context)!.required
                  : null,
              onChanged: (value) {
                wp.workExperience[widget.intialIndex]['country'] = value;
              },
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.country,
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
        ),
      ],
    );
  }
}
