import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowPDF extends StatelessWidget {
  final PlatformFile pdf;
  const ShowPDF({super.key, required this.pdf});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.8,
      child: SfPdfViewer.memory(pdf.bytes!),
    );
  }
}
