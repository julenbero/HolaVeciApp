import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holaveci/store_details.dart';

class Products_Search extends StatefulWidget {
  final String datobusqueda;

  const Products_Search(this.datobusqueda, {Key? key}) : super(key: key);

  @override
  _Products_SearchState createState() => _Products_SearchState();
}

class _Products_SearchState extends State<Products_Search> {
  List listado = [];

  void initState() {
    super.initState();
    porProductos();
  }

  void porProductos() async {
    CollectionReference productos =
        FirebaseFirestore.instance.collection("TiposNegocio");
    QuerySnapshot result = await productos
        .where("Productos", isEqualTo: widget.datobusqueda)
        .get();
    if (result.docs.length != 0) {
      print("Trae Datos");
      for (var store in result.docs) {
        print(store.data());
        setState(() {
          listado.add(store.data());
        });
      }
    } else {
      print("Ups......Algo Fallo");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Negocios por Producto"),
      ),
      body: Center(
        child: ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: listado.length,
            itemBuilder: (BuildContext, i) {
              return Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 6,
                  color: Colors.lightBlue,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(listado[i]['Logo']),
                    ),
                title: Text(
                  listado[i]['Nombre'] + " " + listado[i]['Celular'].toString(),
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                subtitle: Text(
                    listado[i]['Categorias'] + " - " + listado[i]['Productos']),
              ));
            }),
      ),
    );
  }
}
