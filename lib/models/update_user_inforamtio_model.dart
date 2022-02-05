class UpdateUserInformationModelData {
  String? name;
  String? email;
  String? phone;
  String? token;

  UpdateUserInformationModelData({
    this.name,
    this.email,
    this.phone,
    this.token,
  });
  UpdateUserInformationModelData.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    email = json['email']?.toString();
    phone = json['phone']?.toString();
    token = json['token']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['token'] = token;
    return data;
  }
}

class UpdateUserInformationModel {
  bool? status;
  String? message;
  UpdateUserInformationModelData? data;

  UpdateUserInformationModel({
    this.status,
    this.message,
    this.data,
  });
  UpdateUserInformationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? UpdateUserInformationModelData.fromJson(json['data'])
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
