import 'package:bloc/bloc.dart';
import 'package:yegna_gebeya/features/auth/domain/repositories/auth_repository.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_up/sign_up_state.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepo;
  SignUpCubit({required this.authRepo}) : super(SignUpInitial());

  Future<void> signUp(
    String displayName,
    String email,
    String password,
    UserRole role,
  ) async {
    emit(SignUpLoading());
    try {
      final cred = await authRepo.signUpWithEmailAndPassword(
        displayName: displayName,
        email: email,
        password: password,
        role: role,
      );
      emit(SignUpSuccess(cred: cred));
    } catch (e) {
      emit(SignUpFailure(errorMessage: e.toString()));
    }
  }
}
