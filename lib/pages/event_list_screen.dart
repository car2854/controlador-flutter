import 'package:controlador/bloc/bloc.dart';
import 'package:controlador/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EventListScreen extends StatelessWidget {
  const EventListScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final eventBloc = BlocProvider.of<EventBloc>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const AppBarWidget(),
            FutureBuilder(
              future: eventBloc.getEvent(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 

                
                if (snapshot.hasData){

                  if (snapshot.data!){
                    return Expanded(
                      child: Container(
                        color: const Color.fromARGB(255, 251, 251, 251),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 15, top: 5),
                              child: const Text('Eventos asignados')
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: eventBloc.eventModel!.length,
                                physics: const BouncingScrollPhysics(),
                                // padding: EdgeInsets.all(20),
                                itemBuilder: (BuildContext context, int index) { 
                                  return GestureDetector(
                                    onTap: (){
                                      // TODO: Click card
                                      eventBloc.add(OnSelectEvent(eventBloc.eventModel![index]));
                                      Navigator.pushNamed(context, 'scan_event');
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                      child: Column(  
                                        mainAxisSize: MainAxisSize.min,  
                                        children: <Widget>[
                                                
                                            Column(
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  height: 50.0,
                                                  padding: const EdgeInsets.only(left: 25),
                                                  decoration: const BoxDecoration(
                                                    color: Color(0xD02196F3)
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      eventBloc.eventModel![index].evento, 
                                                      style: const TextStyle(color: Colors.white, fontSize: 18),
                                                    )
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets.only(left: 20, top: 15),
                                                      child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                          eventBloc.eventModel![index].ubicacion,
                                                          style: const TextStyle(fontSize: 14),
                                                        )
                                                      ),
                                                    ),
                                                    const SizedBox(height: 18,),
                                                    Container(
                                                      margin: const EdgeInsets.only(bottom: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.only(right: 20),
                                                            child: Row(
                                                              children: [
                                                                const Text('Fecha: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
                                                                Text(eventBloc.eventModel![index].fecha, style: const TextStyle(fontSize: 13),),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: const EdgeInsets.only(right: 20),
                                                            child: Row(
                                                              children: [
                                                                const Text('Hora: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
                                                                Text(eventBloc.eventModel![index].hora, style: const TextStyle(fontSize: 13),),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                                
                                            
                                                
                                          // ListTile(
                                          //   title: Text(eventBloc.eventModel![index].evento),  
                                          //   subtitle: Text(eventBloc.eventModel![index].ubicacion), 
                                          //   trailing: Column(
                                          //     mainAxisAlignment: MainAxisAlignment.center,
                                          //     children: [
                                          //       Text(eventBloc.eventModel![index].fecha),
                                          //       Text(eventBloc.eventModel![index].hora)
                                          //     ],
                                          //   ),
                                          // ),  
                                        ],  
                                      ),  
                                    ),
                                  );
                                 },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }else{
                    return const Expanded(
                      child: Center(child: Text('Error')),
                    );
                  }
                
                }else{
                  return const Expanded(
                    child: Center(child: Text('Cargando...')),
                  );
                }

                
              },
            ),

          ],
        )
      )
    );
  }
}