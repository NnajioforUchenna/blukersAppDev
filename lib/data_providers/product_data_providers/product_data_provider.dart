import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/product_models/product_model.dart';
import '../data_constants.dart';

class ProductDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = productsCollection;

  // Future<void> createProduct(ProductModel product) async {
  //   final data = product.toMap();
  //   await _firestore.collection(collectionName).add(data);
  // }
  Future<void> createProduct(ProductModel product) async {
    // final data = product.toMap();
    final data = product.toMapFormatted();
    // Generate a unique product ID
    final id = _firestore.collection(collectionName).doc().id;
    // Save the product ID in the data map
    data['id'] = id;
    // Add the product document to Firestore with the specified product ID
    await _firestore.collection(collectionName).doc(id).set(data);
  }

  Future<ProductModel?> readProduct(String id) async {
    final DocumentSnapshot productSnapshot =
        await _firestore.collection(collectionName).doc(id).get();

    if (productSnapshot.exists) {
      return ProductModel.fromFirestore(productSnapshot);
    } else {
      return null;
    }
  }

  Future<List<ProductModel>> readAllProducts() async {
    // ### Less lines
    final QuerySnapshot querySnapshot =
        await _firestore.collection(collectionName).get();
    return querySnapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc))
        .toList();

    // ### More lines
    // List<ProductModel> products = [];
    // final QuerySnapshot querySnapshot =
    //     await _firestore.collection(collectionName).get();
    // querySnapshot.docs.forEach((doc) {
    //   ProductModel? aProduct = ProductModel.fromMap(doc.data() as Map<String, dynamic>);
    //   if (aProduct != null) {
    //     products.add(aProduct);
    //   }
    // });
    // return products;
  }

  Future<void> updateProduct(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionName).doc(id).update(data);
  }

  Future<void> deleteProduct(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }
}

// BELOW IS FETCHING FROM FIRESTORE WITHOUT USING PRODUCT MODEL

// class ProductDataProvider {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final String collectionName = productsCollection;

//   // Create a new product in Firestore
//   Future<void> createProduct(Map<String, dynamic> data) async {
//     await _firestore.collection(collectionName).add(data);
//   }

//   // Read a single product by its ID from Firestore
//   Future<Map<String, dynamic>?> readProduct(String id) async {
//     final DocumentSnapshot productSnapshot =
//         await _firestore.collection(collectionName).doc(id).get();

//     if (productSnapshot.exists) {
//       return productSnapshot.data() as Map<String, dynamic>;
//     } else {
//       return null;
//     }
//   }

//   // Read all products from Firestore
//   Future<List<Map<String, dynamic>>> readAllProducts() async {
//     final QuerySnapshot querySnapshot =
//         await _firestore.collection(collectionName).get();

//     final List<Map<String, dynamic>> products = [];

//     for (final QueryDocumentSnapshot productDoc in querySnapshot.docs) {
//       products.add(productDoc.data() as Map<String, dynamic>);
//     }

//     return products;
//   }

//   // Update an existing product in Firestore by its ID
//   Future<void> updateProduct(String id, Map<String, dynamic> data) async {
//     await _firestore.collection(collectionName).doc(id).update(data);
//   }

//   // Delete a product from Firestore by its ID
//   Future<void> deleteProduct(String id) async {
//     await _firestore.collection(collectionName).doc(id).delete();
//   }
// }
