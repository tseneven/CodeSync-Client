import 'package:code_sync/data/datasourse/registration_data.dart';
import 'package:code_sync/data/dto/user.dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<EmitAuth>((event, emit) async {

      emit(AuthLoading());
      final RegistrationData login = RegistrationData();

      try {
        final result = await login.login(event.user);
        if (result == "Ок") {
          emit(AuthSuccess());
        } else {
          emit(AuthError(result));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
