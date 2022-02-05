class FavoritesModel {
  bool? status;
  String? message;
  Data? data;

  FavoritesModel({
    this.status,
    this.message,
    this.data,
  });
  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? Data.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  FavoritesModelDataProduct? product;

  Data({
    this.id,
    this.product,
  });
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    product = (json['product'] != null)
        ? FavoritesModelDataProduct.fromJson(json['product'])
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

class FavoritesModelDataProduct {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;

  FavoritesModelDataProduct({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
  });
  FavoritesModelDataProduct.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    price = json['price']?.toInt();
    oldPrice = json['old_price']?.toInt();
    discount = json['discount']?.toInt();
    image = json['image']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['discount'] = discount;
    data['image'] = image;
    return data;
  }
}
