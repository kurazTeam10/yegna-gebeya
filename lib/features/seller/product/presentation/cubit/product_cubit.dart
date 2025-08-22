import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/shared/domain/repositories/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;
  ProductCubit({required this.repository}) : super(const ProductInitial());

  Future<void> getProductsBySellerId(String sellerId) async {
    emit(const ProductLoading());
    try {
      final products = await repository.getProductsBySellerId(sellerId: sellerId);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }
}
