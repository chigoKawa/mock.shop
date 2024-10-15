import "package:go_router_demo/domain/entities/product.dart";

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProduct(String gid);
}
