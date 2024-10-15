import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/main.dart';
import 'package:modular_ui/modular_ui.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: MUISignInCard(
              emailController: TextEditingController(),
              passwordController: TextEditingController(),
              onSignInPressed: () async {
                // GoRouter.of(context).go("/a");
                context.go("/");
                // context.goNamed("/home");
              },
              onRegisterNow: () {
                context.go("/products/shirt");
              }),
        ),
      ),
    );
  }
}
