import 'package:bloc/bloc.dart';
import 'package:controlador/models/models.dart';
import 'package:controlador/services/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final authService = AuthService();
  final storage = const FlutterSecureStorage();
  ErrorResponse? error;
  

  UserModel? user;

  UserBloc() : super(const UserState()) {
    on<UserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  Future<bool> login( String email, String password ) async{
    
    final Response resp = await authService.login(email, password);

    if (resp.statusCode == 200){

      final userModel = userModelFromJson(resp.body);
      

      if (userModel.rol != 'controlador'){

        error = ErrorResponse(status: 403, message: 'Usted no es un controlador');

        return false;
      }

      user = userModel;

      await _writeLocal('token',userModel.token);
      await _writeLocal('nombre',userModel.nombreUsuario);
      await _writeLocal('email',userModel.email);
      await _writeLocal('rol',userModel.rol);
      return true;

    }else{
      
      if (resp.statusCode == 400){
        final errorResponse = errorResponseFromJson(resp.body);
        error = errorResponse;
      }else{
        
      }

      return false;

    }

  }

  Future<bool> verifyUser() async{
    
    final token = await storage.read(key: 'token') ?? '';

    final Response resp = await authService.verifyToken( token );


    if (resp.statusCode == 200){

      final token = await storage.read(key: 'token') ?? '';
      final nombre = await storage.read(key: 'nombre') ?? '';
      final email = await storage.read(key: 'email') ?? '';
      final rol = await storage.read(key: 'rol') ?? '';
      user = UserModel(
        nombreUsuario: nombre, 
        email: email, 
        rol: rol, 
        token: token
      );

      return true;
    }else{

      return false;
    }

  }

  Future _writeLocal (String key, String value) async{
    return await storage.write(key: key, value: value);
  }

  Future logout() async{
    await storage.delete(key: 'token');
    await storage.delete(key: 'nombre');
    await storage.delete(key: 'email');
  }
}
