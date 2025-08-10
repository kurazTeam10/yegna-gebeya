import 'package:bloc/bloc.dart';
import 'package:yegna_gebeya/features/auth/domain/repositories/auth_repository.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubit/signin/sign_in_state.dart';


class LoginCubit extends Cubit<SignInState>{
  final AuthRepository authRepo;
  LoginCubit({required this.authRepo}):super(const LoginInitial());
  Future<void>login (String email, String password) async{
    emit(LoginLoading()); 
      try{
        final cred= await authRepo.signInWithEmailAndPassword(email, password);
        emit (LoginSuccess(cred:cred));
      } catch(e){
        emit(LoginFailure(errorMessage:e.toString()));
      }
    }
  }
