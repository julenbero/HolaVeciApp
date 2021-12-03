import 'package:flutter/material.dart';
import 'package:holaveci/products_search.dart';
import 'package:holaveci/category_search.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Store_Search extends StatelessWidget {
  TextEditingController datobusqueda = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modulo de Busqueda"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: datobusqueda,
                decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey, size: 24),
                    hintText: "Ingrese una Categoria o Producto"),
              ),
            ),
            ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Buscar por Categoria"),
                  Icon(Icons.storefront)
                ],
              ),
              onPressed: () {
                //var busqueda = "Buscar por Categoria";
                //print(busqueda);
                if (datobusqueda.text != "") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Category_Search(StringUtils.capitalize(datobusqueda.text, allWords: true))));
                }else{
                  Fluttertoast.showToast(
                      msg: "Debes ingresar datos en el campo",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 12.0
                  );
                }
              },
            ),
            ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Buscar por Producto"),
                  Icon(Icons.shopping_bag)
                ],
              ),
              onPressed: () {
                //var busqueda = "Buscar por Producto";
                //print(busqueda);
                if (datobusqueda.text != "") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Products_Search(StringUtils.capitalize(datobusqueda.text, allWords: true))));
                }else{
                  Fluttertoast.showToast(
                      msg: "Debes ingresar datos en el campo",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 12.0
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
