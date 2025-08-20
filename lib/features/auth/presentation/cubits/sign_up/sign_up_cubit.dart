import 'package:bloc/bloc.dart';
import 'package:yegna_gebeya/features/auth/domain/repositories/auth_repository.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_up/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepo;
  SignUpCubit({required this.authRepo}) : super(SignUpInitial());

  Future<void> signUp(String email, String password) async {
    emit(SignUpLoading());
    try {
      final cred = await authRepo.signUpWithEmailAndPassword(email, password);
      emit(SignUpSuccess(cred: cred));
    } catch (e) {
      emit(SignUpFailure(errorMessage: e.toString()));
    }
  }
}
