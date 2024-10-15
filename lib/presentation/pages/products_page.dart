import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/data/datasources/product_remote_data_source.dart';
import 'package:go_router_demo/data/models/product_model.dart';
import 'package:go_router_demo/domain/entities/product.dart';
import 'package:go_router_demo/domain/repositories/product_repository_impl.dart';
import 'package:go_router_demo/domain/usecases/get_products.dart';
import 'package:go_router_demo/presentation/widgets/layout_builder_handler.dart';
import 'package:http/http.dart' as http;

class ProductsPage extends StatefulWidget {
  final String? handle;

  const ProductsPage({super.key, this.handle});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late Future<Product> _futureProduct;

  @override
  void initState() {
    super.initState();
    _futureProduct = fetchProduct(widget.handle ?? "");
  }

  void _fetchProduct() {
    // Fetch the product whenever the widget is initialized
    _futureProduct = fetchProduct(widget.handle ?? "");
  }

  @override
  void didUpdateWidget(ProductsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Fetch new product when handle changes
    if (oldWidget.handle != widget.handle) {
      _fetchProduct();
      // _futureProduct = fetchProduct(widget.handle ?? "");
    }
  }

  Future<Product> fetchProduct(String gid) async {
    final productRepository = ProductRepositoryImpl(
        remoteDataSource: ProductRemoteDataSourceImpl(client: http.Client()));
    final getProduct = GetProduct(repository: productRepository);

    return getProduct.execute(gid);
  }

  @override
  Widget build(BuildContext context) {
    // final product = GoRouterState.of(context).extra as ProductModel;
    final windowSize = MediaQuery.sizeOf(context);
    final isSmallScreen = windowSize.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.handle} | $windowSize'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: FutureBuilder(
          key: ValueKey(widget.handle),
          // future: _futureProduct,
          future: fetchProduct(widget.handle ?? ""),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final product = snapshot.data!;

              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 840),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      LayoutBuilderHandler(
                        firstPart: AspectRatio(
                            aspectRatio: isSmallScreen ? 1 : 1,
                            child: Image.network(product.imageUrl)),
                        secondPart: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(isSmallScreen
                                  ? "Small screen"
                                  : "LARGE screen"),
                              Text(product.title,
                                  style: const TextStyle(fontSize: 30)),
                              Text(product.description),
                              Text("\$${product.price}",
                                  style: const TextStyle(fontSize: 24)),
                            ],
                          ),
                        ),
                      ),
                      // Text(isSmallScreen ? "Small screen" : "LARGE screen"),
                      // Image.network(product.imageUrl),
                      // Text(product.title),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(product.description),
                      // )
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text("PRODUCT NOT FOUND"));
            }
          },
        ),
      ),
    );
  }
}
