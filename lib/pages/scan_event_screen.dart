import 'dart:io';

import 'package:controlador/bloc/bloc.dart';
import 'package:controlador/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanEventScreen extends StatefulWidget {

  const ScanEventScreen({ Key? key }) : super(key: key);

  @override
  State<ScanEventScreen> createState() => _ScanEventScreenState();
}

class _ScanEventScreenState extends State<ScanEventScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;

  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
      print('android');
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
      print('ios');
    }
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const AppBarWidget(
              backButton: true,
              nameEvent: true,
            ),
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: (data){
                  _onQRViewCreated(data, context);
                },
                overlay: QrScannerOverlayShape(
                  borderColor: Theme.of(context).accentColor,
                  borderRadius: 10,
                  borderLength: 20,
                  borderWidth: 10,
                  cutOutSize: MediaQuery.of(context).size.width * 0.8
                ),
              )
            )
          ],
        )
      )
    );
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) async{
    
    final eventBloc = BlocProvider.of<EventBloc>(context);  

    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async{
      result = scanData;

      if (result != null && !eventBloc.isResult){
        
        eventBloc.isResult = true;
        EasyLoading.show(status: 'Cargando');
        final status = await eventBloc.scanQR(scanData.code!);
        EasyLoading.dismiss();

        if (status){
          Navigator.pushNamed(context, 'event_detail');
        }else{
          eventBloc.isResult = false;
          if (eventBloc.error != null){
            EasyLoading.showError(eventBloc.error!.message, duration: const Duration(seconds: 3));
          }else{
            EasyLoading.showError('Error interno, consulte con el desarrollador', duration: const Duration(seconds: 3));
          }
        }

        }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}