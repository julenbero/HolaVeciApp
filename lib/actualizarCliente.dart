import 'package:holaveci/comprobarCliente.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:fluttertoast/fluttertoast.dart";


  class actualizarCliente extends StatefulWidget {
  final datosCliente cliente;
  const actualizarCliente({required this.cliente});

  @override
  _actualizarClienteState createState() => _actualizarClienteState();
}

class _actualizarClienteState extends State<actualizarCliente> {

  final Cedula = TextEditingController();
  final Nombre = TextEditingController();
  final Direccion = TextEditingController();
  final Telefono = TextEditingController();
  final Celular = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Cedula.text= widget.cliente.cedula;
    Nombre.text= widget.cliente.nombre;
    Direccion.text= widget.cliente.direccion;
    Telefono.text= widget.cliente.telefono;
    Celular.text= widget.cliente.celular;

    return Scaffold(
      appBar: AppBar(
        title: Text("Actualizar Datos: "+ widget.cliente.cedula),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: Nombre,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.lightBlue,
                  filled: true,
                  icon: Icon(Icons.person, color: Colors.blue, size: 30),
                  hintText: "Ingrese su nombre",
                  hintStyle: TextStyle(color: Colors.lightGreen, fontStyle: FontStyle.italic,fontSize: 14)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: Direccion,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.lightBlue,
                  filled: true,
                  icon: Icon(Icons.person, color: Colors.blue, size: 30),
                  hintText: "Ingrese su direccion",
                  hintStyle: TextStyle(color: Colors.lightGreen, fontStyle: FontStyle.italic,fontSize: 14)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: Telefono,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.lightBlue,
                  filled: true,
                  icon: Icon(Icons.person, color: Colors.blue, size: 30),
                  hintText: "Ingrese su telefono",
                  hintStyle: TextStyle(color: Colors.lightGreen, fontStyle: FontStyle.italic,fontSize: 14)
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: Celular,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.lightBlue,
                  filled: true,
                  icon: Icon(Icons.person, color: Colors.blue, size: 30),
                  hintText: "Ingrese su numero de celular",
                  hintStyle: TextStyle(color: Colors.lightGreen, fontStyle: FontStyle.italic,fontSize: 14)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: (){
                      if(Cedula.text.isEmpty || Nombre.text.isEmpty || Direccion.text.isEmpty || Telefono.text.isEmpty || Celular.text.isEmpty){
                        Fluttertoast.showToast(msg: "Campos vacios...", toastLength: Toast.LENGTH_LONG, fontSize: 20, backgroundColor: Colors.red,
                            textColor: Colors.lightGreen, gravity: ToastGravity.CENTER);
                      }else{
                        CollectionReference actualiza = FirebaseFirestore.instance.collection("Clientes");
                        actualiza.doc(widget.cliente.cedula).update({

                          "cedula":Cedula.text,
                          "nombre":Nombre.text,
                          "direccion":Direccion.text,
                          "telefono":Telefono.text,
                          "celular":Celular.text,


                        });
                        Fluttertoast.showToast(msg: "Datos Actualizados Exitosamente...", toastLength: Toast.LENGTH_LONG, fontSize: 20, backgroundColor: Colors.red,
                            textColor: Colors.lightGreen, gravity: ToastGravity.CENTER);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Actualizar"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: (){
                      CollectionReference elimina = FirebaseFirestore.instance.collection("Clientes");
                      elimina.doc(widget.cliente.cedula).delete();
                      Fluttertoast.showToast(msg: "Cliente Eliminado...", toastLength: Toast.LENGTH_LONG, fontSize: 20, backgroundColor: Colors.red,
                          textColor: Colors.lightGreen, gravity: ToastGravity.CENTER);
                      Navigator.pop(context);
                    },
                    child: Text("Eliminar"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

