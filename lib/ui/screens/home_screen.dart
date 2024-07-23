import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_81/blocs/product_bloc.dart';
import 'package:lesson_81/blocs/product_event.dart';
import '../../blocs/product_state.dart';
import 'add_edit_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Screen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: context.read<ProductBloc>()..add(GetProductsEvent()),
        builder: (context, state) {
          if (state is InitialProductState || state is LoadingProductState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorProductState) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is LoadedProductState) {
            final products = state.products;

            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                // mainAxisExtent: 230,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            product.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                "https://cyrekdigital.com/static/9f3272e9bab7adf862a262a7df95d478/bf621/Pricing-error-miniatura-en.png",
                                fit: BoxFit.cover,
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('\$${product.price}'),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ManageProductScreen(
                                      isEdit: true,
                                      product: product,
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<ProductBloc>().add(
                                    DeleteProductEvent(id: product.id.toString()));
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text("No products available"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const ManageProductScreen(isEdit: false);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
