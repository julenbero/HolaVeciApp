import 'package:firebase_messaging/firebase_messaging.dart';

class notificacion {
  FirebaseMessaging notifica= FirebaseMessaging.instance;
  generarToken(){
    notifica.requestPermission();
    notifica.getToken().then((token){
      print('token: ' + token.toString());
    });
  }
}