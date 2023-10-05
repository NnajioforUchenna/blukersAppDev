import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'forms/crud_create_update_form.dart';
import '../components/index.dart';

class CRUDCreate extends StatefulWidget {
  CRUDCreate({
    super.key,
    this.datasetTextName = 'MODULE',
    required this.getInputElements,
    required this.getProvider,
    required this.getDocumentFields,
    required this.createDocument,
    this.child,
  });

  String datasetTextName;
  Function getInputElements;
  Function getProvider;
  Function getDocumentFields;
  Function createDocument;
  final Widget? child;

  @override
  CRUDCreateState createState() => CRUDCreateState();
}

class CRUDCreateState extends State<CRUDCreate> {
  bool creationSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New ' + widget.datasetTextName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: buildForm(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavigationButton(Widget widget, buttonText) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => widget),
        );
      },
      child: Text(buttonText),
    );
  }

  Widget buildForm(context) {
    return CRUDCreateUpdateForm(
      inputElements: widget.getInputElements(),
      submitButtonText: "CREATE",
      onSubmit: (formValues) => _handleCreateOnFormSubmit(context, formValues),
    );
  }

  void _handleCreateOnFormSubmit(context, formValues) async {
    final documentFields = widget.getDocumentFields(context, formValues);

    EasyLoading.show(status: 'Creating document...');

    try {
      await widget.createDocument(context, documentFields);

      // Product creation successful
      // creationSuccess = true;
      setState(() {
        creationSuccess = false;
      });
      showSnackBar(context, 'Document created successfully', true);
    } catch (error) {
      // Product creation failed
      // creationSuccess = false;
      setState(() {
        creationSuccess = false;
      });
      showSnackBar(context, 'Error creating document: $error', false);
    } finally {
      EasyLoading.dismiss();
    }
  }

  void showSnackBar(BuildContext context, String message, bool isSuccess) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }
}
