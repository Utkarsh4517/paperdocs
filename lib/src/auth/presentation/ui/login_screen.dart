import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:paperdocs/src/auth/data/repository/auth_repository.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInWithGoogle(WidgetRef ref, BuildContext context) async {
    final smg = ScaffoldMessenger.of(context);
    final errorModel = await ref.read(authRepositoryProvider).signInWithGoogle();
    if (errorModel.error == null) {
      smg.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  signInWithGoogle(ref, context);
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
