import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:yegna_gebeya/features/auth/data/repositories/auth_repository.dart';
import 'package:yegna_gebeya/features/auth/domain/repositories/auth_repository.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:yegna_gebeya/features/buyer/presentation/cubit/product_cubit.dart';
import 'package:yegna_gebeya/shared/data/repositories/product_repository_impl.dart'; // Add this import
import 'package:yegna_gebeya/shared/domain/repositories/product_repository.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(firebaseAuth: getIt<FirebaseAuth>()),
  );

  // Register ProductRepository
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(firestore: getIt<FirebaseFirestore>()),
  );

  getIt.registerFactory<SignUpCubit>(
    () => SignUpCubit(authRepo: getIt<AuthRepository>()),
  );
  
  getIt.registerFactory<SignInCubit>(
    () => SignInCubit(authRepo: getIt<AuthRepository>()),
  );
  
  getIt.registerFactory<ProductCubit>(
    () => ProductCubit(productRepository: getIt<ProductRepository>()),
  );
}