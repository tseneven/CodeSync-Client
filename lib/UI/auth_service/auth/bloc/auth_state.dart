part of 'auth_bloc.dart';

class AuthState{

}

class AuthInitial extends AuthState{}

class AuthLoading extends AuthState{}

class AuthSuccess extends AuthState{

}

class AuthError extends AuthState{
  String exception;
  AuthError(this.exception);
}