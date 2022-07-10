import 'package:controlador/bloc/user/user_bloc.dart';
import 'package:controlador/widgets/widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context);
    var sendData = false;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE9ECEF),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const Text('Tu Ticket', style: TextStyle(fontSize: 30),),
              
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: const Color(0x15000000)),
                  color: Colors.white
                ),
                child: Column(
                  children: [
                    const Text('Iniciar sesion'),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFieldWidget(
                      labelText: 'Email',
                      iconData: const Icon(Icons.email),
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFieldWidget(
                      labelText: 'Password',
                      iconData: const Icon(Icons.lock),
                      isPassword: true,
                      controller: passController,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ButtonWidget(
                      text: 'Login',
                      expanded: true,
                      backgroundColor: const Color(0xFF007BFF),
                      primaryColor: Colors.white,
                      onPressed: ()async{
                        if (emailController.value.text.isNotEmpty && passController.value.text.isNotEmpty && EmailValidator.validate(emailController.value.text) && !sendData){
                          
                          EasyLoading.show(status: 'Cargando');
                          sendData = true;
                          final status = await userBloc.login(
                            emailController.value.text,
                            passController.value.text
                          );
                          EasyLoading.dismiss();
                          sendData = false;
                          if (status){
                            Navigator.pushNamedAndRemoveUntil(context, 'event_list', (route) => false);
                          }else{
                            if (userBloc.error != null){
                              EasyLoading.showError(userBloc.error!.message, duration: const Duration(seconds: 3));
                            }else{
                              EasyLoading.showError('Error interno, consulte con el desarrollador', duration: const Duration(seconds: 3));
                            }
                          }

                        }else{

                          if (!EmailValidator.validate(emailController.value.text)){
                            EasyLoading.showError('El email es invalido', duration: const Duration(seconds: 3));
                          }else if (emailController.value.text.isEmpty){
                            EasyLoading.showError('El email es obligatorio', duration: const Duration(seconds: 3));
                          }else if(passController.value.text.isEmpty){
                            EasyLoading.showError('La contraseña es obligatorio', duration: const Duration(seconds: 3));
                          }


                        }
                      }
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      )
    );
  }
}