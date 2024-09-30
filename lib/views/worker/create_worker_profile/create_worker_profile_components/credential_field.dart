import 'package:blukers/providers/create_worker_profile_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/styles/index.dart';
import 'show_pdf_dialog.dart';

class CredentialField extends StatefulWidget {
  final int index;

  const CredentialField({super.key, required this.index});

  @override
  State<CredentialField> createState() => _CredentialFieldState();
}

class _CredentialFieldState extends State<CredentialField> {
  TextEditingController controller = TextEditingController();
  String? fileNameUrl;
  bool isFileUploaded = false;
  PlatformFile? filePlatformFile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // WorkersProvider wp = Provider.of<WorkersProvider>(context, listen: false);
      CreateWorkerProfileProvider wp =
          Provider.of<CreateWorkerProfileProvider>(context, listen: false);
      controller.text = wp.professionalCredentials[widget.index]['name'] ?? '';
      fileNameUrl = wp.professionalCredentials[widget.index]['url'] ?? '';
      isFileUploaded =
          wp.professionalCredentials[widget.index]['isFileUploaded'] ?? false;
      filePlatformFile =
          wp.professionalCredentials[widget.index]['filePlatformFile'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // WorkersProvider wp = Provider.of<WorkersProvider>(context);
    CreateWorkerProfileProvider wp =
        Provider.of<CreateWorkerProfileProvider>(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  wp.professionalCredentials[widget.index]['name'] = value;
                },
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.name,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: () async {
                  // Upload logic
                  Map<String, dynamic> result = {
                    'url': '',
                  };

                  if (kIsWeb) {
                    result = await wp.uploadCredentialWeb();
                  } else {
                    result = await wp.uploadCredentialMobile();
                  }

                  String url = result['url'];

                  if (url.isNotEmpty) {
                    setState(() {
                      fileNameUrl = url;
                      isFileUploaded = true;
                      filePlatformFile = result['file'];
                    });
                    wp.professionalCredentials[widget.index]['url'] = url;
                    wp.professionalCredentials[widget.index]['isFileUploaded'] =
                        true;
                    wp.professionalCredentials[widget.index]
                        ['filePlatformFile'] = result['file'];
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: ThemeColors.primaryThemeColor,
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: ThemeColors.blukersOrangeThemeColor,
                // ),
                child: Text(
                  AppLocalizations.of(context)!.upload,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: MaterialButton(
                onPressed: isFileUploaded
                    ? () {
                        showDialog(
                            context: context,
                            builder: (_) => ShowPdfDialog(
                                  pdfFile: filePlatformFile!,
                                ));
                      }
                    : () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: isFileUploaded
                    ? ThemeColors.primaryThemeColor
                    : const Color.fromARGB(172, 211, 235, 255),
                child: Text(
                  AppLocalizations.of(context)!.view,
                  style: TextStyle(
                    color: isFileUploaded
                        ? Colors.white
                        : ThemeColors.primaryThemeColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
