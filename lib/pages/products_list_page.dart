import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/main.dart';
import 'package:modular_ui/modular_ui.dart';

class ProductsListPage extends StatelessWidget {
  const ProductsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MUIPrimaryCard(
              title: "Sample 1",
              description: "This is a description for this card",
              buttons: [
                ElevatedButton(
                    onPressed: () => context.go("/products/shirt"),
                    child: Text("Go to Product"))
              ],
              image: Image.network(
                  "https://images.pexels.com/photos/28716782/pexels-photo-28716782/free-photo-of-elegant-gold-earrings-on-white-silk-fabric.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
            ),
            MUIPrimaryCard(
              title: "Sample 1",
              description: "This is a description for this card",
              image: Image.network(
                  "https://images.pexels.com/photos/28874283/pexels-photo-28874283/free-photo-of-minimal-workspace-with-laptop-and-coffee-mug.jpeg?auto=compress&cs=tinysrgb&w=800&lazy=load"),
            ),
          ],
        ),
      ),
    );
  }
}
