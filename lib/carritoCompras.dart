import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:holaveci/registrarPedido.dart';
import 'drawer_menu.dart';
import 'main.dart';


class carritoCompras extends StatefulWidget {
  final List<datosPedido> pedido;
  final String negocio;
  final String cliente;

  const carritoCompras({required this.pedido, required this.cliente, required this.negocio});

  @override
  _carritoComprasState createState() => _carritoComprasState();
}

class _carritoComprasState extends State<carritoCompras> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Carrito de Compra"),
        ),
        drawer: DrawerNavigation(),
        body: ListView.builder(
            itemCount: widget.pedido.length,
            itemBuilder: (BuildContext context, i){
              return ListTile(
                trailing: Icon(Icons.delete, size: 30, color: Colors.redAccent),
                title: Container(
                  padding: EdgeInsets.all(20.0), color: Colors.blue,
                  child: Text(widget.pedido[i].nombre + ' ' + widget.pedido[i].codigo + ' // ' + widget.pedido[i].precio.toString() + ' // '
                      + widget.pedido[i].cantidad.toString() + ' // ' + widget.pedido[i].precio.toString()),
                ),
                onTap: () {
                  widget.pedido.removeAt(i);
                  setState(() {

                  });
                },
              );
            }),
        bottomNavigationBar: confirmar(pedidoFinal: widget.pedido),
          );
        }
}


class confirmar extends StatelessWidget {

  final List<datosPedido> pedidoFinal;
    const confirmar({required this.pedidoFinal});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.amberAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart_sharp, size: 30),
                  label:"Agregar\nProducto"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.app_registration, size: 30),
              label:"Confirmar\nPedido"
          ),
        ],
      onTap: (indice){
        if(indice==0){
          Navigator.pop(context);
        }
        if(indice==1){
          int total =0;
          for(int i=0; <)
        }
      },
    );
  }
}
