
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Temple_App/bloc/loginbloc.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(email);
  }

  bool isValidPassword(String password) {
    return RegExp(r'^(?=.*[@$!%*?&])(?=.*[0-9]).{8,}$')
        .hasMatch(password);
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

        
          SafeArea(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is SignupSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("User Created Successfully"),
                    ),
                  );
                  Navigator.pop(context);
                }

                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox(height: 40),

                         
                          const Text(
                            "Create Account ✨",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 6),

                          const Text(
                            "Start your spiritual journey",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
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
                                      controller: email,
                                      icon: Icons.email_outlined,
                                      label: "Email",
                                      obscure: false,
                                    ),

                                    const SizedBox(height: 15),

                                    _inputField(
                                      controller: pass,
                                      icon: Icons.lock_outline,
                                      label: "Password",
                                      obscure: true,
                                    ),

                                    const SizedBox(height: 25),

                                   
                                    state is AuthLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.deepOrange,
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              final userEmail =
                                                  email.text.trim();
                                              final userPass =
                                                  pass.text.trim();

                                              if (userEmail.isEmpty ||
                                                  userPass.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Please fill all fields"),
                                                  ),
                                                );
                                                return;
                                              }

                                              if (!isValidEmail(userEmail)) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Enter valid email"),
                                                  ),
                                                );
                                                return;
                                              }

                                              if (!isValidPassword(userPass)) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content:
                                                        Text("Weak password"),
                                                  ),
                                                );
                                                return;
                                              }

                                              context.read<AuthBloc>().add(
                                                    SignupEvent(
                                                        userEmail, userPass),
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
                                                "SIGN UP",
                                                style: TextStyle(
                                                  color: Colors.white,
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

                          const SizedBox(height: 25),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account? ",
                                style: TextStyle(color: Colors.black54),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _inputField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required bool obscure,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            const TextStyle(color: Colors.black54),
        prefixIcon: Icon(icon, color: Colors.deepOrange),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
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
