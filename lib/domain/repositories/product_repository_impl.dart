import 'package:go_router_demo/data/datasources/product_remote_data_source.dart';
import 'package:go_router_demo/domain/entities/product.dart';
import 'package:go_router_demo/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProducts() async {
    final products = await remoteDataSource.fetchProducts();
    return products; // Returning the list of products from API
  }

  @override
  Future<Product> getProduct(String gid) async {
    final product = await remoteDataSource.fetchProduct(gid);
    return product; // Returning the list of products from API
  }
}
