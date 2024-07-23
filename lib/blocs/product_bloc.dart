import 'package:lesson_81/blocs/product_event.dart';
import 'package:lesson_81/blocs/product_state.dart';
import 'package:lesson_81/data/repositories/product_repository.dart';
import 'package:bloc/bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepsitory})
      : _productRepository = productRepsitory,
        super(InitialProductState()) {
    on<GetProductsEvent>(_onGetProducts);
    on<AddProductEvent>(_onAddProduct);
    on<EditProductEvent>(_onEditProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }
  Future<void> _onGetProducts(GetProductsEvent event, Emitter emit) async {
    emit(InitialProductState());
    try {
      final products = await _productRepository.getProducts();
      emit(LoadedProductState(products: products));
    } catch (e) {
      emit(ErrorProductState(message: e.toString()));
    }
  }
  Future<void> _onAddProduct(AddProductEvent event, emit) async {
    emit(InitialProductState());

    try {
      await _productRepository.addProduct(event.product);

      _onGetProducts(GetProductsEvent(), emit);
    } catch (e) {
      emit(ErrorProductState(message: "Error on ADD:   $e"));
    }
  }

  Future<void> _onEditProduct(EditProductEvent event, emit) async {
    emit(InitialProductState());

    try {
      await _productRepository.updateProduct(event.product);

      _onGetProducts(GetProductsEvent(), emit);
    } catch (e) {
      emit(ErrorProductState(message: "Error on ADD:   $e"));
    }
  }
  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter emit) async {
    emit(InitialProductState());
    try {
      await _productRepository.deleteProduct(event.id);

      _onGetProducts(GetProductsEvent(), emit);
    } catch (e) {
      emit(ErrorProductState(message: "Error on DELETE: $e"));
    }
  }

}
