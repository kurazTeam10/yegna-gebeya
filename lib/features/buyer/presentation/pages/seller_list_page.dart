import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// import 'package:yegna_gebeya/features/buyer/data/repositories/buyer_repository_impl.dart';

import 'package:yegna_gebeya/features/buyer/presentation/bloc/seller_list_bloc.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/seller_list_event.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/seller_list_state.dart';

class SellerListPage extends StatelessWidget {
  const SellerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sellers'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search Sellers',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                context.read<SellerListBloc>().add(SearchSellersEvent(query));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<SellerListBloc, SellerListState>(
              builder: (context, state) {
                if (state is SellerListInitial) {
                  return const Center(child: Text('Please wait...'));
                }
                if (state is SellerListLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SellerListLoaded) {
                  if (state.sellers.isEmpty) {
                    return const Center(child: Text('No sellers found.'));
                  }
                  return ListView.builder(
                    itemCount: state.sellers.length,
                    itemBuilder: (context, index) {
                      final seller = state.sellers[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: ListTile(
                          onTap: () {
                            context.go('/sellerProfile/${seller.userId}');
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(seller.imgUrl),
                            onBackgroundImageError: (exception, stackTrace) {},
                          ),
                          title: Text(seller.fullName),
                          subtitle: Text(seller.email),
                        ),
                      );
                    },
                  );
                }
                if (state is SellerListError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
