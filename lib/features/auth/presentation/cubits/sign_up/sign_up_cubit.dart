import 'package:bloc/bloc.dart';
import 'package:yegna_gebeya/features/auth/domain/repositories/auth_repository.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_up/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpCubit(this.authRepository) : super(SignUpInitial());

  Future<void> signUp(
    String email,
    String password,
    String role,
    String fullName,
  ) async {
    try {
      emit(SignUpLoading());
      await authRepository.signUpWithEmailAndPassword(
        email,
        password,
        role,
        fullName,
      );
      emit(SignUpSuccess()); // only indicate success
    } catch (e) {
      emit(SignUpFailure(errorMessage: e.toString()));
    }
  }
}

