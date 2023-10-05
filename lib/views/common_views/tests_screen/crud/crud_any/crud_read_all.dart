import 'package:flutter/material.dart';
import 'forms/crud_create_update_form.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../components/index.dart';

class CRUDReadAll<T> extends StatefulWidget {
  CRUDReadAll({
    super.key,
    this.datasetTextName = 'MODULE',
    required this.getInputElements,
    required this.getProvider,
    required this.getDocumentFields,
    required this.updateDocument,
    required this.deleteDocument,
    required this.getReadAllProviderFunction,
    required this.getDocumentFieldsToRead,
    required this.getCardDisplayField,
    this.child,
  });

  String datasetTextName;
  Function getInputElements;
  Function getProvider;
  Function getDocumentFields;
  Function updateDocument;
  Function deleteDocument;
  Function getReadAllProviderFunction;
  Function getDocumentFieldsToRead;
  Function getCardDisplayField;
  final Widget? child;

  @override
  _CRUDReadAllState createState() => _CRUDReadAllState();
}

class _CRUDReadAllState<T> extends State<CRUDReadAll> {
  bool updateSuccess = false;
  bool deleteSuccess = false;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Read All ' + widget.datasetTextName),
  //     ),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Center(
  //             child: buildFutureBuilder<T>(
  //               context,
  //               () => widget.getReadAllProviderFunction(context),
  //               widget.datasetTextName,
  //               (context, item) {
  //                 return ListTile(
  //                   title: Text(widget.getCardDisplayField(item)),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return buildFutureBuilder<T>(
      context,
      () => widget.getReadAllProviderFunction(context),
      widget.datasetTextName,
      (context, item) {
        return ListTile(
          title: Text(widget.getCardDisplayField(item)),
        );
      },
    );
  }

  void _showDetailsDialog(
    BuildContext context,
    item,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.datasetTextName + ' Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: widget.getDocumentFieldsToRead(item),
          ),
          actions: [
            Container(
              width: double.infinity, // Makes the button expand to full width
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(
    BuildContext context,
    product,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // Add your edit product form or content here
          child: Column(
            children: [
              // Your edit product form fields go here
              Text('EDIT ' + widget.datasetTextName),
              //
              CRUDCreateUpdateForm(
                inputElements: widget.getInputElements(product),
                submitButtonText: "UPDATE",
                onSubmit: (formValues) => handleUpdateOnFormSubmit(
                  context,
                  product,
                  formValues,
                ),
              ),
              // Add any form fields for editing the product
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.of(context).pop(); // Close the edit dialog
              //   },
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              //   ),
              //   child: const Text(
              //     'Close',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
              Container(
                width: double.infinity, // Makes the button expand to full width
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to show a delete confirmation dialog
  void _showDeleteConfirmationDialog(
    BuildContext context,
    document,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text(
              'Are you sure you want to delete ${widget.getCardDisplayField(document)}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the delete confirmation dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform the delete operation here
                handleOnDelete(
                  context,
                  document,
                );
                // After successful delete, you can refresh the document list if needed
                Navigator.of(context)
                    .pop(); // Close the delete confirmation dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  handleUpdateOnFormSubmit(
    context,
    productCategory,
    formValues,
  ) async {
    Map<String, dynamic> documentFields = widget.getDocumentFields(
      context,
      productCategory,
      formValues,
    );

    // Show loading indicator using EasyLoading
    EasyLoading.show(status: 'Updating document...');

    try {
      await widget.updateDocument(context, productCategory, documentFields);
      // Product creation successful
      setState(() {
        updateSuccess = true;
      });
      showSnackBar(context, 'Document updating successfully', true);
    } catch (error) {
      // Product creation failed
      setState(() {
        updateSuccess = false;
      });
      showSnackBar(context, 'Error updating document: $error', false);
    } finally {
      // Dismiss the loading indicator using EasyLoading
      EasyLoading.dismiss();
    }
  }

  handleOnDelete(
    context,
    document,
  ) async {
    // Show loading indicator using EasyLoading
    EasyLoading.show(status: 'Deleting document...');

    try {
      await widget.deleteDocument(context, document);

      // Product creation successful
      setState(() {
        deleteSuccess = true;
      });
      showSnackBar(context, 'Document deleting successfully', true);
    } catch (error) {
      // Product creation failed
      setState(() {
        deleteSuccess = false;
      });
      showSnackBar(context, 'Error deleting document: $error', false);
    } finally {
      // Dismiss the loading indicator using EasyLoading
      EasyLoading.dismiss();
    }
  }

  void showSnackBar(
    BuildContext context,
    String message,
    bool isSuccess,
  ) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  //
  //
  //

  Widget buildFutureBuilder<T>(
    BuildContext context,
    Future<List<T>> Function() fetchDataFunction,
    String datasetTextName,
    Widget Function(BuildContext, T) itemBuilder,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$datasetTextName List'),
      ),
      body: FutureBuilder<List<T>>(
        future: fetchDataFunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data == null) {
            return Center(
              child: Text('No $datasetTextName found'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    // Show details dialog
                    _showDetailsDialog(context, item);
                  },
                  child: Card(
                    child: ListTile(
                      title: itemBuilder(context, item),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Show edit dialog
                              _showEditDialog(context, item);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Show delete confirmation dialog
                              _showDeleteConfirmationDialog(context, item);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  //
  //
  //
}
