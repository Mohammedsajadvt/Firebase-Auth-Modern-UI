import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/components/my_button.dart';
import 'package:login/components/my_textfield.dart';
import 'package:login/domain/bloc/auth/auth_bloc.dart';
import 'package:login/domain/bloc/auth/auth_event.dart';
import 'package:login/domain/bloc/auth/auth_state.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthAuthenticated){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('SignUp Success')));

          }else if(state is AuthError){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SafeArea(
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
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
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
                    controller: usernameController,
                    hintText: 'Username',
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
                  const SizedBox(
                    height: 25,
                  ),
                  MyButton(
                    text: 'Sign Up',
                    onTap: () {
                      var email = emailController.text;
                      var password = passwordController.text;
                      var displayName = passwordController.text;
                      context
                          .read<AuthBloc>()
                          .add(SignUpEvent(email, password, displayName));
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
