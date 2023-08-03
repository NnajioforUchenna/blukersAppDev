import 'package:bulkers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkExperienceLocationForm extends StatelessWidget {
  final int intialIndex;
  WorkExperienceLocationForm({super.key, required this.intialIndex});

  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    WorkerProvider wp = Provider.of<WorkerProvider>(context);

    return Row(
      children: [
        // City Input
        Expanded(
          child: AuthInput(
            child: TextFormField(
              controller: cityController,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => node.nextFocus(),
              validator: (value) => value!.isEmpty ? "Required" : null,
              onChanged: (value) {
                wp.workExperience[intialIndex]['city'] = value;
              },
              decoration: InputDecoration(
                hintText: "City",
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
              validator: (value) => value!.isEmpty ? "Required" : null,
              onChanged: (value) {
                wp.workExperience[intialIndex]['state'] = value;
              },
              decoration: InputDecoration(
                hintText: "State",
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
              validator: (value) => value!.isEmpty ? "Required" : null,
              onChanged: (value) {
                wp.workExperience[intialIndex]['country'] = value;
              },
              decoration: InputDecoration(
                hintText: "Country",
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

// Assuming AuthInput is a separate widget like this:
class AuthInput extends StatelessWidget {
  final Widget child;

  AuthInput({required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
