import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;

  final int createdAt;
  final int modifiedAt;

  final String name;
  final String description;

  final String type;
  final String sku;

  final double regularPrice;
  final double salePrice;
  final dynamic discountPercentage; // If 50% OFF discount, then 0.5
  final double taxRate; // If tax rate is 8%, then 0.08
  final String taxCode;
  final String currency; // usd, mxn, eur

  final double stockQuantity;

  final String imageURL;
  final List<dynamic> imageURLs;
  final String wallpaperURL;

  final List<dynamic> downloadableFiles;

  final bool isDigital;
  final bool isConsumable;
  final bool isAvailable;

  final List<dynamic>
      availableInTheNextCountryCodes; // All countries: '*', USA: 'us', etc.

  final int availableUntilDate;
  // availableUntilDate example:
  // After this date product will not be available for purchase

  final int productIsValidForNDaysAfterPurchase;
  // productIsValidForNDaysAfterPurchase example:
  // If a product like an employment verification service or a special certification
  // is only valid for 6 months after purchase, then set this value to 180.
  // After this N days you may have to purchase this product again.

  final int
      totalQtyPerOrder; // Times This Product Can Be Added In A Single Order
  final int
      totalQtyPerUser; // Times This Product Can Be Purchased By A Single User

  final String productCategoryId;
  final String productSubcategoryId;

  final List<dynamic> productRatingIds;
  final List<dynamic> productReviewIds;

  final String status; // 'active' 'discontinued', 'outOfStock'
  final String productStatusId;

  final String relatedCollectionName;
  final String relatedDocumentId;

  final Map<String, dynamic> attributes;
  // attributes I.E.:
  // "color": "red",
  // "size": "12",
  // "weight": "1kg"

  final Map<String, dynamic> metadata;
  // metadata example:
  // include custom pieces of information according to your needs
  // metadata I.E.:
  // "myCustomKey": "My Custom Value Here"

  ProductModel({
    this.id = "",
    required this.name,
    required this.description,
    this.type = "",
    this.sku = "",
    this.regularPrice = 0.00,
    this.salePrice = 0.00,
    this.discountPercentage = 0,
    this.taxRate = 0,
    this.taxCode = "",
    this.currency = "USD",
    this.stockQuantity = 999999999,
    this.imageURL = "",
    this.imageURLs = const [],
    this.wallpaperURL = "",
    this.downloadableFiles = const [],
    this.isDigital = true,
    this.isConsumable = true,
    this.isAvailable = true,
    this.availableInTheNextCountryCodes = const ['*'],
    this.availableUntilDate = 0,
    this.productIsValidForNDaysAfterPurchase = 999999999,
    this.totalQtyPerOrder = 999999999,
    this.totalQtyPerUser = 999999999,
    this.productCategoryId = "",
    this.productSubcategoryId = "",
    this.productRatingIds = const [],
    this.productReviewIds = const [],
    this.status = "active",
    this.productStatusId = "",
    this.relatedCollectionName = "",
    this.relatedDocumentId = "",
    this.attributes = const {},
    this.metadata = const {},
  })  : createdAt = DateTime.now().millisecondsSinceEpoch,
        modifiedAt = DateTime.now().millisecondsSinceEpoch;

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      // createdAt: data['createdAt'] ?? '',
      // modifiedAt: data['modifiedAt'] ?? '',
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      type: data['type'] ?? '',
      sku: data['sku'] ?? '',
      regularPrice: data['regularPrice'] ?? '',
      salePrice: data['salePrice'] ?? '',
      discountPercentage: data['discountPercentage'] ?? '',
      taxRate: data['taxRate'] ?? '',
      taxCode: data['taxCode'] ?? '',
      currency: data['currency'] ?? '',
      stockQuantity: data['stockQuantity'] ?? '',
      imageURL: data['imageURL'] ?? '',
      imageURLs: data['imageURLs'] ?? '',
      wallpaperURL: data['wallpaperURL'] ?? '',
      downloadableFiles: data['downloadableFiles'] ?? '',
      isDigital: data['isDigital'] ?? '',
      isConsumable: data['isConsumable'] ?? '',
      isAvailable: data['isAvailable'] ?? '',
      availableInTheNextCountryCodes:
          data['availableInTheNextCountryCodes'] ?? '',
      availableUntilDate: data['availableUntilDate'] ?? '',
      productIsValidForNDaysAfterPurchase:
          data['productIsValidForNDaysAfterPurchase'] ?? '',
      totalQtyPerOrder: data['totalQtyPerOrder'] ?? '',
      totalQtyPerUser: data['totalQtyPerUser'] ?? '',
      productCategoryId: data['productCategoryId'] ?? '',
      productSubcategoryId: data['productSubcategoryId'] ?? '',
      productRatingIds: data['productRatingIds'] ?? '',
      productReviewIds: data['productReviewIds'] ?? '',
      status: data['status'] ?? '',
      productStatusId: data['productStatusId'] ?? '',
      relatedCollectionName: data['relatedCollectionName'] ?? '',
      relatedDocumentId: data['relatedDocumentId'] ?? '',
      attributes: data['attributes'] ?? '',
      metadata: data['metadata'] ?? '',
    );
  }

  // Create an object from a map
  static ProductModel fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      type: map['type'],
      sku: map['sku'],
      regularPrice: map['regularPrice'],
      salePrice: map['salePrice'],
      discountPercentage: map['discountPercentage'],
      taxRate: map['taxRate'],
      taxCode: map['taxCode'],
      currency: map['currency'],
      stockQuantity: map['stockQuantity'],
      imageURL: map['imageURL'],
      imageURLs: map['imageURLs'],
      wallpaperURL: map['wallpaperURL'],
      downloadableFiles: map['downloadableFiles'],
      isDigital: map['isDigital'],
      isConsumable: map['isConsumable'],
      isAvailable: map['isAvailable'],
      availableInTheNextCountryCodes: map['availableInTheNextCountryCodes'],
      availableUntilDate: map['availableUntilDate'],
      productIsValidForNDaysAfterPurchase:
          map['productIsValidForNDaysAfterPurchase'],
      totalQtyPerOrder: map['totalQtyPerOrder'],
      totalQtyPerUser: map['totalQtyPerUser'],
      productCategoryId: map['productCategoryId'],
      productSubcategoryId: map['productSubcategoryId'],
      productRatingIds: map['productRatingIds'],
      productReviewIds: map['productReviewIds'],
      status: map['status'],
      productStatusId: map['productStatusId'],
      relatedCollectionName: map['relatedCollectionName'],
      relatedDocumentId: map['relatedDocumentId'],
      attributes: map['attributes'],
      metadata: map['metadata'],
    );
  }

  // Convert the object into a map
  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'sku': sku,
      'regularPrice': regularPrice,
      'salePrice': salePrice,
      'discountPercentage': discountPercentage,
      'taxRate': taxRate,
      'taxCode': taxCode,
      'currency': currency,
      'stockQuantity': stockQuantity,
      'imageURL': imageURL,
      'imageURLs': imageURLs,
      'wallpaperURL': wallpaperURL,
      'downloadableFiles': downloadableFiles,
      'isDigital': isDigital,
      'isConsumable': isConsumable,
      'isAvailable': isAvailable,
      'availableInTheNextCountryCodes': availableInTheNextCountryCodes,
      'availableUntilDate': availableUntilDate,
      'productIsValidForNDaysAfterPurchase':
          productIsValidForNDaysAfterPurchase,
      'totalQtyPerOrder': totalQtyPerOrder,
      'totalQtyPerUser': totalQtyPerUser,
      'productCategoryId': productCategoryId,
      'productSubcategoryId': productSubcategoryId,
      'productRatingIds': productRatingIds,
      'productReviewIds': productReviewIds,
      'status': status,
      'productStatusId': productStatusId,
      'relatedCollectionName': relatedCollectionName,
      'relatedDocumentId': relatedDocumentId,
      'attributes': attributes,
      'metadata': metadata,
    };
  }

  @override
  String toString() {
    return 'ProductModel: { id: $id, name: $name, description: $description, type: $type, sku: $sku, '
        'regularPrice: $regularPrice, salePrice: $salePrice, discountPercentage: $discountPercentage, '
        'taxRate: $taxRate, taxCode: $taxCode, currency: $currency, stockQuantity: $stockQuantity, '
        'imageURL: $imageURL, imageURLs: $imageURLs, wallpaperURL: $wallpaperURL, '
        'downloadableFiles: $downloadableFiles, isDigital: $isDigital, isConsumable: $isConsumable, '
        'isAvailable: $isAvailable, availableInTheNextCountryCodes: $availableInTheNextCountryCodes, '
        'availableUntilDate: $availableUntilDate, productIsValidForNDaysAfterPurchase: '
        '$productIsValidForNDaysAfterPurchase, totalQtyPerOrder: $totalQtyPerOrder, '
        'totalQtyPerUser: $totalQtyPerUser, productCategoryId: $productCategoryId, '
        'productSubcategoryId: $productSubcategoryId, productRatingIds: $productRatingIds, '
        'productReviewIds: $productReviewIds, status: $status, productStatusId: $productStatusId, '
        'relatedCollectionName: $relatedCollectionName, relatedDocumentId: $relatedDocumentId, '
        'attributes: $attributes, metadata: $metadata }';
  }

  ProductModel formatValues() {
    return ProductModel(
      id: id,
      name: name ?? '',
      description: description ?? '',
      type: type ?? '',
      sku: sku ?? '',
      regularPrice: regularPrice.toDouble(),
      salePrice: salePrice.toDouble(),
      discountPercentage: discountPercentage.toDouble(),
      taxRate: taxRate.toDouble(),
      taxCode: taxCode ?? '',
      currency: currency ?? 'USD',
      stockQuantity: stockQuantity.toDouble(),
      imageURL: imageURL ?? '',
      imageURLs: List<String>.from(imageURLs),
      wallpaperURL: wallpaperURL ?? '',
      downloadableFiles: List<String>.from(downloadableFiles),
      isDigital: isDigital ?? true,
      isConsumable: isConsumable ?? true,
      isAvailable: isAvailable ?? true,
      availableInTheNextCountryCodes:
          List<String>.from(availableInTheNextCountryCodes),
      availableUntilDate: availableUntilDate,
      productIsValidForNDaysAfterPurchase: productIsValidForNDaysAfterPurchase,
      totalQtyPerOrder: totalQtyPerOrder,
      totalQtyPerUser: totalQtyPerUser,
      productCategoryId: productCategoryId ?? '',
      productSubcategoryId: productSubcategoryId ?? '',
      productRatingIds: List<String>.from(productRatingIds),
      productReviewIds: List<String>.from(productReviewIds),
      status: status ?? 'active',
      productStatusId: productStatusId ?? '',
      relatedCollectionName: relatedCollectionName ?? '',
      relatedDocumentId: relatedDocumentId ?? '',
      attributes: Map<String, dynamic>.from(attributes),
      metadata: Map<String, dynamic>.from(metadata),
    );
  }

  Map<String, dynamic> toMapFormatted() {
    return {
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'id': id,
      'name': name ?? '',
      'description': description ?? '',
      'type': type ?? '',
      'sku': sku ?? '',
      'regularPrice': regularPrice.toDouble(),
      'salePrice': salePrice.toDouble(),
      'discountPercentage': discountPercentage.toDouble(),
      'taxRate': taxRate.toDouble(),
      'taxCode': taxCode ?? '',
      'currency': currency ?? 'USD',
      'stockQuantity': stockQuantity.toDouble(),
      'imageURL': imageURL ?? '',
      'imageURLs': List<String>.from(imageURLs),
      'wallpaperURL': wallpaperURL ?? '',
      'downloadableFiles': List<String>.from(downloadableFiles),
      'isDigital': isDigital ?? true,
      'isConsumable': isConsumable ?? true,
      'isAvailable': isAvailable ?? true,
      'availableInTheNextCountryCodes':
          List<String>.from(availableInTheNextCountryCodes),
      'availableUntilDate': availableUntilDate,
      'productIsValidForNDaysAfterPurchase':
          productIsValidForNDaysAfterPurchase,
      'totalQtyPerOrder': totalQtyPerOrder,
      'totalQtyPerUser': totalQtyPerUser,
      'productCategoryId': productCategoryId ?? '',
      'productSubcategoryId': productSubcategoryId ?? '',
      'productRatingIds': List<String>.from(productRatingIds),
      'productReviewIds': List<String>.from(productReviewIds),
      'status': status ?? 'active',
      'productStatusId': productStatusId ?? '',
      'relatedCollectionName': relatedCollectionName ?? '',
      'relatedDocumentId': relatedDocumentId ?? '',
      'attributes': Map<String, dynamic>.from(attributes),
      'metadata': Map<String, dynamic>.from(metadata),
    };
  }
}
