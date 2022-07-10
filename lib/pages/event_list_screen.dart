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
                              child: Column(  
                                mainAxisSize: MainAxisSize.min,  
                                children: <Widget>[  
                                  ListTile(
                                    title: Text(eventBloc.eventModel![index].evento),  
                                    subtitle: Text(eventBloc.eventModel![index].ubicacion), 
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(eventBloc.eventModel![index].fecha),
                                        Text(eventBloc.eventModel![index].hora)
                                      ],
                                    ),
                                  ),  
                                ],  
                              ),  
                            ),
                          );
                         },
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