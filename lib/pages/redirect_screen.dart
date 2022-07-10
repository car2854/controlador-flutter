import 'package:flutter/material.dart';

import 'package:controlador/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RedirectScreen extends StatelessWidget {
  const RedirectScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    EasyLoading.show(status: 'Redireccionando...');
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: checkStatus(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return const SizedBox();
          }
        )
      )
    );
  }

  Future checkStatus(BuildContext context) async{
    final userBloc = BlocProvider.of<UserBloc>(context);


    final auth = await userBloc.verifyUser();

    EasyLoading.dismiss();

    if (auth) {
      Navigator.pushReplacementNamed(context, 'event_list');
    }else {
      Navigator.pushReplacementNamed(context, 'login');
    }

    
  }
}