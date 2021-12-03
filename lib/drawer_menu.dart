import 'package:flutter/material.dart';
import 'package:holaveci/orders.dart';
import 'package:holaveci/registerClients.dart';
import 'package:holaveci/store_search.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("Nombre Usuario Hola Veci"),
              accountEmail: Text("Correo usuario@holaveci.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Text("U",style: TextStyle(color: Colors.white, fontSize: 40),),
            ),
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
            leading: Icon(Icons.add_shopping_cart),
            title: Text("Modulo de Pedidos"),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => orders()));
            },
          )
        ],
      ),
    );
  }
}
