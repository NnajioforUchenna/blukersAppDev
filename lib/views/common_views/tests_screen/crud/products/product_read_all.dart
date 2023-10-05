import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blukers/views/common_views/tests_screen/crud/crud_any/crud_read_all.dart';

// import models
import 'package:blukers/models/product_models/product_model.dart';

// import providers
import 'package:blukers/providers/product_providers/product_provider.dart';

import 'package:blukers/models/my_form_input_model.dart';
import 'package:blukers/views/common_views/tests_screen/crud/components/index.dart';

class ProductReadAll extends StatefulWidget {
  const ProductReadAll({super.key});

  @override
  State<ProductReadAll> createState() => _ProductReadAllState();
}

class _ProductReadAllState extends State<ProductReadAll> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );

    return MenuButton(
      buttonText: 'PRODUCT - READ ALL',
      widget: CRUDReadAll<ProductModel>(
        datasetTextName: "Product",
        getProvider: (context) {
          return provider;
        },
        getDocumentFields: (context, doc, formValues) {
          Map<String, dynamic> documentFields = {
            "name": formValues['name'] ?? doc.name,
            "description": formValues['description'] ?? doc.description,
            "type": formValues['type'] ?? doc.type,
            "sku": formValues['sku'] ?? doc.sku,
          };
          return documentFields;
        },
        updateDocument: (context, doc, documentFields) async {
          await provider.updateProduct(doc.id, documentFields);
        },
        deleteDocument: (context, doc) async {
          await provider.deleteProduct(doc.id);
        },
        getReadAllProviderFunction: (context) async {
          return provider.readAllProducts();
        },
        getDocumentFieldsToRead: (item) {
          return [
            const Text('PRODUCT'),
            const SizedBox(height: 10),
            Text('Name: ${item.name}'),
            const SizedBox(height: 10),
            Text('Description: ${item.description}'),
            const SizedBox(height: 10),
            Text('Type: ${item.type}'),
            const SizedBox(height: 10),
            Text('SKU: ${item.sku}'),
          ];
        },
        getCardDisplayField: (doc) {
          return doc.name;
        },
        getInputElements: (item) => [
          MyFormInputModel(
            type: 'textfield',
            name: 'name',
            label: 'Product Name:',
            placeholder: 'I.E.: Shoes',
            initialValue: item.name ?? '',
          ),
          MyFormInputModel(
            type: 'textarea',
            name: 'description',
            label: 'Product Description:',
            placeholder: 'I.E.: Man shoes for work',
            initialValue: item.description ?? '',
          ),
          MyFormInputModel(
            type: 'dropdown',
            name: 'type',
            label: 'Select product type',
            placeholder: '',
            // initialValue: '2',
            options: [
              {"text": "Type 1", "value": 1},
              {"text": "Type 2", "value": 2},
              {"text": "Type 3", "value": 3},
            ],
            initialValue: item.type ?? '',
            validationRules: ['required'],
          ),
          MyFormInputModel(
            type: 'textfield',
            name: 'sku',
            label: 'Product SKU:',
            placeholder:
                'I.E.: ABCD1234. An SKU, short for "stock keeping unit", is a unique number combination used by retailers to identify and track products',
            initialValue: item.sku ?? '',
          ),
        ],
      ),
    );
  }
}
