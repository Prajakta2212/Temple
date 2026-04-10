import 'package:flutter/material.dart';
import 'package:Temple_App/screens/onboardingScreen.dart';
import 'package:Temple_App/screens/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    String username = prefs.getString("username") ?? "";

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnboardingScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(
        children: [

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ganeshjilogo.png',
                  height: 150,
                ),

               
              ],
            ),
          ),

       
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Image.asset(
              'assets/from furation.png',
              height: 50,
            ),
          ),
        ],
      ),
    ),
  );
}
}