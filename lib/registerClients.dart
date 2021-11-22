import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class registerClients extends StatefulWidget {
  const registerClients({Key? key}) : super(key: key);

  @override
  _registerClientsState createState() => _registerClientsState();
}

class _registerClientsState extends State<registerClients> {

  final Cedula = TextEditingController();
  final Nombre = TextEditingController();
  final Direccion = TextEditingController();
  final Telefono = TextEditingController();
  final Celular = TextEditingController();

  CollectionReference cliente = FirebaseFirestore.instance.collection(
      'Clientes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registo de clientes'),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: Cedula,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.lightBlueAccent,
                  filled: true,
                  icon: Icon(Icons.three_p, color: Colors.blue, size: 30),
                  hintText: 'Ingrese número de cédula',
                  hintStyle: TextStyle(color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: Nombre,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.lightBlueAccent,
                  filled: true,
                  icon: Icon(Icons.three_p, color: Colors.blue, size: 30),
                  hintText: 'Ingrese su nombre',
                  hintStyle: TextStyle(color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: Direccion,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.lightBlueAccent,
                  filled: true,
                  icon: Icon(Icons.three_p, color: Colors.blue, size: 30),
                  hintText: 'Ingrese sus apellidos',
                  hintStyle: TextStyle(color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: Telefono,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.lightBlueAccent,
                  filled: true,
                  icon: Icon(Icons.three_p, color: Colors.blue, size: 30),
                  hintText: 'Ingrese su teléfono',
                  hintStyle: TextStyle(color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: Celular,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.lightBlueAccent,
                  filled: true,
                  icon: Icon(Icons.three_p, color: Colors.blue, size: 30),
                  hintText: 'Ingrese número de celular',
                  hintStyle: TextStyle(color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                if (Cedula.text.isEmpty || Nombre.text.isEmpty ||
                    Direccion.text.isEmpty || Telefono.text.isEmpty ||
                    Celular.text.isEmpty) {
                  print('Campos vacíos');
                } else {
                  cliente.doc(Cedula.text).set({
                    'Nombre': Nombre.text,
                    'Direccion': Direccion.text,
                    'Telefono': Telefono.text,
                    'Celular': Celular.text
                  });
                }
              },
              child: Text('Registrar Cliente',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          )
        ],
      ),
    );
  }
}