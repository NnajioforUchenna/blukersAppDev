import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blukers/views/common_views/tests_screen/crud/crud_any/crud_create.dart';

// import models
import 'package:blukers/models/product_models/product_model.dart';

// import providers
import 'package:blukers/providers/product_providers/product_provider.dart';

import 'package:blukers/models/my_form_input_model.dart';
import 'package:blukers/views/common_views/tests_screen/crud/components/index.dart';

class ProductCreate extends StatefulWidget {
  const ProductCreate({super.key});

  @override
  State<ProductCreate> createState() => _ProductCreateState();
}

class _ProductCreateState extends State<ProductCreate> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );

    return MenuButton(
      buttonText: 'PRODUCT - CREATE',
      widget: CRUDCreate(
        datasetTextName: "Product",
        getProvider: (context) {
          return provider;
        },
        getDocumentFields: (context, formValues) {
          final documentFields = ProductModel(
            name: formValues['name'],
            description: formValues['description'],
            type: formValues['type'],
            sku: formValues['sku'],
          );
          return documentFields;
        },
        createDocument: (context, documentFields) async {
          await provider.createProduct(documentFields);
        },
        getInputElements: () => [
          MyFormInputModel(
            type: 'textfield',
            name: 'name',
            label: 'Product Name:',
            placeholder: 'I.E.: Shoes',
            // initialValue: 'name@company.com',
          ),
          MyFormInputModel(
            type: 'textarea',
            name: 'description',
            label: 'Product Description:',
            placeholder: 'I.E.: Man shoes for work',
            // initialValue: 'name@company.com',
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
            validationRules: ['required'],
          ),
          MyFormInputModel(
            type: 'textfield',
            name: 'sku',
            label: 'Product SKU:',
            placeholder:
                'I.E.: ABCD1234. An SKU, short for "stock keeping unit", is a unique number combination used by retailers to identify and track products',
            // initialValue: '',
          ),
        ],
      ),
    );
  }
}
