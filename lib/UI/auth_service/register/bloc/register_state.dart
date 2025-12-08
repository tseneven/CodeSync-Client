part of 'register_bloc.dart';

class RegisterState {

}

class RegisterInitial extends RegisterState{

}

class RegisterLoading extends RegisterState{
  
}


class RegisterSuccess extends RegisterState{

}

class RegisterError extends RegisterState{
  String exception;
  RegisterError(this.exception);
}