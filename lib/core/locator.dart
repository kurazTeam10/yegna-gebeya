import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:yegna_gebeya/features/auth/data/repositories/auth_repository.dart';
import 'package:yegna_gebeya/features/auth/domain/repositories/auth_repository.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:yegna_gebeya/features/buyer/cart/data/repositories/cart_repository_impl.dart';
import 'package:yegna_gebeya/features/buyer/cart/domain/repositories/cart_repository.dart';
import 'package:yegna_gebeya/features/buyer/data/repositories/buyer_repository_impl.dart';
import 'package:yegna_gebeya/features/buyer/domain/repositories/buyer_repository.dart';
import 'package:yegna_gebeya/features/buyer/cart/presentation/bloc/cart_bloc.dart';
import 'package:yegna_gebeya/features/buyer/order/data/repositories/order_repository_impl.dart';
import 'package:yegna_gebeya/features/buyer/order/domain/repositories/order_repository.dart';
import 'package:yegna_gebeya/features/buyer/order/presentation/bloc/order_bloc.dart';
import 'package:yegna_gebeya/features/buyer/seller_profile/data/repositories/buyer_repository_impl.dart';
import 'package:yegna_gebeya/features/buyer/seller_profile/domain/repositories/buyer_repository.dart';
import 'package:yegna_gebeya/features/buyer/seller_profile/presentation/bloc/sellerList/seller_list_bloc.dart';
import 'package:yegna_gebeya/features/buyer/seller_profile/presentation/bloc/sellerProfile/seller_profile_bloc.dart';
import 'package:yegna_gebeya/features/buyer/home/presentation/cubit/product_cubit.dart';
import 'package:yegna_gebeya/shared/data/repositories/product_repository_impl.dart'; // Add this import
import 'package:yegna_gebeya/shared/domain/repositories/product_repository.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/cubits/product_cubit/product_cubit.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/cubits/product_upload/product_upload_cubit.dart';
import 'package:yegna_gebeya/shared/data/repositories/image_repository_impl.dart';
import 'package:yegna_gebeya/shared/data/repositories/user_repository_impl.dart';
import 'package:yegna_gebeya/shared/domain/repositories/image_repository.dart';
import 'package:yegna_gebeya/shared/domain/repositories/user_repository.dart';
import 'package:yegna_gebeya/shared/order/data/repositories/order_repository_impl.dart';
import 'package:yegna_gebeya/shared/order/domain/repositories/order_repository.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  getIt.registerLazySingleton<ImageRepository>(
    () => ImageRepositoryImpl(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(firestore: getIt<FirebaseFirestore>()),
  );
  // getIt.registerLazySingleton<ProductRepository>(
  //   () => ProductRepositoryImpl(firestore: getIt<FirebaseFirestore>()),
  // );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      firebaseAuth: getIt<FirebaseAuth>(),
      firebaseFirestore: getIt<FirebaseFirestore>(),
      imageRepository: getIt<ImageRepository>(),
    ),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      firebaseAuth: getIt<FirebaseAuth>(),
      repository: getIt<UserRepository>(),
    ),
  );

  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      firestore: getIt<FirebaseFirestore>(),
      productRepository: getIt<ProductRepository>(),
    ),
  );

  getIt.registerFactory<SignUpCubit>(
    () => SignUpCubit(authRepo: getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  getIt.registerLazySingleton<BuyerRepository>(() => BuyerRepositoryImpl(firestore: getIt<FirebaseFirestore>()));
  
  getIt.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(firestore: getIt<FirebaseFirestore>()),);
  getIt.registerFactory<CartBloc>(() => CartBloc(repository: getIt<CartRepository>()));

  getIt.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(firestore: getIt<FirebaseFirestore>()));
  getIt.registerFactory<OrderBloc>(()=>OrderBloc(getIt<OrderRepository>()));

  getIt.registerFactory<SignInCubit>(
    () => SignInCubit(
      authRepo: getIt<AuthRepository>(),
      userRepo: getIt<UserRepository>(),
    ),
  );
  getIt.registerFactory<ProductCubit>(
    () => ProductCubit(productRepository: getIt<ProductRepository>()),
  );

  getIt.registerLazySingleton<BuyerRepository>(
    () => BuyerRepositoryImpl(),
  );

  getIt.registerFactory<SellerListBloc>(
    () => SellerListBloc(buyerRepository: getIt<BuyerRepository>()),
  );

  getIt.registerFactory<SellerProfileBloc>(
    () => SellerProfileBloc(buyerRepository: getIt<BuyerRepository>()),
  );

  getIt.registerFactory<SellerProductCubit>(
      () => SellerProductCubit(repository: getIt<ProductRepository>()));
  getIt.registerFactory<ProductUploadCubit>(() => ProductUploadCubit(
      repository: getIt<ProductRepository>(),
      imageRepository: getIt<ImageRepository>()));
}
