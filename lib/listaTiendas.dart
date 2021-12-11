import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:holaveci/category_search.dart';
import 'package:holaveci/register_order.dart';
import 'package:holaveci/registrarPedido.dart';
import 'drawer_menu.dart';
import 'main.dart';


class listaTiendas extends StatefulWidget {
  final String cedula;
  const listaTiendas({required this.cedula});

  @override
  _listaTiendasState createState() => _listaTiendasState();
}

class _listaTiendasState extends State<listaTiendas> {
  List lista = [];
  List codigos = [];

  void initState(){
    super.initState();
    getTiendas();
  }

void getTiendas() async {
    CollectionReference tienda = FirebaseFirestore.instance.collection("TiposNegocio");
    QuerySnapshot datos = await tienda.get();
    String id = "";
    if(datos.docs.length>0){
      for(var doc in datos.docs){
        lista.add(doc.data());
        id = doc.id.toString();
        codigos.add(id);
      }
    }
    setState(() {

    });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listado de Tiendas"),
      ),
      drawer: DrawerNavigation(),
      body: Center(
        child: ListView.builder(
            itemCount: lista.length,
            itemBuilder: (BuildContext context,i){
              return ListTile(
                title: miCardNegocio(url: lista[i]['Foto'], texto: "Tienda: " + lista[i]['Nombre']
                    + ".\n Dirección: " + lista[i]['Direccion']
                    + ".\n Celular: " + lista[i]['Celular'].toString()),
                    onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>registrarPedido(id: codigos[i], cedula: widget.cedula)));
                      }
              );
            }
        ),
      ),
    );
  }
}
