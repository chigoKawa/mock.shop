import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/main.dart';
import 'package:modular_ui/modular_ui.dart';

class ProductsPage extends StatelessWidget {
  final String? handle;
  const ProductsPage({super.key, this.handle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(handle ?? "Product Handle"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: MUIBlogCard(
            title: handle ?? "title",
            description: "description",
            onBlogCardPressed: () {},
            image: Image.network(
                "https://demostore.mock.shop/cdn/shop/products/GreenMenscrew01.jpg?v=1675454919&width=360"),
            date: "20.09.2024",
            circularAvatarImages: []),
      ),
    );
  }
}
