import 'package:holaveci/category_search.dart';
import 'package:flutter/material.dart';
import 'package:holaveci/registerClients.dart';
import 'package:url_launcher/url_launcher.dart';


class store_details extends StatelessWidget {
  final datosNegocio negocio;
  const store_details({required this.negocio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de '+negocio.Nombre),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          miCardNegocio(url: negocio.Foto, texto: negocio.Nombre+' '+negocio.Direccion),
          ElevatedButton(
              onPressed: (){
                launch(negocio.Web);

              }, child: Text('Ir a '+negocio.Web))
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
