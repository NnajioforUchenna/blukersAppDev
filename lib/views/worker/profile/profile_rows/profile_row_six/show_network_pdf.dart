import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowNetworkPDF extends StatelessWidget {
  final String remotePath;
  const ShowNetworkPDF({super.key, required this.remotePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SfPdfViewer.network(remotePath),
    );
  }
}
