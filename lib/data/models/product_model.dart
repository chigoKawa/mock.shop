import 'package:go_router_demo/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
      {required super.id,
      required super.title,
      required super.handle,
      required super.description,
      required super.price,
      required super.imageUrl});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final firstVariant = json['variants']['edges'][0]['node'];
    print(firstVariant);
    return ProductModel(
        id: json['id'],
        title: json['title'],
        handle: json['handle'],
        description: json['description'],
        imageUrl: json['featuredImage']?['url'] ?? '',
        price: double.parse(firstVariant['price']['amount']));
  }
}
