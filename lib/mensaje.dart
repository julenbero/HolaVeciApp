import 'package:flutter/material.dart';
import 'package:holaveci/notificacion.dart';

class mensaje extends StatefulWidget {
  const mensaje({Key? key}) : super(key: key);

  @override
  _mensajeState createState() => _mensajeState();
}

class _mensajeState extends State<mensaje> {
  void initState(){
    super.initState;
    final notificacion mensaje = new notificacion();
    mensaje.generarToken();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
      ),
    );
  }
}
