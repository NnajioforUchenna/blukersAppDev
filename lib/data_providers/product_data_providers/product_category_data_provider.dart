import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/product_models/product_category_model.dart';
import '../data_constants.dart';

class ProductCategoryDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = productCategoriesCollection;

  Future<void> createProductCategory(
      ProductCategoryModel productCategory) async {
    final data = productCategory.toMap();
    // Generate a unique category ID
    final id = _firestore.collection(collectionName).doc().id;
    // Save the category ID in the data map
    data['id'] = id;
    // Add the category document to Firestore with the specified category ID
    await _firestore.collection(collectionName).doc(id).set(data);
  }

  Future<ProductCategoryModel?> readProductCategory(String id) async {
    final DocumentSnapshot productCategorySnapshot =
        await _firestore.collection(collectionName).doc(id).get();

    if (productCategorySnapshot.exists) {
      return ProductCategoryModel.fromFirestore(productCategorySnapshot);
    } else {
      return null;
    }
  }

  Future<List<ProductCategoryModel>> readAllProductCategories() async {
    // ### Less lines
    final QuerySnapshot querySnapshot =
        await _firestore.collection(collectionName).get();
    return querySnapshot.docs
        .map((doc) => ProductCategoryModel.fromFirestore(doc))
        .toList();
  }

  // Future<void> updateProductCategory(
  //     ProductCategoryModel productCategory, String id) async {
  //   final data = productCategory.toMap();
  //   await _firestore.collection(collectionName).doc(id).update(data);
  // }
  Future<void> updateProductCategory(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionName).doc(id).update(data);
  }

  Future<void> deleteProductCategory(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }
}
