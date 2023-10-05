import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blukers/views/common_views/tests_screen/crud/crud_any/crud_read_all.dart';

// import models
import 'package:blukers/models/product_models/product_subcategory_model.dart';

// import providers
import 'package:blukers/providers/product_providers/product_subcategory_provider.dart';

import 'package:blukers/models/my_form_input_model.dart';
import 'package:blukers/views/common_views/tests_screen/crud/components/index.dart';

class ProductSubcategoryReadAll extends StatefulWidget {
  const ProductSubcategoryReadAll({super.key});

  @override
  State<ProductSubcategoryReadAll> createState() =>
      _ProductSubcategoryReadAllState();
}

class _ProductSubcategoryReadAllState extends State<ProductSubcategoryReadAll> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductSubcategoryProvider>(
      context,
      listen: false,
    );

    return MenuButton(
      buttonText: 'PRODUCT SUBCATEGORY - READ ALL',
      widget: CRUDReadAll<ProductSubcategoryModel>(
        datasetTextName: "Product Subcategory",
        getProvider: (context) {
          return provider;
        },
        getDocumentFields: (context, doc, formValues) {
          Map<String, dynamic> documentFields = {
            "name": formValues['name'] ?? doc.name,
            "description": formValues['description'] ?? doc.description,
            "imageUrl": formValues['imageUrl'] ?? doc.imageUrl,
            "categoryIds": formValues['categoryIds'] ?? doc.categoryIds,
          };
          return documentFields;
        },
        updateDocument: (context, doc, documentFields) async {
          await provider.updateProductSubcategory(doc.id, documentFields);
        },
        deleteDocument: (context, doc) async {
          await provider.deleteProductSubcategory(doc.id);
        },
        getReadAllProviderFunction: (context) async {
          return provider.readAllProductSubcategories();
        },
        getDocumentFieldsToRead: (item) {
          return [
            const Text('PRODUCT SUBCATEGORY'),
            const SizedBox(height: 10),
            Text('Name: ${item.name}'),
            const SizedBox(height: 10),
            Text('Description: ${item.description}'),
            const SizedBox(height: 10),
            Text('Image Url: ${item.imageUrl}'),
            const SizedBox(height: 10),
            const Text('Parent Categories:'),
            if (item.categoryIds != null && item.categoryIds.isNotEmpty)
              RenderTextItems(itemsList: item.categoryIds)
          ];
        },
        getCardDisplayField: (doc) {
          return doc.name;
        },
        getInputElements: (item) => [
          MyFormInputModel(
            type: 'textfield',
            name: 'name',
            label: 'Product Subcategory Name:',
            // placeholder: 'I.E.: Shoes',
            initialValue: item.name ?? '',
            validationRules: ['required'],
          ),
          MyFormInputModel(
            type: 'textarea',
            name: 'description',
            label: 'Product Subcategory Description:',
            // placeholder: 'I.E.: Man shoes for work',
            initialValue: item.description ?? '',
          ),
          MyFormInputModel(
            type: 'textfield',
            name: 'imageUrl',
            label: 'Product Subcategory Image Url:',
            // placeholder: '',
            initialValue: item.imageUrl ?? '',
          ),
          MyFormInputModel(
            type: 'checkbox',
            name: 'categoryIds',
            label: 'Select parent categories',
            placeholder: '',
            initialValue: item.categoryIds,
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
