import 'package:flutter/material.dart';
import 'package:holaveci/provider_Google.dart';
import 'package:provider/provider.dart';
import 'package:social_auth_buttons/social_auth_buttons.dart';

class SignUpMain extends StatelessWidget {
  const SignUpMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.blueAccent,
      padding: EdgeInsets.all(20),
      child: Column(children: [
        Spacer(),
        Text(
          "Bienvenido a Hola Veci",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Spacer(),
        Image.network(
          "https://drive.google.com/uc?export=view&id=1-NgBTuBPWhRt7EgdsW1vTq54E7UJhzrK",
          scale: 3.0,
        ),
        Spacer(),
        // ElevatedButton.icon(
        //   onPressed: () {},
        //   icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
        //   label: Text("Sign Up with Google"),
        //   style: ElevatedButton.styleFrom(
        //       primary: Colors.blue,
        //       onPrimary: Colors.white,
        //       minimumSize: Size(double.infinity, 50)),
        // ),
        GoogleAuthButton(
          onPressed: () {
            final provider = Provider.of<ProviderGoogle>(context, listen: false);
            provider.googleLogin();
          },
          darkMode: false,
          text: 'Ingresa con Google',
          textStyle: TextStyle(fontSize: 18),
          style: null,
          width: 250,
        ),
      ]),
    );
  }
}
