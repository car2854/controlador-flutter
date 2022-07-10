import 'dart:convert';

import 'package:controlador/global/enviroment.dart';

import 'package:http/http.dart' as http;

class EventService {

  Future getEvent( String token )async{

    var urlParse = Uri.parse('${Enviroment.apiUrl}/v1.0.0/controlador/eventos');
    final resp = await http.get(urlParse, 
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      }
    );
    
    return resp;

  }

  Future scanQR(String token, String codeTicket, int idubicacion, int idhorario)async{

    final data = {
      "codeTicket": codeTicket,
      "idubicacion": idubicacion,
      "idhorario": idhorario
    };

    var urlParse = Uri.parse('${Enviroment.apiUrl}/v1.0.0/controlador/infoTickets');
    final resp = await http.post(urlParse, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      },
      
    );
    
    return resp;

  }

  Future registerTicket(String token, String idticket, int idubicacion, int idhorario) async{

    final data = {
      "idticket": idticket,
      "idubicacion": idubicacion,
      "idhorario": idhorario
    };

    var urlParse = Uri.parse('${Enviroment.apiUrl}/v1.0.0/controlador/ticket/registro');
    final resp = await http.post(urlParse, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      },
      
    );
    
    return resp;

  }

}