import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_81/blocs/product_bloc.dart';
import 'package:lesson_81/data/repositories/product_repository.dart';
import 'package:lesson_81/data/services/dio_product_service.dart';

import 'app.dart';

void main() {
  final dioProductService = DioProductService();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          return ProductRepository(dioProductService: dioProductService);
        }),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ProductBloc(
                productRepsitory: context.read<ProductRepository>(),
              );
            },
          ),
        ],
        child: const MainApp(),
      ),
    ),
  );
}
