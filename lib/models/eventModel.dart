// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

List<EventModel> eventModelFromJson(String str) => List<EventModel>.from(json.decode(str).map((x) => EventModel.fromJson(x)));

String eventModelToJson(List<EventModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventModel {
    EventModel({
        required this.evento,
        required this.idubicacion,
        required this.ubicacion,
        required this.idhorario,
        required this.hora,
        required this.fecha,
    });

    String evento;
    int idubicacion;
    String ubicacion;
    int idhorario;
    String hora;
    String fecha;

    factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        evento: json["evento"],
        idubicacion: json["idubicacion"],
        ubicacion: json["ubicacion"],
        idhorario: json["idhorario"],
        hora: json["hora"],
        fecha: json["fecha"],
    );

    Map<String, dynamic> toJson() => {
        "evento": evento,
        "idubicacion": idubicacion,
        "ubicacion": ubicacion,
        "idhorario": idhorario,
        "hora": hora,
        "fecha": fecha,
    };
}
