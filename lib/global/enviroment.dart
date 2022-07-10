
import 'dart:io';

class Enviroment {
  static String apiUrl = Platform.isAndroid? 'http://192.168.0.4:4000/api' : 'http://localhost:4000/api';
  // static String apiUrl = 'https://api-eticket.herokuapp.com/api';
}