class SearchProductsInnerData {
  int? id;
  double? price;
  String? image;
  String? name;
  String? description;
  List<String?>? images;
  bool? inFavorites;
  bool? inCart;

  SearchProductsInnerData({
    this.id,
    this.price,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,
  });
  SearchProductsInnerData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    price = json['price']?.toDouble();
    image = json['image']?.toString();
    name = json['name']?.toString();
    description = json['description']?.toString();
    if (json['images'] != null) {
      final v = json['images'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      images = arr0;
    }
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    if (images != null) {
      final v = images;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['images'] = arr0;
    }
    data['in_favorites'] = inFavorites;
    data['in_cart'] = inCart;
    return data;
  }
}

class SearchProductsData {
  int? currentPage;
  List<SearchProductsInnerData?>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;

  SearchProductsData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });
  SearchProductsData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page']?.toInt();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <SearchProductsInnerData>[];
      v.forEach((v) {
        arr0.add(SearchProductsInnerData.fromJson(v));
      });
      this.data = arr0;
    }
    firstPageUrl = json['first_page_url']?.toString();
    from = json['from']?.toInt();
    lastPage = json['last_page']?.toInt();
    lastPageUrl = json['last_page_url']?.toString();
    path = json['path']?.toString();
    perPage = json['per_page']?.toInt();
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
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class SearchProducts {
  bool? status;
  SearchProductsData? data;

  SearchProducts({
    this.status,
    this.data,
  });
  SearchProducts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null)
        ? SearchProductsData.fromJson(json['data'])
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
