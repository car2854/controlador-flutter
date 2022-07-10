import 'package:controlador/bloc/bloc.dart';
import 'package:controlador/widgets/app_bar_widget.dart';
import 'package:controlador/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({ Key? key }) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    final eventBloc = BlocProvider.of<EventBloc>(context);
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        eventBloc.isResult = false;
        return true;
     },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const AppBarWidget(
                backButton: true,
              ),
              Expanded(child: SizedBox(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.blue),
                      child: Center(child: Text(eventBloc.detailsTicketModel!.evento, style: const TextStyle(fontSize: 35.0, color: Colors.white),))
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                        child: Column(
                          children: [
                            _dataDetail1('Nombre del usuario:', eventBloc.detailsTicketModel!.usuario),
                            _dataDetail1('Email:', eventBloc.detailsTicketModel!.email),
                            _dataDetail1('Ubicacion:', eventBloc.detailsTicketModel!.ubicacion),
                            _dataDetail1('Sector:', eventBloc.detailsTicketModel!.sector),
                            _dataDetail1('Espacio:', eventBloc.detailsTicketModel!.espacio),
                            _dataDetail1('Estado del ticket:', eventBloc.detailsTicketModel!.estado),
                            Expanded(child: Container()),
                            Text('Fecha: ${eventBloc.detailsTicketModel!.fecha}'),
                            Text('Hora: ${eventBloc.detailsTicketModel!.hora}'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonWidget(
                    text: 'Cancelar',
                    backgroundColor: Colors.red,
                    primaryColor: Colors.white,
                    sizeWidth: size.width / 2,
                    sizeHeight: 48.0,
                    noBorder: true,
                    onPressed: (){
                      eventBloc.isResult = false;
                      Navigator.pop(context);
                    },
                  ),
                  ButtonWidget(
                    text: 'Aceptar',
                    backgroundColor: Colors.blue,
                    primaryColor: Colors.white,
                    sizeWidth: size.width / 2,
                    sizeHeight: 48.0,
                    noBorder: true,
                    onPressed: ()async{
                      
                      EasyLoading.show(status: 'Enviando');
                      
                      final status = await eventBloc.registerTicket();
                      
                      EasyLoading.dismiss();
    
                      if (status){
                        EasyLoading.showSuccess('Ticket registrado correctamente', duration: const Duration(seconds: 3));
                        eventBloc.isResult = false;
                        Navigator.pop(context);
                      }else{
                        if (eventBloc.error != null){
                          EasyLoading.showError(eventBloc.error!.message, duration: const Duration(seconds: 3));
                        }else{
                          EasyLoading.showError('Error interno, consulte con el desarrollador', duration: const Duration(seconds: 3));
                        }
                      }
    
                    },
                  ),
                ],
              )
            ],
          )
        )
      ),
    );
  }

  Widget _dataDetail1(String key, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13.0),
      child: Row(
        children: [
          Expanded(child: Text(key, style: const TextStyle(fontWeight: FontWeight.bold),)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}