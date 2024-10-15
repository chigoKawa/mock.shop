import 'dart:convert';
import 'package:go_router_demo/data/models/product_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
  Future<ProductModel> fetchProduct(String gid);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> fetchProducts() async {
    final response = await client.get(Uri.parse(
        'https://mock.shop/api?query=%7B%20products(first%3A%2020)%20%7B%20edges%20%7B%20node%20%7B%20id%20title%20handle%20description%20featuredImage%20%7B%20id%20url%20%7D%20variants(first%3A%203)%20%7B%20edges%20%7B%20node%20%7B%20price%20%7B%20amount%20currencyCode%20%7D%20%7D%20%7D%20%7D%20%7D%20%7D%20%7D%7D'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // Traverse to the 'edges' list
      final List<dynamic> edges = data['data']['products']['edges'];
      // final List<dynamic> data = jsonDecode(response.body);

      // Map over the 'node' inside each 'edge' to extract the product data
      return edges.map((edge) {
        final productJson = edge['node'];
        return ProductModel.fromJson(productJson);
      }).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Future<ProductModel> fetchProduct(String gid) async {
    final String query = '''
  {
    productByHandle(handle: "$gid") {
      id
      title
      handle
      description
      featuredImage {
        id
        url
      }
      variants(first: 3) {
        edges {
          cursor
          node {
            id
            title
            image {
              url
            }
            price {
              amount
              currencyCode
            }
          }
        }
      }
    }
  }
  ''';
    // URL encode the query for the API request
    final encodedQuery = Uri.encodeComponent(query);
    final response = await client
        .get(Uri.parse('https://mock.shop/api?query=$encodedQuery'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Check if product data is returned
      if (data['data']['productByHandle'] != null) {
        final productJson = data['data']['productByHandle'];

        print("my handle ${gid}");
        print("I am running ${productJson["title"]}");
        return ProductModel.fromJson(
            productJson); // Return a single product model
      } else {
        throw Exception('Product not found');
      }
    } else {
      throw Exception('Failed to load product: ${response.statusCode}');
    }
    // final response = await client.get(Uri.parse(
    //     'https://mock.shop/api?query=%7B%20product(id%3A%20%22gid%3A%2F%2Fshopify%2FProduct%2F7982905098262%22)%20%7B%20id%20title%20description%20featuredImage%20%7B%20id%20url%20%7D%20%7D%7D'));
  }
}
