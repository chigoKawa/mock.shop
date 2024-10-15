import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modular_ui/modular_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          MUIPrimaryButton(
            text: "Primary Button",
            onPressed: () => {},
          ),
          ElevatedButton(
            onPressed: () {
              context.goNamed("/login");
            },
            child: const Text("Login"),
          )
        ],
      ),
    );
  }
}
