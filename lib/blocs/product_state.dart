import '../data/models/product.dart';

sealed class ProductState {}

final class InitialProductState extends ProductState {}

final class LoadingProductState extends ProductState {}

final class LoadedProductState extends ProductState {
  List<Product> products = [];

  LoadedProductState({required this.products});
}

final class ErrorProductState extends ProductState {
  String message;

  ErrorProductState({required this.message});
}
