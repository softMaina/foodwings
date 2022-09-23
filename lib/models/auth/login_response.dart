// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.entityName,
    this.userType,
    this.id,
    this.name,
    this.email,
    this.msisdn,
    this.roleId,
    this.roleName,
    this.permissions,
    this.auth,
    this.token,
  });

  String? entityName;
  String? userType;
  String? id;
  String? name;
  String? email;
  String? msisdn;
  String? roleId;
  String? roleName;
  List<LoginResponsePermission>? permissions;
  String? auth;
  String? token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        entityName: json["entity_name"],
        userType: json["user_type"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        msisdn: json["msisdn"],
        roleId: json["role_id"],
        roleName: json["role_name"],
        permissions: List<LoginResponsePermission>.from(json["permissions"]
            .map((x) => LoginResponsePermission.fromJson(x))),
        auth: json["auth"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "entity_name": entityName,
        "user_type": userType,
        "id": id,
        "name": name,
        "email": email,
        "msisdn": msisdn,
        "role_id": roleId,
        "role_name": roleName,
        "permissions": List<dynamic>.from(permissions!.map((x) => x.toJson())),
        "auth": auth,
        "token": token,
      };
}

class LoginResponsePermission {
  LoginResponsePermission({
    this.id,
    this.name,
    this.permission,
  });

  String? id;
  String? name;
  List<PermissionPermission>? permission;

  factory LoginResponsePermission.fromJson(Map<String, dynamic> json) =>
      LoginResponsePermission(
        id: json["id"],
        name: json["name"],
        permission: List<PermissionPermission>.from(
            json["permission"].map((x) => PermissionPermission.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "permission": List<dynamic>.from(permission!.map((x) => x.toJson())),
      };
}

class PermissionPermission {
  PermissionPermission({
    this.id,
    this.name,
  });

  String? id;
  Name? name;

  factory PermissionPermission.fromJson(Map<String, dynamic> json) =>
      PermissionPermission(
        id: json["id"],
        name: nameValues.map[json["name"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
      };
}

enum Name { CREATE, VIEW, UPDATE, DELETE }

final nameValues = EnumValues({
  "create": Name.CREATE,
  "delete": Name.DELETE,
  "update": Name.UPDATE,
  "view": Name.VIEW
});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
