import 'package:flutter/material.dart';
import 'package:Temple_App/screens/SignupScreen.dart';
import 'package:Temple_App/screens/loginscreen.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              child: Text("Login"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SignupScreen()));
              },
              child: Text("Signup"),
            ),
          ],
        ),
      ),
    );
  }
}