// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

import 'package:image_picker/image_picker.dart';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    this.id,
    this.imageFile,
    this.name,
    this.phoneNumber,
    this.dob,
    this.email,
  });

  int? id;
  XFile? imageFile;
  String? name;
  String? phoneNumber;
  String? dob;
  String? email;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        imageFile: json['imageFile'],
        name: json["name"],
        phoneNumber: json["phone_number"],
        dob: json["dob"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        'imageFile': imageFile,
        "name": name,
        "phone_number": phoneNumber,
        "dob": dob,
        "email": email,
      };
}
