import 'package:dio/dio.dart';
import 'package:lesson_81/core/network/dio_client.dart';
import 'package:lesson_81/data/models/product.dart';

class DioProductService {
  final dioClient = DioClient();

  Future<List<Product>> getProducts() async {
    try {
      final response = await dioClient.get(url: "/products");

      List<Product> products = [];

      for (var product in response.data) {
        products.add(Product.fromMap(product));
      }
      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<Product> addProduct(Product product) async {
    try {
      final response =
          await dioClient.add(url: '/products', data: product.toMap());

      return Product.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Product> editProduct(Product product) async {
    try {
      final response = await dioClient.update(
          url: "/products/${product.id}", data: product.toMap());

      return Product.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteProduct(String id) async {
    try {
      final response = await dioClient.delete(url: "/products/$id");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
