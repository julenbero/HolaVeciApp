import 'package:flutter/material.dart';
import 'package:holaveci/products_search.dart';
import 'package:holaveci/category_search.dart';

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
                              Category_Search(datobusqueda.text)));
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
                              Products_Search(datobusqueda.text)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
