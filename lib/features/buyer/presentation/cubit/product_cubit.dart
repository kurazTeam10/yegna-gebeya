// product_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';
import 'package:yegna_gebeya/shared/domain/repositories/product_repository.dart';


part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  List<String> categories = ['All']; 

  ProductCubit({required this.productRepository}) : super(ProductInitial());

Future<void> fetchCategories() async {
  try {
    emit(ProductLoading());
    final firebaseCategories = await productRepository.getCategories();
    
    categories = ['All', ...firebaseCategories];
    emit(CategoriesLoaded(categories: categories));
  } catch (e) {
    emit(ProductError(message: 'Failed to fetch categories: $e'));
  
  }
}

  Future<void> fetchAllProducts() async {
    emit(ProductLoading());
    try {
      final products = await productRepository.getAllProducts();
      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: 'Failed to fetch products: $e'));
    }
  }

Future<void> fetchProductsByCategory(String category) async {
  emit(ProductLoading());
  try {
    final products = category == 'All' 
        ? await productRepository.getAllProducts()
        : await productRepository.getProductsByCategory(category);
    emit(ProductLoaded(products: products));
  } catch (e) {
    emit(ProductError(message: 'Failed to fetch products by category: $e'));
  }
}
  Future<void> searchProducts(String query) async {
    emit(ProductLoading());
    try {
      final products = await productRepository.searchProducts(query);
      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: 'Failed to search products: $e'));
    }
  }
}