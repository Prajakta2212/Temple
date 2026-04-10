

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Temple_App/bloc/loginbloc.dart';


class SignupScreen extends StatelessWidget {
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
      appBar: AppBar(
        title: const Text("Signup"),
        backgroundColor: Colors.orange,
      ),

      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {

          if (state is SignupSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("User Created Successfully")),
            );

            Navigator.pop(context); // ✅ back to login
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },

        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                TextField(
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: pass,
                
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                if (state is AuthLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: () {

                      final userEmail = email.text.trim();
                      final userPass = pass.text.trim();

                      if (userEmail.isEmpty || userPass.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill all fields"),
                          ),
                        );
                        return;
                      }

                      if (!isValidEmail(userEmail)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Enter valid email"),
                          ),
                        );
                        return;
                      }

                      if (!isValidPassword(userPass)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Weak password"),
                          ),
                        );
                        return;
                      }

                      context.read<AuthBloc>().add(
                            SignupEvent(userEmail, userPass),
                          );
                    },
                    child: const Text("Create Account"),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}