import 'package:flutter/foundation.dart';
import '../../models/product_models/product_subcategory_model.dart';
import '../../data_providers/product_data_providers/product_subcategory_data_provider.dart';

class ProductSubcategoryProvider with ChangeNotifier {
  final ProductSubcategoryDataProvider _dataProvider =
      ProductSubcategoryDataProvider();
  List<ProductSubcategoryModel> _productSubcategory = [];

  List<ProductSubcategoryModel> get productSubcategory => _productSubcategory;

  // Initialize the provider by fetching the initial productSubcategory data
  Future<void> initialize() async {
    _productSubcategory = await _dataProvider.readAllProductSubcategories();
    notifyListeners();
  }

  // Create a new productSubcategory and update the state
  Future<void> createProductSubcategory(
      ProductSubcategoryModel productSubcategory) async {
    await _dataProvider.createProductSubcategory(productSubcategory);
    _productSubcategory.add(productSubcategory);
    notifyListeners();
  }

  // Read a single productSubcategory by its ID
  Future<ProductSubcategoryModel?> readProductSubcategory(String id) async {
    return await _dataProvider.readProductSubcategory(id);
  }

  Future<List<ProductSubcategoryModel>> readAllProductSubcategories() async {
    return await _dataProvider.readAllProductSubcategories();
  }

  // Update an existing productSubcategory by its ID
  Future<void> updateProductSubcategory(
      String id, Map<String, dynamic> data) async {
    await _dataProvider.updateProductSubcategory(id, data);
  }

  // Delete a productSubcategory by its ID
  Future<void> deleteProductSubcategory(String id) async {
    await _dataProvider.deleteProductSubcategory(id);
    _productSubcategory.removeWhere((productSubcategory) => id == id);
    notifyListeners();
  }
}
