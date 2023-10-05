import 'package:flutter/foundation.dart';
import 'package:blukers/models/product_models/product_status_model.dart';
import 'package:blukers/data_providers/product_data_providers/product_status_data_provider.dart';

class ProductStatusProvider with ChangeNotifier {
  final ProductStatusDataProvider _dataProvider = ProductStatusDataProvider();
  List<ProductStatusModel> _productStatus = [];

  List<ProductStatusModel> get productStatus => _productStatus;

  // Initialize the provider by fetching the initial productStatus data
  Future<void> initialize() async {
    _productStatus = await _dataProvider.readAllProductStatuses();
    notifyListeners();
  }

  // Create a new productStatus and update the state
  Future<void> createProductStatus(ProductStatusModel productStatus) async {
    await _dataProvider.createProductStatus(productStatus);
    _productStatus.add(productStatus);
    notifyListeners();
  }

  // Read a single productStatus by its ID
  Future<ProductStatusModel?> readProductStatus(String id) async {
    return await _dataProvider.readProductStatus(id);
  }

  Future<List<ProductStatusModel>> readAllProductStatuses() async {
    return await _dataProvider.readAllProductStatuses();
  }

  Future<void> updateProductStatus(String id, Map<String, dynamic> data) async {
    await _dataProvider.updateProductStatus(id, data);
  }

  // Delete a productStatus by its ID
  Future<void> deleteProductStatus(String id) async {
    await _dataProvider.deleteProductStatus(id);
    _productStatus.removeWhere((productStatus) => id == id);
    notifyListeners();
  }
}
