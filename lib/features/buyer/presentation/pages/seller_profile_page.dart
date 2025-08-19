import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/features/buyer/domain/repositories/buyer_repository.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/seller_profile_bloc.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/seller_profile_event.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/seller_profile_state.dart';

class SellerProfilePage extends StatelessWidget {
  final String sellerId;

  const SellerProfilePage({super.key, required this.sellerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SellerProfileBloc(
        buyerRepository: RepositoryProvider.of<BuyerRepository>(context),
      )..add(FetchSellerProfileEvent(sellerId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Seller Profile'),
        ),
        body: BlocConsumer<SellerProfileBloc, SellerProfileState>(
          listener: (context, state) {
            if (state is SellerProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is SellerProfileLoading ||
                state is SellerProfileInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SellerProfileLoaded) {
              final seller = state.seller;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(seller.imgUrl),
                      onBackgroundImageError: (exception, stackTrace) {},
                    ),
                    const SizedBox(height: 16),
                    Text(
                      seller.fullName,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      seller.email,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    // TODO: Add a list of the seller's products here
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
