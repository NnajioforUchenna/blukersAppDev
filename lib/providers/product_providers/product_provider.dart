import 'package:flutter/foundation.dart';
import 'package:blukers/models/product_models/product_model.dart';
import 'package:blukers/data_providers/product_data_providers/product_data_provider.dart';

class ProductProvider with ChangeNotifier {
  final ProductDataProvider _dataProvider = ProductDataProvider();
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  // Initialize the provider by fetching the initial product data
  Future<void> initialize() async {
    _products = await _dataProvider.readAllProducts();
    notifyListeners();
  }

  // Create a new product and update the state
  Future<void> createProduct(ProductModel product) async {
    await _dataProvider.createProduct(product);
    _products.add(product);
    notifyListeners();
  }

  // Read a single product by its ID
  Future<ProductModel?> readProduct(String id) async {
    return await _dataProvider.readProduct(id);
  }

  Future<List<ProductModel>> readAllProducts() async {
    return await _dataProvider.readAllProducts();
  }

  // Update an existing product by its ID
  // Future<void> updateProduct(ProductModel product, String id) async {
  //   await _dataProvider.updateProduct(product, id);
  // }
  Future<void> updateProduct(String id, Map<String, dynamic> data) async {
    await _dataProvider.updateProduct(id, data);
  }

  // // Update an existing product by its ID
  // Future<void> updateProductFields(
  //     Map<String, dynamic> product, String id) async {
  //   print('******* updateProduct provider ********');
  //   print(product);
  //   await _dataProvider.updateProductFields(product, id);
  //   // final index = _products.indexWhere((p) => p.id == product.id);
  //   // if (index != -1) {
  //   //   _products[index] = product;
  //   //   notifyListeners();
  //   // }
  // }

  // Delete a product by its ID
  Future<void> deleteProduct(String id) async {
    await _dataProvider.deleteProduct(id);
    _products.removeWhere((product) => id == id);
    notifyListeners();
  }
}
