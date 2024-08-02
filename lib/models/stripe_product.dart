class Product {
  bool active;
  List<String> attributes;
  int created;
  String defaultPrice;
  String? description;
  String id;
  List<String> images;
  bool livemode;
  Map<String, dynamic> metadata;
  String name;
  String object;
  dynamic packageDimensions;
  bool? shippable;
  String? statementDescriptor;
  String? taxCode;
  String type;
  String? unitLabel;
  int updated;
  String? url;

  Product({
    required this.active,
    required this.attributes,
    required this.created,
    required this.defaultPrice,
    this.description,
    required this.id,
    required this.images,
    required this.livemode,
    required this.metadata,
    required this.name,
    required this.object,
    this.packageDimensions,
    this.shippable,
    this.statementDescriptor,
    this.taxCode,
    required this.type,
    this.unitLabel,
    required this.updated,
    this.url,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        active: json["active"],
        attributes: List<String>.from(json["attributes"].map((x) => x)),
        created: json["created"],
        defaultPrice: json["default_price"],
        description: json["description"],
        id: json["id"],
        images: List<String>.from(json["images"].map((x) => x)),
        livemode: json["livemode"],
        metadata: Map<String, dynamic>.from(json["metadata"]),
        name: json["name"],
        object: json["object"],
        packageDimensions: json["package_dimensions"],
        shippable: json["shippable"],
        statementDescriptor: json["statement_descriptor"],
        taxCode: json["tax_code"],
        type: json["type"],
        unitLabel: json["unit_label"],
        updated: json["updated"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "attributes": List<dynamic>.from(attributes.map((x) => x)),
        "created": created,
        "default_price": defaultPrice,
        "description": description,
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x)),
        "livemode": livemode,
        "metadata": metadata,
        "name": name,
        "object": object,
        "package_dimensions": packageDimensions?.toJson(),
        "shippable": shippable,
        "statement_descriptor": statementDescriptor,
        "tax_code": taxCode,
        "type": type,
        "unit_label": unitLabel,
        "updated": updated,
        "url": url,
      };
}
