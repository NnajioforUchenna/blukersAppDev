import 'package:blukers/providers/worker_provider.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/worker/create_worker_profile_component/show_pdf_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CredentialField extends StatefulWidget {
  final int index;
  const CredentialField({Key? key, required this.index}) : super(key: key);

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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      WorkerProvider wp = Provider.of<WorkerProvider>(context, listen: false);
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
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
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
              child: ElevatedButton(
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.blukersOrangeThemeColor,
                ),
                child: Text(AppLocalizations.of(context)!.upload),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: isFileUploaded
                    ? () {
                        print(filePlatformFile!.name);
                        showDialog(
                            context: context,
                            builder: (_) => ShowPdfDialog(
                                  pdfFile: filePlatformFile!,
                                ));
                      }
                    : null,
                child: Text(AppLocalizations.of(context)!.view),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
