import 'package:bloc/bloc.dart';
import 'package:yegna_gebeya/features/auth/domain/repositories/auth_repository.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_in/sign_in_state.dart';
import 'package:yegna_gebeya/shared/domain/repositories/user_repository.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepo;
  final UserRepository userRepo;
  SignInCubit({required this.authRepo, required this.userRepo})
    : super(const SignInInitial());

  Future<void> signIn(String email, String password) async {
    emit(const SignInLoading());
    try {
      final cred = await authRepo.signInWithEmailAndPassword(email, password);
      // Assuming cred.user contains the user id
      final userId = cred.user!.uid;
      final role = await userRepo.getUserRole(userId);
      emit(SignInSuccess(cred: cred, role: role));
    } catch (e) {
      emit(SignInFailure(errorMessage: e.toString()));
    }
  }
}
