import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blukers/views/common_views/tests_screen/crud/crud_any/crud_create.dart';

// import models
import 'package:blukers/models/product_models/product_subcategory_model.dart';

// import providers
import 'package:blukers/providers/product_providers/product_subcategory_provider.dart';

import 'package:blukers/models/my_form_input_model.dart';
import 'package:blukers/views/common_views/tests_screen/crud/components/index.dart';

class ProductSubcategoryCreate extends StatefulWidget {
  const ProductSubcategoryCreate({super.key});

  @override
  State<ProductSubcategoryCreate> createState() =>
      _ProductSubcategoryCreateState();
}

class _ProductSubcategoryCreateState extends State<ProductSubcategoryCreate> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductSubcategoryProvider>(
      context,
      listen: false,
    );

    return MenuButton(
      buttonText: 'PRODUCT SUBCATEGORY - CREATE',
      widget: CRUDCreate(
        datasetTextName: "Product Subcategory",
        getProvider: (context) {
          return provider;
        },
        getDocumentFields: (context, formValues) {
          final documentFields = ProductSubcategoryModel(
            name: formValues['name'],
            description: formValues['description'],
            imageUrl: formValues['imageUrl'],
            categoryIds: formValues['categoryIds'],
          );
          return documentFields;
        },
        createDocument: (context, documentFields) async {
          await provider.createProductSubcategory(documentFields);
        },
        getInputElements: () => [
          MyFormInputModel(
            type: 'textfield',
            name: 'name',
            label: 'Product Subcategory Name:',
            placeholder: 'I.E.: Immigration',
            // initialValue: 'name@company.com',
          ),
          MyFormInputModel(
            type: 'textarea',
            name: 'description',
            label: 'Product Subcategory Description:',
            placeholder: 'I.E.: List of immigration services we offer',
            // initialValue: 'name@company.com',
          ),
          MyFormInputModel(
            type: 'textfield',
            name: 'imageUrl',
            label: 'Product Subcategory Image Url:',
            placeholder: '',
            // initialValue: '',
          ),
          MyFormInputModel(
            type: 'checkbox',
            // type: 'filterChip',
            name: 'categoryIds',
            label: 'Select parent categories',
            placeholder: '',
            // initialValue: '2',
            options: [
              {"text": "Category 1", "value": 1},
              {"text": "Category 2", "value": 2},
              {"text": "Category 3", "value": 3},
            ],
            validationRules: ['required'],
          ),
        ],
      ),
    );
  }
}
