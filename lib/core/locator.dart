import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:yegna_gebeya/features/auth/data/repositories/auth_repository.dart';
import 'package:yegna_gebeya/features/auth/domain/repositories/auth_repository.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:yegna_gebeya/features/seller/order/data/repositories/order_repository_impl.dart';
import 'package:yegna_gebeya/features/seller/order/domain/repositories/order_repository.dart';
import 'package:yegna_gebeya/features/seller/order/presentation/cubit/orders_cubit.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/cubits/product_cubit/product_cubit.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/cubits/product_upload/product_upload_cubit.dart';
import 'package:yegna_gebeya/shared/data/repositories/image_repository_impl.dart';
import 'package:yegna_gebeya/shared/data/repositories/product_repository_impl.dart';
import 'package:yegna_gebeya/shared/data/repositories/user_repository_impl.dart';
import 'package:yegna_gebeya/shared/domain/repositories/image_repository.dart';
import 'package:yegna_gebeya/shared/domain/repositories/product_repository.dart';
import 'package:yegna_gebeya/shared/domain/repositories/user_repository.dart';

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
  getIt.registerFactory<SignInCubit>(
    () => SignInCubit(
      authRepo: getIt<AuthRepository>(),
      userRepo: getIt<UserRepository>(),
    ),
  );

  getIt.registerFactory<ProductUploadCubit>(
    () => ProductUploadCubit(
      repository: getIt<ProductRepository>(),
      imageRepository: getIt<ImageRepository>(),
    ),
  );
  getIt.registerFactory<ProductCubit>(
    () => ProductCubit(repository: getIt<ProductRepository>()),
  );
}
