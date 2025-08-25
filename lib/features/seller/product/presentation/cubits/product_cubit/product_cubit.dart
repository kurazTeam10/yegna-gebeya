import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';
import 'package:yegna_gebeya/shared/domain/repositories/product_repository.dart';

part 'product_state.dart';

class SellerProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;
  SellerProductCubit({required this.repository}) : super(ProductInitial());

  Future<void> loadSellerProducts({required String sellerId}) async {
    emit(ProductLoading());
    try {
      final products = await repository.getProductsBySellerId(
        sellerId: sellerId,
      );
      emit(ProductLoadingSuccess(products: products));
    } catch (e) {
      emit(ProductLoadingFailure(errorMessage: e.toString()));
    }
  }
}
