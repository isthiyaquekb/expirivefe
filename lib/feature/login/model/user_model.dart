import 'dart:convert';

UserModel userDataFromMap(String str) => UserModel.fromMap(json.decode(str));

String userDataToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  UserModel(
      {required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phoneCode,
        required this.phone});

  String id;
  String firstName;
  String lastName;
  String email;
  int phoneCode;
  int phone;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phoneCode: json["phone_code"],
    phone: json["phone"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone_code": phoneCode,
    "phone": phone,
  };
}
