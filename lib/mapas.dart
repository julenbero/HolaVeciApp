import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:holaveci/category_search.dart';
import 'package:holaveci/drawer_menu.dart';

class mapas extends StatefulWidget {
  final datosNegocioMapa negocioMap;
  const mapas({required this.negocioMap});

  @override
  _mapasState createState() => _mapasState();
}

class _mapasState extends State<mapas> {

  @override
  Widget build(BuildContext context) {
    late GeoPoint pos =widget.negocioMap.Geolocalizacion;
    final posicion = CameraPosition(
        target: LatLng(pos.latitude, pos.longitude),
        zoom: 19);
    final Set<Marker> marcador = Set();
    marcador.add(Marker(markerId: MarkerId(widget.negocioMap.Nombre),
    position: LatLng(pos.latitude, pos.longitude),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: widget.negocioMap.Nombre,
      snippet: widget.negocioMap.Categorias)
    ));
    return Scaffold(
      appBar: AppBar(
        title: Text("Geolocalizacion"),
      ),
      body: ListView(
        children: [
          miCardNegocio(url: widget.negocioMap.Foto,
              texto: widget.negocioMap.Nombre +
          '\n' + widget.negocioMap.Direccion),
          Container(
            width: 200,
            height: 300,
            child: GoogleMap(
              initialCameraPosition: posicion,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              markers: marcador,
            ),
          ),
        ],
      )
    );
  }
}