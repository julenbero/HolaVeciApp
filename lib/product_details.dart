import 'package:holaveci/category_search.dart';
import 'package:flutter/material.dart';
import 'package:holaveci/registerClients.dart';
import 'package:holaveci/register_order.dart';
import 'package:url_launcher/url_launcher.dart';


class product_details extends StatelessWidget {
  final datosProducto producto;
  const product_details({required this.producto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de '+producto.nombreproducto),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          miCardProducto(url: producto.imagen, texto: 'Nombre del producto: '+ producto.nombreproducto+
              '\n'+'Negocio: '+producto.negocio+'\n'+'Precio: '+producto.precio.toString()+'\n'),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>registerClients()));

        },
        child: Icon(Icons.add_to_photos_rounded),
      ),
    );
  }
}
