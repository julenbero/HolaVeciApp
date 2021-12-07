import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapas extends StatefulWidget {
  const mapas({Key? key}) : super(key: key);

  @override
  _mapasState createState() => _mapasState();
}

class _mapasState extends State<mapas> {

  @override
  Widget build(BuildContext context) {
    final posicion = CameraPosition(
        target: LatLng(4.716683, -74.031128),
        zoom: 15);
    return Scaffold(
      appBar: AppBar(
        title: Text("Geolocalizacion"),
      ),
      body: GoogleMap(
        initialCameraPosition: posicion,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        mapType: MapType.satellite,
      ),
    );
  }
}