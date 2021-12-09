import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holaveci/category_search.dart';
import 'package:holaveci/mapas.dart';

class CategoriesScroll extends StatefulWidget {
  const CategoriesScroll({Key? key}) : super(key: key);

  @override
  _CategoriesScrollState createState() => _CategoriesScrollState();
}

class _CategoriesScrollState extends State<CategoriesScroll> {
  List ListaCategorias = [];
  List tabla_negocios = [];

  void initState() {
    super.initState();
    getCategorias();
    getNegocios();
  }

  void getCategorias() async {
    //Funcion para consultar personas
    CollectionReference datos =
        FirebaseFirestore.instance.collection("Categorias");
    QuerySnapshot categorias = await datos.get();
    if (categorias.docs.length > 0) {
      //print("Trae Datos");
      for (var doc in categorias.docs) {
        print(doc.data());
        setState(() {
          ListaCategorias.add(doc.data());
        });
      }
    } else {
      print("Ups....Algo Fallo");
    }
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
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categorias',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
                itemCount: ListaCategorias.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext, i) {
                  return InkWell(
                    onTap: (){
                      //print(ListaCategorias[i]['Nombre']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Category_Search(StringUtils.capitalize(ListaCategorias[i]['Nombre'], allWords: true))));
                    },
                    child: Container(
                        height: categoryHeight,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            image: DecorationImage(
                              image: NetworkImage(ListaCategorias[i]['Imagen']),
                              fit: BoxFit.fill,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0))),
                        margin: EdgeInsets.all(10),

                        child: Center(
                          child: Text(
                            ListaCategorias[i]['Nombre'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                          ),
                        )),
                  );
                }),
          ),
          Text(
            'Listado Negocios',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Container(
            height: 350,
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
                        onTap: (){
                          datosNegocioMapa nego = datosNegocioMapa(
                              tabla_negocios[i]['Nombre'],
                              tabla_negocios[i]['Categorias'],
                              tabla_negocios[i]['Celular'],
                              tabla_negocios[i]['Direccion'],
                              tabla_negocios[i]['Foto'],
                              tabla_negocios[i]['Logo'],
                              tabla_negocios[i]['Productos'],
                              tabla_negocios[i]['Telefono'],
                              tabla_negocios[i]['Web'],
                              tabla_negocios[i]['Geolocalizacion']);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>mapas(negocioMap: nego)));
                        },
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              NetworkImage(tabla_negocios[i]['Logo']),
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
          )
        ],
      ),
    );
  }
}
