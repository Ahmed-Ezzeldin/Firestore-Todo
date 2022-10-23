class UserModel {
  String? uid;
  String? displayName;
  String? email;
  String? phoneNumber;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    displayName = json["displayName"];
    email = json["email"];
    phoneNumber = json["phoneNumber"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["uid"] = uid;
    data["displayName"] = displayName;
    data["email"] = email;
    data["phoneNumber"] = phoneNumber;
    return data;
  }


}
