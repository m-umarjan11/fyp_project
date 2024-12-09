import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:backend_services_repository/backend_service_repositoy.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationImp authentication;
  AuthBloc({required this.authentication}) : super(AuthInitial()) {
    on<Authenticate>((event, emit)async {
      emit(AuthLoading());
      try{
        bool check = await authentication.checkUserAccountOnStartUp();
        print(check);
        if(check){
          
          emit(AuthLoadingSuccess());
        }else{
          emit(AuthError());
        }
      } catch (e){
        emit(AuthError());
      }
    });
  }
}
