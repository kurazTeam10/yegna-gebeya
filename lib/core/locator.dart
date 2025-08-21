import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:yegna_gebeya/features/auth/data/repositories/auth_repository.dart';
import 'package:yegna_gebeya/features/auth/domain/repositories/auth_repository.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/cubit/product_upload_cubit.dart';
import 'package:yegna_gebeya/shared/data/repositories/product_repository_impl.dart';
import 'package:yegna_gebeya/shared/data/repositories/user_repository_iml.dart';
import 'package:yegna_gebeya/shared/domain/repositories/product_repository.dart';
import 'package:yegna_gebeya/shared/domain/repositories/user_repository.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      firestore: getIt<FirebaseFirestore>(),
      dio: getIt<Dio>(),
    ),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryIml(firestore: getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      firebaseAuth: getIt<FirebaseAuth>(),
      repository: getIt<UserRepository>(),
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
    () => ProductUploadCubit(repository: getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
}
