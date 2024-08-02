import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowPdfDialog extends StatelessWidget {
  final PlatformFile pdfFile;

  const ShowPdfDialog({super.key, required this.pdfFile});

  @override
  Widget build(BuildContext context) {
    Uint8List displayBytes = pdfFile.bytes ?? Uint8List(0);
    return Dialog(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: SfPdfViewer.memory(displayBytes),
        ),
      ),
    );
  }
}
