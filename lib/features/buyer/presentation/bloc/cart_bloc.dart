import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yegna_gebeya/features/buyer/data/models/product.dart';
import 'package:yegna_gebeya/features/buyer/domain/repositories/buyer_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final BuyerRepository repository;

  CartBloc({required this.repository}) : super(CartInitial()) {
    on<GetCartEvent>((event, emit) async {
      emit(CartLoading());
      await emit
          .forEach(
            repository.getCartProducts(event.id),
            onData: (data) {
              return CartLoaded(
                products: data.products,
                totalPrice: data.products.isNotEmpty
                    ? data.products
                          .map((e) => e.cost)
                          .toList()
                          .reduce((value, element) => value + element)
                    : 0.0,
              );
            },
            onError:
          (error, stackTrace) => CartError(message: error.toString()),
        
          )
          ;
    });

    on<AddToCartEvent>((event, emit) {
      repository.addToCart(event.id, event.product);
    });

    on<RemoveFromCartEvent>((event, emit) {
      repository.removeFromCart(event.id, event.product);
    });

    on<PurchaseProducts>((event, emit) {
      repository.purchaseProduct(event.id);
    });
  }
}
