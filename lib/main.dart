import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holaveci/store_main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //Inicializar Servicios
  Firebase.initializeApp().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueAccent,
        padding: EdgeInsets.all(20),
        child: Wrap(children: [
          Text(
            "Bienvenido a Hola Veci",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Image.network(
            "https://drive.google.com/uc?export=view&id=1-NgBTuBPWhRt7EgdsW1vTq54E7UJhzrK",
            scale: 3.0,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Store_Main()));
          },
          icon: Icon(Icons.arrow_forward),
          label: Text("Ingresar")),
    );
  }
}