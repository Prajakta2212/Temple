

import 'package:flutter/material.dart';
import 'package:Temple_App/screens/onboardingScreen.dart';
import 'package:Temple_App/screens/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();

    checkLogin();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF3E0),
              Color(0xFFFFE0B2),
              Color(0xFFFFCC80),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
          
            Positioned(
              top: -80,
              left: -60,
              child: _circle(180, Colors.orange.withOpacity(0.15)),
            ),
            Positioned(
              bottom: -80,
              right: -60,
              child: _circle(200, Colors.deepOrange.withOpacity(0.10)),
            ),

            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                     
                    Container(
  padding: const EdgeInsets.all(30),
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    gradient: RadialGradient(
      colors: [
        Colors.orange.withOpacity(0.35),
        Colors.transparent,
      ],
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.orange.withOpacity(0.35),
        blurRadius: 35,
        spreadRadius: 8,
      )
    ],
  ),
  child: Image.asset(
    'assets/ganeshjilogo.png',
    height: 170,
  ),
),
                      const SizedBox(height: 20),

                      const Text(
                        "TEMPLE APP",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Divine experience awaits",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 30),

                    
                    ],
                  ),
                ),
              ),
            ),

           
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'assets/from furation.png',
                  height: 45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle(double size, Color color) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
