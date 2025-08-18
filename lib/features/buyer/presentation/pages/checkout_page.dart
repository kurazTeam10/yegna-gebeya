import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/core/locator.dart';
import 'package:yegna_gebeya/features/buyer/domain/models/product.dart';
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

    final cartBloc = context.read<CartBloc>();

    if (cartBloc.state is CartInitial) {
      cartBloc.add(GetCartEvent(id: 'AfGvuQs8LDYbPUFKtdl4wkMo2Br2'));
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
            final productQuantities = <String, int>{};
            final productIdToProduct = <String, Product>{};

            for (final product in state.products) {
              productQuantities[product.productId!] =
                  (productQuantities[product.productId!] ?? 0) + 1;
              productIdToProduct[product.productId!] = product;              
            }

            final entries = productQuantities.keys.toList();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      final product = productIdToProduct[entry];
                      final quantity = productQuantities[entry];
                  
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: Image.network(
                              product!.productImageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.productName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text('${product.price}'),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => context.read<CartBloc>().add(
                                  AddToCartEvent(
                                    id: 'AfGvuQs8LDYbPUFKtdl4wkMo2Br2',
                                    product: product,
                                  ),
                                ),
                                icon: const Icon(Icons.arrow_upward),
                              ),
                              Text(quantity.toString()),
                              IconButton(
                                onPressed: () => context.read<CartBloc>().add(
                                  RemoveFromCartEvent(
                                    id: 'AfGvuQs8LDYbPUFKtdl4wkMo2Br2',
                                    product: product,
                                  ),
                                ),
                                icon: const Icon(Icons.arrow_downward),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              
              ElevatedButton(onPressed: (){
                context.read<CartBloc>().add(PurchaseProducts(id: 'AfGvuQs8LDYbPUFKtdl4wkMo2Br2'));
              }, child: Text('purchase products now'))
              ],
            );
          }

          return Center(child: Text('Cart is empty'));
        },
      ),
    );
  }
}
