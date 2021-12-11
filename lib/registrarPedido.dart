import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:holaveci/carritoCompras.dart';
import 'drawer_menu.dart';
import 'main.dart';

class registrarPedido extends StatefulWidget {
  final String id, cedula;
  const registrarPedido({required this.id, required this.cedula});

  @override
  _registrarPedidoState createState() => _registrarPedidoState();
}

class _registrarPedidoState extends State<registrarPedido> {

  List listaProductos = [];
  List codigosProductos = [];
  List<datosPedido> pedido = [];

void initState(){
  super.initState();
  getProductos();
}

void getProductos () async {
    CollectionReference productos = FirebaseFirestore.instance.collection("TiposProducto");
    String cod = '';
    QuerySnapshot datos = await productos.where('negocio', isEqualTo: widget.id).get();
    if(datos.docs.length>0){
      for (var doc in datos.docs){
        listaProductos.add(doc.data());
        cod = doc.id.toString();
        codigosProductos.add(cod);
      }
    }
    setState(() {

    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Pedido"),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>carritoCompras(
                    pedido: pedido, cliente: widget.id, negocio: widget.cedula)));
              },
              icon: Icon(Icons.shopping_cart_rounded, size: 40, color: Colors.black,))
        ],
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
        itemCount: listaProductos.length,
          itemBuilder: (BuildContext context, i){
          var Cant = TextEditingController();
          return ListTile(
            trailing: Icon(Icons.add_circle_sharp, size: 30, color: Colors.blueGrey),
            title: Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.lightBlueAccent,
              child: Text("Producto: "+ listaProductos[i]['nombreProducto'] +'\nPrecio: '+ listaProductos[i]['precio'].toString()),
            ),
            subtitle: TextField(
              decoration: InputDecoration(hintText: 'Ingrese Cantidad'),
              keyboardType: TextInputType.number,
              controller: Cant,
            ),
            onTap: (){
              if(Cant.text.isEmpty){
                Cant.text = '0';
              }
              int total = (int.parse(Cant.text)) * (int.parse(listaProductos[i]['precio'].toString()));
              print(total.toString());
              datosPedido p = datosPedido(codigosProductos[i], listaProductos[i]['nombreProducto'],
                  listaProductos[i]['precio'], int.parse(Cant.text), total);
              pedido.add(p);
            },
          );
          })
    );
  }
}

class datosPedido {
  String codigo = '';
  String nombre = '';
  int precio = 0;
  int cantidad = 0;
  int total = 0;

  datosPedido(this.codigo, this.nombre, this.precio, this.cantidad, this.total);
}








