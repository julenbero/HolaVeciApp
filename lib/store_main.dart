import 'package:flutter/material.dart';
import 'package:holaveci/categories_scroll.dart';
import 'package:holaveci/drawer_menu.dart';
import 'package:holaveci/mapas.dart';

class Store_Main extends StatefulWidget {
  const Store_Main({Key? key}) : super(key: key);

  @override
  _Store_MainState createState() => _Store_MainState();
}

class _Store_MainState extends State<Store_Main> {
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
          padding: EdgeInsets.all(10),
          child: CategoriesScroll()
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
