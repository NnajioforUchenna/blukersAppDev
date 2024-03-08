import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/product_models/product_status_model.dart';
import '../data_constants.dart';

class ProductStatusDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = productStatusesCollection;

  Future<void> createProductStatus(ProductStatusModel productStatus) async {
    final data = productStatus.toMap();
    // Generate a unique status ID
    final id = _firestore.collection(collectionName).doc().id;
    // Save the status ID in the data map
    data['id'] = id;
    // Add the status document to Firestore with the specified status ID
    await _firestore.collection(collectionName).doc(id).set(data);
  }

  Future<ProductStatusModel?> readProductStatus(String id) async {
    final DocumentSnapshot productStatusSnapshot =
        await _firestore.collection(collectionName).doc(id).get();

    if (productStatusSnapshot.exists) {
      return ProductStatusModel.fromFirestore(productStatusSnapshot);
    } else {
      return null;
    }
  }

  Future<List<ProductStatusModel>> readAllProductStatuses() async {
    // ### Less lines
    final QuerySnapshot querySnapshot =
        await _firestore.collection(collectionName).get();
    return querySnapshot.docs
        .map((doc) => ProductStatusModel.fromFirestore(doc))
        .toList();
  }

  // Future<void> updateProductStatus(
  //     ProductStatusModel productStatus, String id) async {
  //   final data = productStatus.toMap();
  //   await _firestore.collection(collectionName).doc(id).update(data);
  // }
  Future<void> updateProductStatus(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionName).doc(id).update(data);
  }

  Future<void> deleteProductStatus(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }
}
