import 'package:flutter/material.dart';
import 'package:holaveci/products_search.dart';
import 'package:holaveci/category_search.dart';
import 'package:holaveci/register_order.dart';

class orders extends StatelessWidget {
  TextEditingController datobusqueda = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modulo de Pedidos"),
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
                    hintText: "Ingrese Nombre del Negocio"),
              ),
            ),
            ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Buscar"),
                  Icon(Icons.storefront)
                ],
              ),
              onPressed: () {
                //var busqueda = "Buscar por producto";
                //print(busqueda);
                if (datobusqueda.text != "") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Register_Order(datobusqueda.text)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
