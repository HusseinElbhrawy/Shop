class RegisterModel {
  bool? status;
  String? message;
  RegisterModelData? data;

  RegisterModel({
    this.status,
    this.message,
    this.data,
  });
  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? RegisterModelData.fromJson(json['data'])
        : null;
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

class RegisterModelData {
  String? name;
  String? email;
  String? phone;
  int? id;
  String? image;
  String? token;

  RegisterModelData({
    this.name,
    this.email,
    this.phone,
    this.id,
    this.image,
    this.token,
  });
  RegisterModelData.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    email = json['email']?.toString();
    phone = json['phone']?.toString();
    id = json['id']?.toInt();
    image = json['image']?.toString();
    token = json['token']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['id'] = id;
    data['image'] = image;
    data['token'] = token;
    return data;
  }
}
