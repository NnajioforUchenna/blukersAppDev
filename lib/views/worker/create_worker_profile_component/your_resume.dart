import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/worker_provider.dart';
import 'ShowPDF.dart';

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
    String? logoUrl = wp.appUser?.photoUrl;
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
                  Map<String, dynamic> result = await wp.uploadCredential();
                  String url = result['url'];

                  if (url.isNotEmpty) {
                    setState(() {
                      fileNameUrl = url;
                      isFileUploaded = true;
                      filePlatformFile = result['file'];
                    });
                  }
                },
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: !isFileUploaded
                      ? const Center(
                          child: Text(
                            'Tap to select a resume',
                            style: TextStyle(
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
