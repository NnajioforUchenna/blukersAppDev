import 'package:flutter/foundation.dart';
import 'package:blukers/models/product_models/product_category_model.dart';
import 'package:blukers/data_providers/product_data_providers/product_category_data_provider.dart';

class ProductCategoryProvider with ChangeNotifier {
  final ProductCategoryDataProvider _dataProvider =
      ProductCategoryDataProvider();
  List<ProductCategoryModel> _productCategory = [];

  List<ProductCategoryModel> get productCategory => _productCategory;

  // Initialize the provider by fetching the initial productCategory data
  Future<void> initialize() async {
    _productCategory = await _dataProvider.readAllProductCategories();
    notifyListeners();
  }

  // Create a new productCategory and update the state
  Future<void> createProductCategory(
      ProductCategoryModel productCategory) async {
    await _dataProvider.createProductCategory(productCategory);
    _productCategory.add(productCategory);
    notifyListeners();
  }

  // Read a single productCategory by its ID
  Future<ProductCategoryModel?> readProductCategory(String id) async {
    return await _dataProvider.readProductCategory(id);
  }

  Future<List<ProductCategoryModel>> readAllProductCategories() async {
    return await _dataProvider.readAllProductCategories();
  }

  // Update an existing productCategory by its ID
  Future<void> updateProductCategory(
      String id, Map<String, dynamic> data) async {
    await _dataProvider.updateProductCategory(id, data);
  }

  // Delete a productCategory by its ID
  Future<void> deleteProductCategory(String id) async {
    await _dataProvider.deleteProductCategory(id);
    _productCategory.removeWhere((productCategory) => id == id);
    notifyListeners();
  }
}
