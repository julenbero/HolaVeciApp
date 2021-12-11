import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'actualizarCliente.dart';

class comprobarCliente extends StatefulWidget {
  const comprobarCliente({Key? key}) : super(key: key);

  @override
  _comprobarClienteState createState() => _comprobarClienteState();
}

class _comprobarClienteState extends State<comprobarCliente> {

  final cedula=TextEditingController();
  final telefono=TextEditingController();

  CollectionReference cliente = FirebaseFirestore.instance.collection("Clientes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comprobar Cliente"),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: cedula,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.lightBlue,
                  filled: true,
                  icon: Icon(Icons.badge, color: Colors.blue, size: 30),
                  hintText: "Ingrese numero de cedula",
                  hintStyle: TextStyle(color: Colors.yellow, fontStyle: FontStyle.italic,fontSize: 14)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: telefono,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.lightBlue,
                  filled: true,
                  icon: Icon(Icons.phone, color: Colors.blue, size: 30),
                  hintText: "Ingrese Telefono",
                  hintStyle: TextStyle(color: Colors.yellow, fontStyle: FontStyle.italic,fontSize: 14)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () async {
                if (cedula.text.isEmpty || telefono.text.isEmpty) {
                print('Campos vacíos');
                Fluttertoast.showToast(
                msg: "campos vacios",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 18.0);
                } else {
                  QuerySnapshot verifica = await cliente
                      .where(FieldPath.documentId, isEqualTo: cedula.text)
                      .where("Telefono", isEqualTo: telefono.text)
                      .get();
                  List lista = [];
                  if (verifica.docs.length > 0) {
                    for (var cli in verifica.docs) {
                      lista.add(cli.data());
                    }
                    datosCliente dCli = datosCliente(
                        cedula.text, lista[0]['Nombre'], lista[0]['Direccion'],
                        lista[0]['Telefono'], lista[0]['Celular']);
                    Fluttertoast.showToast(
                        msg: "Comprobación exitosa",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 18.0);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            actualizarCliente(cliente: dCli)));
                  } else {
                    Fluttertoast.showToast(
                        msg: "Datos Incorrectos",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  }
                }
              },
              child: Text("Verificar"),
            ),
          )
        ],
      ),
    );
  }
}

class datosCliente {

  String cedula = "";
  String nombre = "";
  String direccion = "";
  String telefono = "";
  String celular = "";

  datosCliente(this.cedula, this.nombre, this.direccion, this.telefono,
      this.celular);
}