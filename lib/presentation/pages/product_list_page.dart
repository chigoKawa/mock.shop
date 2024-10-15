import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/data/datasources/product_remote_data_source.dart';
import 'package:go_router_demo/domain/entities/product.dart';
import 'package:go_router_demo/domain/repositories/product_repository_impl.dart';
import 'package:go_router_demo/domain/usecases/get_products.dart';
import 'package:http/http.dart' as http;
import 'package:modular_ui/modular_ui.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  Future<List<Product>> fetchProducts() async {
    final productRepository = ProductRepositoryImpl(
        remoteDataSource: ProductRemoteDataSourceImpl(client: http.Client()));
    final getProducts = GetProducts(repository: productRepository);

    return getProducts.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final products = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                // shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        GoRouter.of(context).go(
                          '/products/${product.handle}',
                          extra: product,
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.network(
                              product.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("\$${product.price}"),
                          ),
                        ],
                      ),
                    ),
                  );

                  return ListTile(
                    hoverColor: Colors.deepPurple,
                    title: OverflowBox(
                      child: MUIBlogCard(
                        circularAvatarImages: [],
                        date: "\$ ${product.price}",
                        image: Image.network(product.imageUrl),
                        title: product.title,
                        description: product.description,
                        onBlogCardPressed: () {
                          GoRouter.of(context).go(
                            '/products/${product.handle}',
                            extra: product,
                          );
                        },
                      ),
                    ),
                    onTap: () {
                      GoRouter.of(context).go(
                        '/products/${product.handle}',
                        extra: product,
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('No products available'));
          }
        },
      ),
    );
  }
}
