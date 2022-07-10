import 'package:controlador/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarWidget extends StatelessWidget {
  final bool backButton;
  final bool nameEvent;

  const AppBarWidget({
    Key? key,
    this.backButton = false,
    this.nameEvent = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final eventBloc = BlocProvider.of<EventBloc>(context);

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: const BoxDecoration(color: Colors.blue),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (backButton)
                    ? IconButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'event_list', (route) => false);
                              eventBloc.isResult = false;
                        },
                        icon: const Icon(Icons.event),
                        color: Colors.white,
                      )
                    : const IconButton(
                        onPressed: null,
                        icon: Icon(Icons.logout),
                        disabledColor: Color(0x00000000),
                      ),
                const Expanded(child: SizedBox()),
                Text(
                  userBloc.user!.nombreUsuario,
                  style: const TextStyle(color: Colors.white),
                ),
                const Expanded(child: SizedBox()),
                IconButton(
                  onPressed: () async {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Cerrar sesion'),
                        content: const Text(
                            'Estas seguro que quieres cerrar sesion?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              await userBloc.logout();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'login', (route) => false);
                                  eventBloc.isResult = false;
                            },
                            child: const Text('Si'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('No'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout),
                  color: Colors.white,
                )
              ],
            ),
            (nameEvent)
                ? Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: BlocBuilder<EventBloc, EventState>(
                      builder: (context, state) {
                        if (state.selectEvent != null){
                          return Text(state.selectEvent!.evento, style: const TextStyle(color: Colors.white));
                        }else{
                          return const SizedBox();
                        }
                      },
                    ),
                )
                : const SizedBox()
          ],
        ));
  }
}
