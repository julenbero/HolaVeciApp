import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holaveci/product_details.dart';
import 'package:holaveci/store_details.dart';

class Register_Order extends StatefulWidget {
  final String datobusqueda;

  const Register_Order(this.datobusqueda, {Key? key}) : super(key: key);

  @override
  _Register_OrderState createState() => _Register_OrderState();
}

class _Register_OrderState extends State<Register_Order> {
  List listado = [];

  void initState() {
    super.initState();
    forCategory();
  }

  void forCategory() async {
    CollectionReference categories =
    FirebaseFirestore.instance.collection("TiposProducto");
    QuerySnapshot result = await categories
        .where("Nombre", isEqualTo: widget.datobusqueda)
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
        title: Text("Productos por Negocio"),
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
                      datosProducto n= datosProducto(listado[i]['imagen'], listado[i]['negocio'],
                          listado[i]['nombreProducto'], listado[i]['precio']);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>product_details(producto: n)));
                    },
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(listado[i]['imagen']),
                    ),
                    title: Text(
                      listado[i]['nombreProducto'] + " " +listado[i]['precio'].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    //subtitle: Text(listado[i]['Categorias'] +
                    //    " - " +
                    //    listado[i]['Productos']
                    //),
                  ));
            }),
      ),
    );
  }
}

class miCardProducto extends StatelessWidget {

  final String url;
  final String texto;

  const miCardProducto({required this.url, required this.texto});

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

class datosProducto{

  String imagen='';
  String negocio='';
  int precio=0;
  String nombreproducto='';


  datosProducto(
      this.imagen,
      this.negocio,
      this.nombreproducto,
      this.precio,
      );
}