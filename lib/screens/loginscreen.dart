

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Temple_App/bloc/loginbloc.dart';
import 'onboardingScreen.dart';
import 'SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => LoginScreenstate();
}

class LoginScreenstate extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool isObscure = true;

  final emailController = TextEditingController();
  final passController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

 
  late AnimationController _logoController;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

   
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

  
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _scaleAnim = Tween<double>(begin: 0.95, end: 1.08).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _fadeAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        
          Container(
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
          ),


          Positioned(
            top: -80,
            left: -50,
            child: _circle(180, Colors.orange.withOpacity(0.15)),
          ),
          Positioned(
            bottom: -80,
            right: -50,
            child: _circle(220, Colors.deepOrange.withOpacity(0.10)),
          ),

     
          Center(
            child: SingleChildScrollView(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) async {
                      if (state is LoginSuccess) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool("isLoggedIn", true);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => OnboardingScreen()),
                        );
                      }

                      if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                          children: [

                            AnimatedBuilder(
                              animation: _logoController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _scaleAnim.value,
                                  child: Opacity(
                                    opacity: _fadeAnim.value,
                                    child: Container(
                                      padding: const EdgeInsets.all(18),
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
                                            color: Colors.orange.withOpacity(0.25),
                                            blurRadius: 25,
                                            spreadRadius: 5,
                                          )
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.temple_hindu,
                                        size: 90,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 10),

                            const Text(
                              "TEMPLE APP",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                letterSpacing: 2,
                              ),
                            ),

                            const SizedBox(height: 5),

                            const Text(
                              "Experience divine access",
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),

                            const SizedBox(height: 30),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 18, sigmaY: 18),
                                child: Container(
                                  padding: const EdgeInsets.all(22),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.65),
                                    borderRadius: BorderRadius.circular(28),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.orange.withOpacity(0.15),
                                        blurRadius: 25,
                                        offset: const Offset(0, 10),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      _inputField(
                                        controller: emailController,
                                        icon: Icons.email_outlined,
                                        label: "Email",
                                        obscure: false,
                                        textColor: Colors.black87,
                                      ),

                                      const SizedBox(height: 15),

                                      _inputField(
                                        controller: passController,
                                        icon: Icons.lock_outline,
                                        label: "Password",
                                        obscure: isObscure,
                                        textColor: Colors.black87,
                                        suffix: IconButton(
                                          icon: Icon(
                                            isObscure
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.black54,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              isObscure = !isObscure;
                                            });
                                          },
                                        ),
                                      ),

                                      const SizedBox(height: 25),

                                      state is AuthLoading
                                          ? const CircularProgressIndicator(
                                              color: Colors.deepOrange,
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                context.read<AuthBloc>().add(
                                                      LoginEvent(
                                                        emailController.text.trim(),
                                                        passController.text.trim(),
                                                      ),
                                                    );
                                              },
                                              child: Container(
                                                height: 52,
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      Colors.orange,
                                                      Colors.deepOrange
                                                    ],
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.orange
                                                          .withOpacity(0.3),
                                                      blurRadius: 15,
                                                      offset:
                                                          const Offset(0, 8),
                                                    )
                                                  ],
                                                ),
                                                child: const Text(
                                                  "LOGIN",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "New user? ",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SignupScreen()),
                                    );
                                  },
                                  child: const Text(
                                    "Create account",
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
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

  Widget _inputField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required bool obscure,
    required Color textColor,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
        prefixIcon: Icon(icon, color: Colors.deepOrange),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
