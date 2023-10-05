import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blukers/views/common_views/tests_screen/crud/crud_any/crud_create.dart';

// import models
import 'package:blukers/models/product_models/product_category_model.dart';

// import providers
import 'package:blukers/providers/product_providers/product_category_provider.dart';

import 'package:blukers/models/my_form_input_model.dart';
import 'package:blukers/views/common_views/tests_screen/crud/components/index.dart';

class ProductCategoryCreate extends StatefulWidget {
  const ProductCategoryCreate({super.key});

  @override
  State<ProductCategoryCreate> createState() => _ProductCategoryCreateState();
}

class _ProductCategoryCreateState extends State<ProductCategoryCreate> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductCategoryProvider>(
      context,
      listen: false,
    );

    return MenuButton(
      buttonText: 'PRODUCT CATEGORY - CREATE',
      widget: CRUDCreate(
        datasetTextName: "Product Category",
        getProvider: (context) {
          return provider;
        },
        getDocumentFields: (context, formValues) {
          final documentFields = ProductCategoryModel(
            name: formValues['name'],
            description: formValues['description'],
            imageUrl: formValues['imageUrl'],
          );
          return documentFields;
        },
        createDocument: (context, documentFields) async {
          await provider.createProductCategory(documentFields);
        },
        getInputElements: () => [
          MyFormInputModel(
            type: 'textfield',
            name: 'name',
            label: 'Product Category Name:',
            placeholder: 'I.E.: Services',
            // initialValue: 'name@company.com',
          ),
          MyFormInputModel(
            type: 'textarea',
            name: 'description',
            label: 'Product Category Description:',
            placeholder: 'I.E.: List of services we offer',
            // initialValue: 'name@company.com',
          ),
          MyFormInputModel(
            type: 'textfield',
            name: 'imageUrl',
            label: 'Product Category Image Url:',
            placeholder: '',
            // initialValue: '',
          ),
        ],
      ),
    );
  }
}
