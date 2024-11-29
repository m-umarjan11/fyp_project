import 'package:backend_services_repository/backend_service_repositoy.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:next_gen_ai_healthcare/blocs/auth_bloc/auth_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthenticationImp auth;
  AuthBloc authBloc;
  SignUpBloc({required this.auth, required this.authBloc}) : super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async{
      emit(SignUpLoading());
      try {
        Result result =
            await auth.createAnAccount(user: event.user, password:event.password);
            print(result.isSuccess);
        if (result.isSuccess) {
          emit(SignUpSuccess(user: result.value));
          authBloc.add(Authenticate());
        } else {
          emit(SignUpError(error: result.error));
        }
      } catch (e) {
        emit(const SignUpError(error: "An Unexpected error has occurred"));
      }
    });
  }
}
