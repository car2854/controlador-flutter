import 'dart:convert';

import 'package:controlador/global/enviroment.dart';
import 'package:http/http.dart' as http;

class AuthService {
    Future login(String email, String password) async{

    final data = {
      'email': email,
      'contrasena': password,
    };

    var urlParse = Uri.parse('${Enviroment.apiUrl}/v1.0.0/auth/login');
    final resp = await http.post(urlParse, 
    body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );
    
    return resp;

  }

  Future verifyToken(String token) async{
    
    var urlParse = Uri.parse('${Enviroment.apiUrl}/v1.0.0/verifyTokenControlador');
    final resp = await http.post(urlParse, 
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      }
    );
    
    return resp;


  }
}
