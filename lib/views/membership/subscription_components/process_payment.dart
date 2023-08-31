import 'dart:html' as html;

import 'package:flutter/material.dart';

class ProcessStripePayment extends StatefulWidget {
  final String checkOutUrl;
  const ProcessStripePayment({super.key, required this.checkOutUrl});

  @override
  State<ProcessStripePayment> createState() => _ProcessStripePaymentState();
}

class _ProcessStripePaymentState extends State<ProcessStripePayment> {
  late html.IFrameElement _iframeElement;

  @override
  void initState() {
    super.initState();

    _iframeElement = html.IFrameElement()
      ..width = '100%'
      ..height = '100%'
      ..src = widget.checkOutUrl // Using the passed URL here
      ..style.border = 'none';

    // Attach the iframe to the document
    html.window.onLoad.first.then((_) {
      html.document.body!.children.add(_iframeElement);
    });
  }

  @override
  void dispose() {
    // Detach the iframe when the widget is disposed
    _iframeElement.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Empty container as iframe is directly attached to the body
  }
}
