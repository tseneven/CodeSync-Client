import 'package:code_sync/data/datasourse/registration_data.dart';
import 'package:code_sync/data/dto/user.dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegistrationData registrationData = RegistrationData();

  RegisterBloc() : super(RegisterInitial()) {

    on<EmitRegister>((event, emit) async {
      emit(RegisterLoading());
      try {
        final result = await registrationData.register(event.user);
        if (result == "Ок") {
          emit(RegisterSuccess());
        } else {
          emit(RegisterError(result));
        }
      } catch (e) {
        emit(RegisterError(e.toString()));
      }
    });
  }
}
