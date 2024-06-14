import 'package:login/data/repositories/firebase_auth_repository.dart';
import 'package:login/domain/bloc/auth/auth_event.dart';
import 'package:login/domain/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  FirebaseAuthRepository firebaseAuthRepository = FirebaseAuthRepository();
  AuthBloc():super(AuthInitial()){
    this.firebaseAuthRepository = FirebaseAuthRepository();
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);

  }
  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit)async{
    emit(AuthLoading());
    try{
      final userEntity = await this.firebaseAuthRepository.signIn(event.email, event.password);
      emit(AuthAuthenticated(userEntity));
    }catch(e){
      AuthError(e.toString());
    }
  } 
  Future<void> _onSignUp(SignUpEvent event,Emitter<AuthState> emit)async{
    emit(AuthLoading());
    try{
      final userEntity = await this.firebaseAuthRepository.signUp(event.email, event.password, event.displayName);
      emit(AuthAuthenticated(userEntity!));
    }catch(e){
     AuthError(e.toString());
    }
  }
}