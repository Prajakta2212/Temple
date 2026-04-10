import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Temple_App/bloc/loginbloc.dart';
import 'package:Temple_App/screens/splash.dart';
import 'package:Temple_App/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();


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
