import 'package:blukers/providers/create_worker_profile_provider.dart';
import 'package:blukers/utils/styles/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../auth/common_widget/auth_input.dart';

class ReferenceFormWidget extends StatefulWidget {
  final int index;

  const ReferenceFormWidget({
    super.key,
    required this.index,
  });

  @override
  State<ReferenceFormWidget> createState() => _ReferenceFormWidgetState();
}

class _ReferenceFormWidgetState extends State<ReferenceFormWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();

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
        _nameController.text = wp.references[widget.index]['name'] ?? '';
        _phoneNumberController.text =
            wp.references[widget.index]['phoneNumber'] ?? '';
        _emailController.text = wp.references[widget.index]['email'] ?? '';
        _relationshipController.text =
            wp.references[widget.index]['relationship'] ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    // WorkersProvider wp = Provider.of<WorkersProvider>(context);
    CreateWorkerProfileProvider wp =
        Provider.of<CreateWorkerProfileProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            // Text(
            //   "${AppLocalizations.of(context)!.personalReferences} #${widget.index + 1}",
            //   textAlign: TextAlign.center,
            //   style: const TextStyle(
            //     color: Colors.deepOrangeAccent,
            //     fontSize: 25,
            //     fontWeight: FontWeight.w600,
            //     height: 1.25,
            //   ),
            // ),
            // const SizedBox(height: 10),
            // const Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.name,
                style: const TextStyle(
                  color: ThemeColors.black1ThemeColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 10),
            AuthInput(
              child: TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
                validator: (value) => value!.isEmpty
                    ? AppLocalizations.of(context)!.required
                    : null,
                onChanged: (value) {
                  wp.references[widget.index]['name'] = value;
                },
                decoration: InputDecoration(
                  //hintText: AppLocalizations.of(context)!.name,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                        color: ThemeColors.black1ThemeColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                        color: ThemeColors.black1ThemeColor),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Contact Address",
                style: TextStyle(
                  color: ThemeColors.black1ThemeColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 10),
            AuthInput(
              child: TextFormField(
                controller: _phoneNumberController,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
                validator: (value) => value!.isEmpty
                    ? AppLocalizations.of(context)!.required
                    : null,
                onChanged: (value) {
                  wp.references[widget.index]['phoneNumber'] = value;
                },
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.phoneNumber,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                        color: ThemeColors.black1ThemeColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                        color: ThemeColors.black1ThemeColor),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            AuthInput(
              child: TextFormField(
                controller: _emailController,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
                validator: (value) => value!.isEmpty
                    ? AppLocalizations.of(context)!.required
                    : null,
                onChanged: (value) {
                  wp.references[widget.index]['email'] = value;
                },
                decoration: InputDecoration(
                  hintText: "sample@gmail.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                        color: ThemeColors.black1ThemeColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                        color: ThemeColors.black1ThemeColor),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.relationship,
                style: const TextStyle(
                  color: ThemeColors.black1ThemeColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 10),
            AuthInput(
              child: TextFormField(
                controller: _relationshipController,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
                validator: (value) => value!.isEmpty
                    ? AppLocalizations.of(context)!.required
                    : null,
                onChanged: (value) {
                  wp.references[widget.index]['relationship'] = value;
                },
                decoration: InputDecoration(
                  // hintText: AppLocalizations.of(context)!.relationship,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                        color: ThemeColors.black1ThemeColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                        color: ThemeColors.black1ThemeColor),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.deepOrangeAccent,
            ),
          ],
        ),
      ),
    );
  }
}
