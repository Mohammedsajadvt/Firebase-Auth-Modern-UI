import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/components/my_button.dart';
import 'package:login/components/my_textfield.dart';
import 'package:login/components/square_title.dart';
import 'package:login/domain/bloc/auth/auth_bloc.dart';
import 'package:login/domain/bloc/auth/auth_event.dart';
import 'package:login/domain/bloc/auth/auth_state.dart';
import 'package:login/presentation/screens/signup_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: BlocListener<AuthBloc, AuthState>(
          listener: (BuildContext context, AuthState state) {
            if (state is AuthAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('SignIn Success')));
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
              return Stack(children: [
                SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Icon(
                            Icons.lock,
                            size: 100,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Welcome back you\'ve been missed!',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 16),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          MyTextfield(
                            controller: emailController,
                            hintText: 'Email',
                            obsecureText: false,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          MyTextfield(
                            controller: passwordController,
                            hintText: 'Password',
                            obsecureText: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          MyButton(
                            text: 'Sign In',
                            onTap: () {
                              var email = emailController.text;
                              var password = passwordController.text;
                              context
                                  .read<AuthBloc>()
                                  .add(SignInEvent(email, password));
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    'Or continue with',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ),
                                Expanded(
                                    child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SquareTitle(imagePath: "images/google.png"),
                              SizedBox(
                                width: 25,
                              ),
                              SquareTitle(imagePath: "images/apple.png"),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Not a member?',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignupPage()));
                                  },
                                  child: const Text('Register now',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold)))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
               if(state is AuthLoading)
                Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(child: CircularProgressIndicator()))
              ]);
            },
          ),
        ));
  }
}
