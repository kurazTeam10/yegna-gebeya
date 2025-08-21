import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yegna_gebeya/core/locator.dart';
import 'dart:io';

import 'package:yegna_gebeya/features/seller/product/presentation/cubit/product_upload_cubit.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/cubit/product_upload_state.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';

class ProductUploadPage extends StatefulWidget {
  const ProductUploadPage({super.key});

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

  // Add category dropdown state
  ProductCategory? _selectedCategory;

  final Map<String, ProductCategory> _categoryMap = {
    'Clothes': ProductCategory.clothes,
    'Tech': ProductCategory.technology,
    'Jewelry': ProductCategory.jewellery,
    'Furniture': ProductCategory.furniture,
    'Others': ProductCategory.others,
  };

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: SingleChildScrollView(
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
                            ? const SizedBox.shrink()
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
                SizedBox(
                  width: width * 0.6,
                  height: height * 0.06,
                  child: BlocBuilder<ProductUploadCubit, ProductUploadState>(
                    builder: (context, state) {
                      if (state is ProductUploadLoading) {
                        return SizedBox(
                          height: height * 0.2,
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onPrimary,
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            final currentUser =
                                getIt<FirebaseAuth>().currentUser;
                            final price =
                                double.tryParse(_priceController.text) ?? 0;
                            final category =
                                _selectedCategory ?? ProductCategory.others;
                            Product product = Product(
                              imgUrl: _imageFile!.path,
                              name: _nameController.text,
                              sellerId: currentUser!.uid,
                              description: _descController.text,
                              category: category,
                              price: price,
                            );
                            // Call your cubit to upload the product here
                            context.read<ProductUploadCubit>().uploadProduct(
                              product,
                            );
                          }
                        },
                        child: const Text('Upload'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
