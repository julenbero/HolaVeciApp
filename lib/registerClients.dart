import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:holaveci/comprobarCliente.dart';

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

  void limpiar(){
    Cedula.text="";
    Nombre.text="";
    Direccion.text="";
    Telefono.text="";
    Celular.text="";

  }

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
              onPressed: () async {
                if (Cedula.text.isEmpty || Nombre.text.isEmpty ||
                    Direccion.text.isEmpty || Telefono.text.isEmpty ||
                    Celular.text.isEmpty) {
                  print('Campos vacíos');
                  Fluttertoast.showToast(
                      msg: "campos vacios",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 18.0);
                } else {
                  QuerySnapshot existe = await cliente.where(FieldPath.documentId, isEqualTo: Cedula.text).get();
                  if(existe.docs.length>0){
                    Fluttertoast.showToast(
                        msg: "Cliente ya existe con ese número de cedula",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 18.0);
                    limpiar();
                  }else {
                    cliente.doc(Cedula.text).set({
                      'Nombre': Nombre.text,
                      'Direccion': Direccion.text,
                      'Telefono': Telefono.text,
                      'Celular': Celular.text
                    });
                    QuerySnapshot existe1 = await cliente.where(
                        FieldPath.documentId, isEqualTo: Cedula.text).get();
                    limpiar();
                    if (existe1.docs.length > 0) {
                      Fluttertoast.showToast(
                          msg: "Se registro cliente de forma exitosa",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    }else{
                      Fluttertoast.showToast(
                          msg: "El cliente no se registro",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    }
                  }
                }
              },
              child: Text('Registrar Cliente',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>comprobarCliente()));
    },
       child: Icon(Icons.add_to_photos_rounded),
      ),
    );
  }
}