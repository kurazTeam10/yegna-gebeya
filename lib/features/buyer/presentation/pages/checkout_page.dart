import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/core/locator.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/cart_bloc/cart_bloc.dart';

//TODO: add proper id from an auth cubit/bloc

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
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
    return Scaffold(
      appBar: AppBar(title: Text('Cart'), centerTitle: true),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is CartLoaded) {
            final products = state.products;
            return Column(
              children: [
                ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final quantity = products
                        .where((p) => p.productId == product.productId)
                        .length;

                    return Row(
                      children: [
                        Image(image: NetworkImage(product.productImageUrl)),
                        Column(
                          children: [
                            Text(product.productName),
                            Text('${product.price}'),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () => getIt<CartBloc>().add(
                                AddToCartEvent(id: '1', product: product),
                              ),
                              icon: Icon(Icons.arrow_upward),
                            ),
                            Text(quantity.toString()),
                            IconButton(
                              onPressed: () => getIt<CartBloc>().add(
                                RemoveFromCartEvent(id: '1', product: product),
                              ),
                              icon: Icon(Icons.arrow_downward),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),

                ElevatedButton(
                  onPressed: () {
                    context.read<CartBloc>().add(
                      PurchaseProducts(id: 'AfGvuQs8LDYbPUFKtdl4wkMo2Br2'),
                    );
                  },
                  child: Text('purchase products now'),
                ),
              ],
            );
          }

          return Center(child: Text('Cart is empty'));
        },
      ),
    );
  }
}
