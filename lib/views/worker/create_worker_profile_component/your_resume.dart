import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/worker_provider.dart';
import 'ShowPDF.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class YourResume extends StatefulWidget {
  YourResume({Key? key}) : super(key: key);

  @override
  State<YourResume> createState() => _YourResumeState();
}

class _YourResumeState extends State<YourResume> {
  String? fileNameUrl;

  bool isFileUploaded = false;

  PlatformFile? filePlatformFile;

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              InkWell(
                onTap: () async {
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
                  }
                  wp.setResumeUrl(fileNameUrl!);
                },
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: !isFileUploaded
                      ? Center(
                          child: Text(
                            AppLocalizations.of(context)!
                                .tapToSelectAndUploadAFile,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : ShowPDF(pdf: filePlatformFile!),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
