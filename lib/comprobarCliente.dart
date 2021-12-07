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
                  icon: Icon(Icons.person, color: Colors.blue, size: 30),
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
                  icon: Icon(Icons.person, color: Colors.blue, size: 30),
                  hintText: "Ingrese su correo",
                  hintStyle: TextStyle(color: Colors.yellow, fontStyle: FontStyle.italic,fontSize: 14)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () async {
                QuerySnapshot verifica = await cliente.where(FieldPath.documentId, isEqualTo: cedula.text).where("telefono", isEqualTo: telefono.text).get();
                List lista=[];
                if(verifica.docs.length>0){
                  for(var cli in verifica.docs){
                    lista.add(cli.data());
                  }
                  datosCliente dCli = datosCliente(cedula.text, lista[0]['nombre'], lista[0]['direccion'], lista[0]['telefono'], lista[0]['celular']);
                  Fluttertoast.showToast(msg: "Comprobación exitosa...", toastLength: Toast.LENGTH_LONG, fontSize: 20, backgroundColor: Colors.red,
                      textColor: Colors.lightGreen, gravity: ToastGravity.CENTER);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>actualizarCliente(cliente: dCli)));
                }else{
                  Fluttertoast.showToast(msg: "Datos Incorrectos...", toastLength: Toast.LENGTH_LONG, fontSize: 20, backgroundColor: Colors.red,
                      textColor: Colors.lightGreen, gravity: ToastGravity.CENTER);
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