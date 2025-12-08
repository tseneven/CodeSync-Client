part of 'auth_bloc.dart';

class AuthEvent {

}

class EmitAuth extends AuthEvent{
  final User user;
  EmitAuth(this.user);
}