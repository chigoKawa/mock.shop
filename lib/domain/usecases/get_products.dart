import "package:go_router_demo/domain/entities/product.dart";
import "package:go_router_demo/domain/repositories/product_repository.dart";

class GetProducts {
  final ProductRepository repository;

  GetProducts({required this.repository});

  Future<List<Product>> execute() {
    return repository.getProducts();
  }
}

class GetProduct {
  final ProductRepository repository;

  GetProduct({required this.repository});

  Future<Product> execute(String gid) {
    return repository.getProduct(gid);
  }
}
