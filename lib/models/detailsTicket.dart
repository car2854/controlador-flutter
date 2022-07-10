// To parse this JSON data, do
//
//     final detailsTicketModel = detailsTicketModelFromJson(jsonString);

import 'dart:convert';

DetailsTicketModel detailsTicketModelFromJson(String str) => DetailsTicketModel.fromJson(json.decode(str));

String detailsTicketModelToJson(DetailsTicketModel data) => json.encode(data.toJson());

class DetailsTicketModel {
    DetailsTicketModel({
        required this.ticket,
        required this.evento,
        required this.fecha,
        required this.hora,
        required this.ubicacion,
        required this.sector,
        required this.espacio,
        required this.usuario,
        required this.email,
        required this.estado,
    });

    String ticket;
    String evento;
    String fecha;
    String hora;
    String ubicacion;
    String sector;
    String espacio;
    String usuario;
    String email;
    String estado;

    factory DetailsTicketModel.fromJson(Map<String, dynamic> json) => DetailsTicketModel(
        ticket: json["ticket"],
        evento: json["evento"],
        fecha: json["fecha"],
        hora: json["hora"],
        ubicacion: json["ubicacion"],
        sector: json["sector"],
        espacio: json["espacio"],
        usuario: json["usuario"],
        email: json["email"],
        estado: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "ticket": ticket,
        "evento": evento,
        "fecha": fecha,
        "hora": hora,
        "ubicacion": ubicacion,
        "sector": sector,
        "espacio": espacio,
        "usuario": usuario,
        "email": email,
        "estado": estado,
    };
}
