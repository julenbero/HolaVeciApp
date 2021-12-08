import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holaveci/store_details.dart';

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
                    onTap: (){
                      print(listado[i]);
                      datosNegocio n= datosNegocio(listado[i]['Nombre'], listado[i]['Categorias'],
                          listado[i]['Celular'], listado[i]['Direccion'], listado[i]['Foto'],
                          listado[i]['Logo'], listado[i]['Productos'],
                          listado[i]['Telefono'], listado[i]['Web']);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>store_details(negocio: n)));
                    },
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

class miCardNegocio extends StatelessWidget {

  final String url;
  final String texto;

  const miCardNegocio({required this.url, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        margin: EdgeInsets.all(20),
        elevation: 10,
        color: Colors.blueAccent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Column(
            children: [
              Image.network(url, scale: 0.5),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(0.0),
                color: Colors.blueAccent,
                child: Text(texto, style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center),
              )
            ],
          ),
        )
    );
  }
}

class datosNegocio{

  String Nombre='';
  String Categorias='';
  int Celular=0;
  String Direccion='';
  String Foto='';
  String Logo='';
  String Productos='';
  int Telefono=0;
  String Web= '';

  datosNegocio(
      this.Nombre,
      this.Categorias,
      this.Celular,
      this.Direccion,
      this.Foto,
      this.Logo,
      this.Productos,
      this.Telefono,
      this.Web);
}

