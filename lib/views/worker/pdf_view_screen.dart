import 'dart:async';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({Key? key}) : super(key: key);

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  // PDFViewController? _pdfViewController;
  String remotePDFpath = "";
  bool loader = false;

  //var docFile;
  int? pages = 0;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    String remotePDFpath = (ModalRoute.of(context)!.settings.arguments
        as Map<String, String>)["remotePDFpath"] as String;
    //docFile = DefaultCacheManager().getSingleFile("https://firebasestorage.googleapis.com/v0/b/Blukers-5275d.appspot.com/o/files%2FDocument%20from%20Jyot%20Vavadiya?alt=media&token=e8da4c45-8050-4022-bc4d-32b6b6703634");
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Resume"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SfPdfViewer.network(remotePDFpath),
        ));
  }
}
