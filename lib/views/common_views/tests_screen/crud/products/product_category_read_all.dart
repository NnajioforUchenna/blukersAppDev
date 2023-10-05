import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blukers/views/common_views/tests_screen/crud/crud_any/crud_read_all.dart';

// import models
import 'package:blukers/models/product_models/product_category_model.dart';

// import providers
import 'package:blukers/providers/product_providers/product_category_provider.dart';

import 'package:blukers/models/my_form_input_model.dart';
import 'package:blukers/views/common_views/tests_screen/crud/components/index.dart';

class ProductCategoryReadAll extends StatefulWidget {
  const ProductCategoryReadAll({super.key});

  @override
  State<ProductCategoryReadAll> createState() => _ProductCategoryReadAllState();
}

class _ProductCategoryReadAllState extends State<ProductCategoryReadAll> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductCategoryProvider>(
      context,
      listen: false,
    );

    return MenuButton(
      buttonText: 'PRODUCT CATEGORY - READ ALL',
      widget: CRUDReadAll<ProductCategoryModel>(
        datasetTextName: "Product Category",
        getProvider: (context) {
          return provider;
        },
        getDocumentFields: (context, doc, formValues) {
          Map<String, dynamic> documentFields = {
            "name": formValues['name'] ?? doc.name,
            "description": formValues['description'] ?? doc.description,
            "imageUrl": formValues['imageUrl'] ?? doc.imageUrl,
          };
          return documentFields;
        },
        updateDocument: (context, doc, documentFields) async {
          await provider.updateProductCategory(doc.id, documentFields);
        },
        deleteDocument: (context, doc) async {
          await provider.deleteProductCategory(doc.id);
        },
        getReadAllProviderFunction: (context) async {
          return provider.readAllProductCategories();
        },
        getDocumentFieldsToRead: (item) {
          return [
            const Text('PRODUCT CATEGORY'),
            const SizedBox(height: 10),
            Text('Name: ${item.name}'),
            const SizedBox(height: 10),
            Text('Description: ${item.description}'),
            const SizedBox(height: 10),
            Text('Image Url: ${item.imageUrl}'),
          ];
        },
        getCardDisplayField: (doc) {
          return doc.name;
        },
        getInputElements: (item) => [
          MyFormInputModel(
            type: 'textfield',
            name: 'name',
            label: 'Product Category Name:',
            placeholder: 'I.E.: Shoes',
            initialValue: item.name ?? '',
          ),
          MyFormInputModel(
            type: 'textarea',
            name: 'description',
            label: 'Product Category Description:',
            placeholder: 'I.E.: Man shoes for work',
            initialValue: item.description ?? '',
          ),
          MyFormInputModel(
            type: 'textfield',
            name: 'imageUrl',
            label: 'Product Category Image Url:',
            placeholder: '',
            initialValue: item.imageUrl ?? '',
          ),
        ],
      ),
    );
  }
}
