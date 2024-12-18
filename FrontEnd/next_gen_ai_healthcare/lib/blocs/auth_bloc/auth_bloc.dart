import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:backend_services_repository/backend_service_repositoy.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationImp authentication;
  AuthBloc({required this.authentication}) : super(AuthInitial()) {
    on<Authenticate>((event, emit)async {
      emit(AuthLoading());
      try{
        Map<String, dynamic> check = await authentication.checkUserAccountOnStartUp();
        debugPrint(check.toString());
        if(check.isNotEmpty){ 
          emit(AuthLoadingSuccess(user: User(userId: check['id'], userName: check['name'], email: check['email'], picture: check['picture'])));
        }else{
          emit(AuthError());
        }
      } catch (e){
        emit(AuthError());
      }
    });
  }
}
