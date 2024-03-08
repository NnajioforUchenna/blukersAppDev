import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/product_models/product_subcategory_model.dart';
import '../data_constants.dart';

class ProductSubcategoryDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = productSubcategoriesCollection;

  Future<void> createProductSubcategory(
      ProductSubcategoryModel productSubcategory) async {
    final data = productSubcategory.toMap();
    // Generate a unique subcategory ID
    final id = _firestore.collection(collectionName).doc().id;
    // Save the subcategory ID in the data map
    data['id'] = id;
    // Add the subcategory document to Firestore with the specified subcategory ID
    await _firestore.collection(collectionName).doc(id).set(data);
  }

  Future<ProductSubcategoryModel?> readProductSubcategory(String id) async {
    final DocumentSnapshot productSubcategorySnapshot =
        await _firestore.collection(collectionName).doc(id).get();

    if (productSubcategorySnapshot.exists) {
      return ProductSubcategoryModel.fromFirestore(productSubcategorySnapshot);
    } else {
      return null;
    }
  }

  Future<List<ProductSubcategoryModel>> readAllProductSubcategories() async {
    // ### Less lines
    final QuerySnapshot querySnapshot =
        await _firestore.collection(collectionName).get();
    return querySnapshot.docs
        .map((doc) => ProductSubcategoryModel.fromFirestore(doc))
        .toList();
  }

  // Future<void> updateProductSubcategory(
  //     ProductSubcategoryModel productSubcategory, String id) async {
  //   final data = productSubcategory.toMap();
  //   await _firestore.collection(collectionName).doc(id).update(data);
  // }
  Future<void> updateProductSubcategory(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionName).doc(id).update(data);
  }

  Future<void> deleteProductSubcategory(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }
}
