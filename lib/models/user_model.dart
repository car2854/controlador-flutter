// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.nombreUsuario,
        required this.email,
        required this.rol,
        required this.token,
    });

    String nombreUsuario;
    String email;
    String rol;
    String token;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        nombreUsuario: json["nombre_usuario"],
        email: json["email"],
        rol: json["rol"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "nombre_usuario": nombreUsuario,
        "email": email,
        "rol": rol,
        "token": token,
    };
}
