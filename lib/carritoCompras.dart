import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:holaveci/listaTiendas.dart';
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
          title: Text("Carrito de Compras"),
        ),
        drawer: DrawerNavigation(),
        body: ListView.builder(
            itemCount: widget.pedido.length,
            itemBuilder: (BuildContext context, i){
              return ListTile(
                trailing: Icon(Icons.remove_circle , size: 30, color: Colors.redAccent),
                title: Container(
                  padding: EdgeInsets.all(20.0), color: Colors.lightBlueAccent,
                  child: Text('Producto(s): ' + widget.pedido[i].nombre +'\nPrecio Unidad: ' + widget.pedido[i].precio.toString()
                      + '\nUnidades Solicitadas: '+ widget.pedido[i].cantidad.toString() + '\nSubtotal:  ' + widget.pedido[i].total .toString()),
                ),
                onTap: () {
                  widget.pedido.removeAt(i);
                  setState(() {

                  });
                },
              );
            }),
        bottomNavigationBar: confirmar(pedidoFinal: widget.pedido, cedula: widget.cliente, idNegocio: widget.negocio)
          );
        }
}


class confirmar extends StatelessWidget {

  final List<datosPedido> pedidoFinal;
  final String cedula;
  final String idNegocio;
  const confirmar({required this.pedidoFinal, required this.cedula, required this.idNegocio});

  
  void registrarDetalle(idPedido)
  {
    CollectionReference detalle = FirebaseFirestore.instance.collection("DetallePedido");
    for(int dato=0; dato<pedidoFinal.length; dato++){
      detalle.add({
        "pedido": idPedido,
        "producto": pedidoFinal[dato].codigo,
        "cantiad": pedidoFinal[dato].cantidad,
        "total": pedidoFinal[dato].total
      });
    }
  }
  
  
  
  

  void registrar(){

    DateTime hoy = new DateTime.now();
    DateTime fecha = new DateTime(hoy.year, hoy.month, hoy.day);
    int total=0;
    for(int i=0; i<pedidoFinal.length;i++){
      total+=pedidoFinal[i].total;
    }
    CollectionReference pedido = FirebaseFirestore.instance.collection("Pedidos");
    pedido.add(
      {
        "cedula": cedula,
        "negocio": idNegocio,
        "fecha": fecha,
        "total": total
      }).then((value) => registrarDetalle(value.id));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.lightBlue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded, size: 30),
                  label:"Agregar más\nProductos"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.checklist_outlined, size: 30),
              label:"Confirmar\nPedido"
          ),
        ],
      onTap: (indice){
        if(indice==0){
          Navigator.pop(context);
        }
        if(indice==1){
          int total=0;
          for(int i=0; i<pedidoFinal.length;i++){
            total+=pedidoFinal[i].total;
          }
          showDialog(
              context: context,
              builder: (context)=>AlertDialog(
                title: Text("Confirmar Pedido", style: TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.green, fontSize: 25),),
                contentPadding: EdgeInsets.all(20.0),
                content: Text("Total a Pagar: " + total.toString(), style: TextStyle(color:Colors.green, fontSize: 18),),
             actions: [
               ElevatedButton(
                   onPressed: (){
                      registrar();
                      Fluttertoast.showToast(msg: "Su pedidio ha sido registrado",
                          toastLength: Toast.LENGTH_LONG,
                          fontSize: 20,
                          backgroundColor: Colors.lightGreen,
                          textColor: Colors.white,
                          gravity: ToastGravity.CENTER);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>listaTiendas(cedula:cedula)));
                    },
                    child: Text("Confirmar")),
               ElevatedButton(
                   onPressed: (){
                     Navigator.of(context).pop();
                   },
                   child: Text("Cancelar"))
             ],
              ));
        }
      },
    );
  }
}
