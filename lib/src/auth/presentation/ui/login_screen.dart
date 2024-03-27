import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modular_ui/modular_ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MUISignInCard(
            emailController: TextEditingController(),
            passwordController: TextEditingController(),
            onSignInPressed: () async {
              // await AuthService().continueWithGoogle(context);
            },
            authButtons: [
              MUISecondaryButton(
                text: 'Google',
                onPressed: () async {
                },
                leadingIcon: FontAwesomeIcons.google,
              ),
              MUISecondaryButton(
                text: 'Github',
                onPressed: () {},
                leadingIcon: FontAwesomeIcons.github,
              )
            ],
            onRegisterNow: () {}),
      ),
    );
  }
}
