import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yegna_gebeya/core/locator.dart';
import 'package:yegna_gebeya/core/router/routes.dart';
import 'dart:io';

import 'package:yegna_gebeya/features/seller/product/presentation/cubits/product_upload/product_upload_cubit.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/cubits/product_upload/product_upload_state.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';

class ProductUploadPage extends StatefulWidget {
  final Product? productToBeEditted;
  const ProductUploadPage({super.key, this.productToBeEditted});

  @override
  State<ProductUploadPage> createState() => _ProductUploadPageState();
}

class _ProductUploadPageState extends State<ProductUploadPage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool imageChanged = false;
  bool productIsNew = false;

  ProductCategory? _selectedCategory;

  final Map<String, ProductCategory> _categoryMap = {
    'Clothes': ProductCategory.clothes,
    'Tech': ProductCategory.technology,
    'Jewelry': ProductCategory.jewellery,
    'Furniture': ProductCategory.furniture,
    'Others': ProductCategory.others,
  };

  @override
  void initState() {
    super.initState();
    final product = widget.productToBeEditted;
    if (product != null) {
      _nameController.text = product.name;
      _descController.text = product.description;
      _priceController.text = product.price.toString();
      _selectedCategory = product.category;
      // Only set _imageFile if the image is a local file path
      if (product.imgUrl!.isNotEmpty && !product.imgUrl!.startsWith('http')) {
        _imageFile = File(product.imgUrl!);
      }
    } else {
      productIsNew = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go(Routes.products);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocListener<ProductUploadCubit, ProductUploadState>(
          listener: (context, state) {
            if (state is ProductUploadFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: width * 0.2),
                  DottedBorder(
                    options: RectDottedBorderOptions(
                      color: _imageFile == null
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.surface,
                      dashPattern: [10, 5],
                      strokeWidth: 2,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: width * 0.8,
                          height: height * 0.2,
                          alignment: Alignment.center,
                          child: _imageFile == null
                              ? widget.productToBeEditted == null
                                    ? SizedBox.shrink()
                                    : Container(
                                        width: width * 0.3,
                                        height: height * 0.18,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: Colors.grey[200],
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.network(
                                          widget.productToBeEditted!.imgUrl!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                              : Container(
                                  width: width * 0.3,
                                  height: height * 0.18,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[200],
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.file(
                                    _imageFile!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Positioned(
                          child: IconButton(
                            onPressed: () async {
                              final pickedFile = await _picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (pickedFile != null) {
                                setState(() {
                                  imageChanged = true;
                                  _imageFile = File(pickedFile.path);
                                });
                              }
                            },
                            icon: Icon(Icons.upload, size: width * 0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  TextFormField(
                    onChanged: (_) {
                      setState(() {});
                    },
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a product name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  TextFormField(
                    onChanged: (_) {},
                    controller: _descController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  TextFormField(
                    onChanged: (_) {},
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a price';
                      }
                      final price = double.tryParse(value);
                      if (price == null || price <= 0) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory == null
                        ? null
                        : _categoryMap.entries
                              .firstWhere((e) => e.value == _selectedCategory)
                              .key,
                    decoration: const InputDecoration(
                      labelText: 'Category',

                      border: OutlineInputBorder(),
                    ),
                    items: _categoryMap.keys
                        .map(
                          (cat) => DropdownMenuItem<String>(
                            value: cat,
                            child: Text(cat),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value == null
                            ? null
                            : _categoryMap[value];
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.1),
                  BlocBuilder<ProductUploadCubit, ProductUploadState>(
                    builder: (context, state) {
                      if (state is ProductUploadLoading) {
                        return SizedBox(
                          height: height * 0.05,
                          width: height * 0.05,
                          child: CircularProgressIndicator(),
                        );
                      }

                      return SizedBox(
                        width: width * 0.6,
                        height: height * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _imageFile == null &&
                                    widget.productToBeEditted == null
                                ? Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withAlpha(1)
                                : Theme.of(context).colorScheme.primary,
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.onPrimary,
                          ),
                          onPressed:
                              _imageFile == null &&
                                  widget.productToBeEditted == null
                              ? () {}
                              : () async {
                                  final sellerId =
                                      getIt<FirebaseAuth>().currentUser!.uid;
                                  Product product = !productIsNew
                                      ? widget.productToBeEditted == null
                                            ? (state as ProductUploadSuccess)
                                                  .product
                                            : widget.productToBeEditted!
                                                  .copyWith(
                                                    name: _nameController.text
                                                        .trim(),
                                                    sellerId: sellerId,
                                                    description: _descController
                                                        .text
                                                        .trim(),
                                                    category:
                                                        _selectedCategory!,
                                                    price: double.parse(
                                                      _priceController.text
                                                          .trim(),
                                                    ),
                                                  )
                                      : Product(
                                          name: _nameController.text.trim(),
                                          sellerId: sellerId,
                                          description: _descController.text
                                              .trim(),
                                          category: _selectedCategory!,
                                          price: double.parse(
                                            _priceController.text.trim(),
                                          ),
                                        );
                                  if (productIsNew) {
                                    product = await context
                                        .read<ProductUploadCubit>()
                                        .uploadProduct(
                                          product: product,
                                          image: _imageFile!,
                                          imageChanged: productIsNew,
                                        );
                                    setState(() {
                                      product = product;
                                      productIsNew = false;
                                    });
                                  } else {
                                    imageChanged
                                        ? context
                                              .read<ProductUploadCubit>()
                                              .updateProductInfo(
                                                oldProductId: product.id!,
                                                product: product,
                                                imageChanged: imageChanged,
                                              )
                                        : context
                                              .read<ProductUploadCubit>()
                                              .updateProductInfo(
                                                oldProductId: product.id!,
                                                product: product,
                                                imageChanged: imageChanged,
                                              );
                                  }
                                },
                          child: widget.productToBeEditted == null
                              ? const Text('Upload')
                              : const Text('Update'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
