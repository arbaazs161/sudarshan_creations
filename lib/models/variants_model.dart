class VariantModel {
  final String id;
  final List<String> images;
  final List<PriceRangeModel> priceRange;
  final String? color;
  final String? material;
  final String description;
  final bool defaultt;
  final bool available;
  final String priceType; // priceType= (range, fixed price, inquiry)
  final num? fixedPrice;
  final String? size;

  VariantModel({
    required this.id,
    required this.images,
    required this.priceRange,
    required this.color,
    required this.material,
    required this.description,
    required this.defaultt,
    required this.available,
    required this.priceType,
    required this.fixedPrice,
    required this.size,
  });

  factory VariantModel.fromJson(String keyId, Map<String, dynamic> json) {
    return VariantModel(
      id: keyId,
      images: List<String>.from(json['images']),
      // priceRange: (json['priceRange'] as List<Map<String, dynamic>>)
      //     .map((priceRangeJson) => PriceRangeModel.fromJson(priceRangeJson))
      //     .toList(),
      priceRange: (json['priceRange'] as List<dynamic>)
          .map((e) => PriceRangeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      color: json['color'],
      material: json['material'],
      description: json['description'],
      defaultt: json['default'],
      available: json['available'],
      priceType: json['priceType'],
      fixedPrice: json['fixedPrice'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() => {
        id: {
          'images': images,
          'priceRange': priceRange,
          // {}.addAll(priceRange.map((e) => e.toJson())),
          'color': color,
          'material': material,
          'description': description,
          'default': defaultt,
          'available': available,
          'priceType': priceType,
          'fixedPrice': fixedPrice,
          'size': size,
        },
      };
}

class PriceRangeModel {
  final String startQty;
  final String endQty;
  final num price;

  PriceRangeModel({
    required this.startQty,
    required this.endQty,
    required this.price,
  });

  factory PriceRangeModel.fromJson(Map<String, dynamic> json) =>
      PriceRangeModel(
        startQty: json['startQty'] as String,
        endQty: json['endQty'] as String,
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        'startQty': startQty,
        'endQty': endQty,
        'price': price,
      };
}

/*   toInputModel() {
    return VariantInputModel(
        vId: id,
        sizeCtrl: TextEditingController(text: size.toString()),
        colorCtrl: TextEditingController(text: color),
        available: available,
        descriptionCtrl: TextEditingController(text: description),
        fixedPriceCtrl: TextEditingController(text: fixedPrice.toString()),
        materialCtrl: TextEditingController(text: material),
        uploadedImages: images,
        newImages: [],
        defaultt: defaultt,
        priceType: priceType,
        priceRange: priceRange.map((e) => e.toInputPriceRange()).toList());
    // return VariantInputModel(
    //   size: TextEditingController(text: size),
    //   color: TextEditingController(text: color),
    //   // mrp: TextEditingController(text: mrp.toString()),
    //   qty: TextEditingController(text: qty.toString()),
    //   salePrice: TextEditingController(text: salePrice.toString()),
    //   baseItem: baseItem,
    //   colored: color != null,
    //   uploadedImages: images,
    //   newImages: [],
    //   vId: vId,
    // );
  }

 */

/* 
class VariantInputModel {
  final String vId;
  final TextEditingController sizeCtrl;
  final TextEditingController colorCtrl;
  final TextEditingController fixedPriceCtrl;
  final TextEditingController descriptionCtrl;
  final TextEditingController materialCtrl;
  bool defaultt;
  bool available;
  final List<String> uploadedImages;
  final List<SelectedImage> newImages;
  String? priceType;
  final List<PriceRangeInputModel> priceRange;

  VariantInputModel({
    required this.vId,
    required this.sizeCtrl,
    required this.colorCtrl,
    required this.available,
    required this.descriptionCtrl,
    required this.fixedPriceCtrl,
    required this.materialCtrl,
    this.defaultt = false,
    required this.priceType,
    required this.priceRange,
    required this.uploadedImages,
    required this.newImages,
  });

  static newVariant() {
    return VariantInputModel(
      vId: getRandomId(8),
      available: true,
      sizeCtrl: TextEditingController(),
      colorCtrl: TextEditingController(),
      fixedPriceCtrl: TextEditingController(),
      materialCtrl: TextEditingController(),
      descriptionCtrl: TextEditingController(),
      uploadedImages: [],
      newImages: [],
      priceType: null,
      priceRange: [],
    );
  }
}
 */


/*   PriceRangeInputModel toInputPriceRange() {
    return PriceRangeInputModel(
        startQty: TextEditingController(text: startQty),
        endQty: TextEditingController(text: endQty),
        price: TextEditingController(text: price.toString()));
  } */

/* class PriceRangeInputModel {
  final TextEditingController startQty;
  final TextEditingController endQty;
  final TextEditingController price;

  PriceRangeInputModel({
    required this.startQty,
    required this.endQty,
    required this.price,
  });

  static newRange() {
    return PriceRangeInputModel(
      startQty: TextEditingController(),
      endQty: TextEditingController(),
      price: TextEditingController(),
    );
  }
}
 */