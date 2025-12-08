part of 'register_bloc.dart';

class RegisterEvent {

}

class EmitRegister extends RegisterEvent{
  final User user;
  EmitRegister(this.user);
}