import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holaveci/drawer_menu.dart';

class Store_Main extends StatefulWidget {
  const Store_Main({Key? key}) : super(key: key);

  @override
  _Store_MainState createState() => _Store_MainState();
}

class _Store_MainState extends State<Store_Main> {
  List tabla_negocios = [];

  void initState() {
    super.initState();
    getNegocios();
  }

  void getNegocios() async {
    //Funcion para consultar personas
    CollectionReference datos =
        FirebaseFirestore.instance.collection("TiposNegocio");
    QuerySnapshot negocios = await datos.get();
    if (negocios.docs.length > 0) {
      //print("Trae Datos");
      for (var doc in negocios.docs) {
        print(doc.data());
        setState(() {
          tabla_negocios.add(doc.data());
        });
      }
    } else {
      print("Ups....Algo Fallo");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Negocios"),
          actions: [
            TextButton(onPressed: (){}, child: Text('Cerrar Sesion'))
          ],
        ),
        body: Container(
          child: Center(
            child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: tabla_negocios.length,
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
                       backgroundImage: NetworkImage(tabla_negocios[i]['Logo']),
                     ),
                      //tileColor: Colors.blueAccent,
                     title: Text(
                       tabla_negocios[i]['Nombre'] +
                           " " +
                           tabla_negocios[i]['Celular'].toString(),
                       style: TextStyle(color: Colors.white, fontSize: 22),
                     ),
                     subtitle: Text(tabla_negocios[i]['Categorias'] +
                         " - " +
                         tabla_negocios[i]['Productos']),
                   ),
                  );
                }),
          ),
        ),
      drawer: DrawerNavigation(),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (context) => Store_Search()));
      //     },
      //     icon: Icon(Icons.youtube_searched_for),
      //     label: Text("Busqueda")),
    );
  }
}
