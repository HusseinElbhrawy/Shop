class FavoriteProductModelDataDataProduct {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  FavoriteProductModelDataDataProduct({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
  });
  FavoriteProductModelDataDataProduct.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    price = json['price']?.toInt();
    oldPrice = json['old_price']?.toInt();
    discount = json['discount']?.toInt();
    image = json['image']?.toString();
    name = json['name']?.toString();
    description = json['description']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['discount'] = discount;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}

class FavoriteProductModelDataData {
  int? id;
  FavoriteProductModelDataDataProduct? product;

  FavoriteProductModelDataData({
    this.id,
    this.product,
  });
  FavoriteProductModelDataData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    product = (json['product'] != null)
        ? FavoriteProductModelDataDataProduct.fromJson(json['product'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class FavoriteProductModelData {
  int? currentPage;
  List<FavoriteProductModelDataData?>? data;
  int? to;
  int? total;

  FavoriteProductModelData({
    this.currentPage,
    this.data,
    this.to,
    this.total,
  });
  FavoriteProductModelData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page']?.toInt();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <FavoriteProductModelDataData>[];
      v.forEach((v) {
        arr0.add(FavoriteProductModelDataData.fromJson(v));
      });
      this.data = arr0;
    }
    to = json['to']?.toInt();
    total = json['total']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['data'] = arr0;
    }
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class FavoriteProductModel {
  bool? status;
  FavoriteProductModelData? data;

  FavoriteProductModel({
    this.status,
    this.data,
  });
  FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null)
        ? FavoriteProductModelData.fromJson(json['data'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
