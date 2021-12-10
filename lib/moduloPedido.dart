import 'package:holaveci/store_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'actualizarCliente.dart';
import 'drawer_menu.dart';
import 'listaTiendas.dart';
import 'main.dart';

class moduloPedidos extends StatefulWidget {
  const moduloPedidos({Key? key}) : super(key: key);

  @override
  _moduloPedidosState createState() => _moduloPedidosState();
}

class _moduloPedidosState extends State<moduloPedidos> {

  final cedula = TextEditingController();

  CollectionReference cliente = FirebaseFirestore.instance.collection(
      "Clientes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modulo Pedidos"),
      ),
      drawer: DrawerNavigation(),
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
                  icon: Icon(Icons.person, color: Colors.blue, size: 30),
                  hintText: "Ingrese numero de cedula",
                  hintStyle: TextStyle(color: Colors.yellow,
                      fontStyle: FontStyle.italic,
                      fontSize: 14)
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () async {
                QuerySnapshot verifica = await cliente.where(
                    FieldPath.documentId, isEqualTo: cedula.text).get();
                List lista = [];
                if (verifica.docs.length > 0) {
                  for (var cli in verifica.docs) {
                    lista.add(cli.data());
                  }
                  Fluttertoast.showToast(msg: "Comprobación exitosa...",
                      toastLength: Toast.LENGTH_LONG,
                      fontSize: 20,
                      backgroundColor: Colors.red,
                      textColor: Colors.lightGreen,
                      gravity: ToastGravity.CENTER);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => listaTiendas(cedula: cedula.text)));
                } else {
                  Fluttertoast.showToast(msg: "Datos Incorrectos...",
                      toastLength: Toast.LENGTH_LONG,
                      fontSize: 20,
                      backgroundColor: Colors.red,
                      textColor: Colors.lightGreen,
                      gravity: ToastGravity.CENTER);
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

