import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowPdfDialog extends StatelessWidget {
  final PlatformFile pdfFile;

  ShowPdfDialog({required this.pdfFile});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: SfPdfViewer.memory(pdfFile.bytes!),
        ),
      ),
    );
  }
}
