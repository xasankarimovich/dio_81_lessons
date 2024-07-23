import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_81/blocs/product_event.dart';

import '../../blocs/product_bloc.dart';
import '../../data/models/product.dart';

class ManageProductScreen extends StatefulWidget {
  final bool isEdit;
  final Product? product;

  const ManageProductScreen({super.key, required this.isEdit, this.product});

  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title = '';
  double _price = 0.0;
  String _image = "";

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.product != null) {
      _title = widget.product!.title;
      _price = widget.product!.price.toDouble();
      _image = widget.product!.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEdit ? 'Edit Product' : 'Add Product'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _title,
              decoration: const InputDecoration(labelText: 'Title'),
              onSaved: (value) => _title = value!,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _price.toString(),
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _price = double.parse(value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a price';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _image,
              decoration: const InputDecoration(
                  labelText: 'Images (comma-separated URLs)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter image URL';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              !widget.isEdit
                  ? context.read<ProductBloc>().add(
                        AddProductEvent(
                          product: Product(
                              id: DateTime.now().millisecondsSinceEpoch,
                              title: _title,
                              price: _price,
                              image: _image),
                        ),
                      )
                  : context.read<ProductBloc>().add(
                        EditProductEvent(
                          product: Product(
                            id: DateTime.now().millisecondsSinceEpoch,
                            title: _title,
                            price: _price,
                            image: _image,
                          ),
                        ),
                      );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
