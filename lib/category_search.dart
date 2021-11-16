import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Category_Search extends StatefulWidget {
  final String datobusqueda;

  const Category_Search(this.datobusqueda, {Key? key}) : super(key: key);

  @override
  _Category_SearchState createState() => _Category_SearchState();
}

class _Category_SearchState extends State<Category_Search> {
  List listado = [];

  void initState() {
    super.initState();
    forCategory();
  }

  void forCategory() async {
    CollectionReference categories =
        FirebaseFirestore.instance.collection("TiposNegocio");
    QuerySnapshot result = await categories
        .where("Categorias", isEqualTo: widget.datobusqueda)
        .get();
    if (result.docs.length != 0) {
      print("Trae Datos");
      for (var cat in result.docs) {
        print(cat.data());
        setState(() {
          listado.add(cat.data());
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
        title: Text("Negocios por Categoria"),
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
                      listado[i]['Nombre'] +
                          " " +
                          listado[i]['Celular'].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    subtitle: Text(listado[i]['Categorias'] +
                        " - " +
                        listado[i]['Productos']),
                  ));
            }),
      ),
    );
  }
}
