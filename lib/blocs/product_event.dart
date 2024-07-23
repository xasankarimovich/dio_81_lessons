import '../data/models/product.dart';

sealed class ProductEvent {}

final class GetProductsEvent extends ProductEvent {}

final class AddProductEvent extends ProductEvent {
  final Product product;

  AddProductEvent({required this.product});
}

final class EditProductEvent extends ProductEvent {
  final Product product;

  EditProductEvent({required this.product});
}

final class DeleteProductEvent extends ProductEvent {
  final String id;

  DeleteProductEvent({required this.id});
}
