import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Temple_App/bloc/loginbloc.dart';
import 'package:Temple_App/screens/splash.dart';
import 'package:Temple_App/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //     apiKey: "AIzaSyB317vWVkq4wARb5kZ2_EW_L8P5ukrDn9k",
  //     authDomain: "hotel-46ffd.firebaseapp.com",
  //     projectId: "hotel-46ffd",
  //     storageBucket: "hotel-46ffd.firebasestorage.app",
  //     messagingSenderId: "1044975682056",
  //     appId: "1:1044975682056:web:6da51e0ee248c1e34147bd",
  //     measurementId: "G-KM78D4FP7D",
  //   ),
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    final AuthService authService = AuthService();
   MyApp({super.key});

  
  Widget build(BuildContext context) {
    
    return BlocProvider(
    create: (_) => AuthBloc(authService),
    child: 
    MaterialApp(
      title: 'Flutter Demo',
     debugShowCheckedModeBanner: false,
      home: Splash() ,
    ));
  }
}
