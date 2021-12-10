import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:holaveci/comprobarCliente.dart';
import 'package:holaveci/mensaje.dart';
import 'package:holaveci/moduloPedido.dart';
import 'package:holaveci/orders.dart';
import 'package:holaveci/provider_Google.dart';
import 'package:holaveci/registerClients.dart';
import 'package:holaveci/store_search.dart';
import 'package:provider/provider.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(user.displayName!),
              accountEmail: Text(user.email!),
              currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL!),
            )

            // CircleAvatar(
            //   backgroundColor: Colors.blueAccent,
            //   child: Text("U",style: TextStyle(color: Colors.white, fontSize: 40),),
            // ),
          ),
          ListTile(
            leading: Icon(Icons.manage_search),
            title: Text("Modulo de Busqueda"),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Store_Search()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add),
            title: Text("Registro de Clientes"),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => registerClients()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person_search),
            title: Text("Actualizar Datos"),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => comprobarCliente()));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text("Modulo de Pedidos"),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => orders()));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text("Notificaciones"),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => mensaje()));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text("Modulo Ordenar Productos"),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => moduloPedidos()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person_off),
            title: Text("Cerrar Sesion"),
            onTap: (){
              final provider = Provider.of<ProviderGoogle>(context, listen: false);
              provider.googleLogout();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => orders()));
            },
          ),
        ],
      ),
    );
  }
}

class datosNegocioMapa{
  String Nombre = '';
  String Categorias = '';
  int Celular = 0;
  String Direccion = '';
  String Foto = '';
  String Logo = '';
  String Productos = '';
  int Telefono = 0;
  String Web = '';
  late GeoPoint Geolocalizacion;

  datosNegocioMapa(
      this.Nombre,
      this.Categorias,
      this.Celular,
      this.Direccion,
      this.Foto,
      this.Logo,
      this.Productos,
      this.Telefono,
      this.Web,
      this.Geolocalizacion);
}
