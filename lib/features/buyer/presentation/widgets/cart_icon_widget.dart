import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/core/locator.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/cart_bloc/cart_bloc.dart';

//TODO: add proper id from an auth cubit/bloc

class CartIconWidget extends StatefulWidget {
  const CartIconWidget({super.key});

  @override
  State<CartIconWidget> createState() => _CartIconWidgetState();
}

class _CartIconWidgetState extends State<CartIconWidget> {
  @override
  void initState() {
    super.initState();

    final cartBloc = getIt<CartBloc>();

    if (cartBloc.state is! CartLoaded && cartBloc.state is! CartLoading) {
      cartBloc.add(GetCartEvent(id: '1'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          int itemCount = 0;

          if (state is CartLoaded) {
            itemCount = state.products.length;
          }

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(Icons.shopping_cart, size: 28),
              if (itemCount > 0)
                Positioned(
                  right: -4,
                  top: -4,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$itemCount',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
