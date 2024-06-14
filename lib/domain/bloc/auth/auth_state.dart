import 'package:equatable/equatable.dart';
import 'package:login/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable{
   @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState{}

class AuthLoading extends AuthState{}

class AuthAuthenticated extends AuthState{
  final UserEntity user;
  AuthAuthenticated(this.user);
   @override
  List<Object?> get props => [user];
}

class AuthUnAuthenticated extends AuthState{}

class AuthError extends AuthState{
  final String message;
  AuthError(this.message);
   @override
  List<Object?> get props => [message];
}