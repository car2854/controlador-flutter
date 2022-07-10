import 'package:flutter/material.dart';
import 'package:controlador/bloc/bloc.dart';
import 'package:controlador/pages/screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(
    
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (context) => EventBloc( userBloc: BlocProvider.of<UserBloc>(context)),),

      ], 
      child: const MyApp()
    )
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      initialRoute: 'redirect',
      routes: {
        'login': (_) => const LoginScreen(),
        'redirect': (_) => const RedirectScreen(),
        'event_list': (_) => const EventListScreen(),
        'scan_event': (_) => const ScanEventScreen(),
        'event_detail': (_) => const EventDetailScreen(),
      },
    );
  }
}

