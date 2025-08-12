import 'package:bloc/bloc.dart';
import 'package:yegna_gebeya/features/auth/domain/repositories/auth_repository.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_in/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepo;
  SignInCubit({required this.authRepo}) : super(const SignInInitial());

  Future<void> signIn(String email, String password) async {
    emit(const SignInLoading());
    try {
      final cred = await authRepo.signInWithEmailAndPassword(email, password);
      emit(SignInSuccess(cred: cred));
    } catch (e) {
      emit(SignInFailure(errorMessage: e.toString()));
    }
  }
}
