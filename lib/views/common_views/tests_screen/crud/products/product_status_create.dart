import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blukers/views/common_views/tests_screen/crud/crud_any/crud_create.dart';

// import models
import 'package:blukers/models/product_models/product_status_model.dart';

// import providers
import 'package:blukers/providers/product_providers/product_status_provider.dart';

import 'package:blukers/models/my_form_input_model.dart';
import 'package:blukers/views/common_views/tests_screen/crud/components/index.dart';

class ProductStatusCreate extends StatefulWidget {
  const ProductStatusCreate({super.key});

  @override
  State<ProductStatusCreate> createState() => _ProductStatusCreateState();
}

class _ProductStatusCreateState extends State<ProductStatusCreate> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductStatusProvider>(
      context,
      listen: false,
    );

    return MenuButton(
      buttonText: 'PRODUCT STATUS - CREATE',
      widget: CRUDCreate(
        datasetTextName: "Product Status",
        getProvider: (context) {
          return provider;
        },
        getDocumentFields: (context, formValues) {
          final documentFields = ProductStatusModel(
            name: formValues['name'],
            description: formValues['description'],
            imageUrl: formValues['imageUrl'],
          );
          return documentFields;
        },
        createDocument: (context, documentFields) async {
          await provider.createProductStatus(documentFields);
        },
        getInputElements: () => [
          MyFormInputModel(
            type: 'textfield',
            name: 'name',
            label: 'Product Status Name:',
            placeholder: 'I.E.: Shoes',
            // initialValue: 'name@company.com',
          ),
          MyFormInputModel(
            type: 'textarea',
            name: 'description',
            label: 'Product Status Description:',
            placeholder: 'I.E.: Products in stock',
            // initialValue: 'name@company.com',
          ),
          MyFormInputModel(
            type: 'textfield',
            name: 'imageUrl',
            label: 'Product Status Image URL:',
            placeholder: '',
            // initialValue: 'name@company.com',
          ),
        ],
      ),
    );
  }
}