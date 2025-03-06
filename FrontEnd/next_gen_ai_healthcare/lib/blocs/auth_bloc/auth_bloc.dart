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
          emit(AuthLoadingSuccess(user: User(userId: check['id'], userName: check['name'], email: check['email'], picture: check['picture'], password: check['token'])));
        }else{
        debugPrint("here");
          emit(AuthError());
        }
      } catch (e){
        emit(AuthError());
      }
    });

    on<AuthLogout>((event, emit){
      authentication.logout();
      add(Authenticate());
    });

    on<GoogleAuthRequired>((event, emit)async {
      try{

        if(await GoogleSignInAuth.isUserLoggedInWithGoogle()){
          final account =  await GoogleSignInAuth.logOut();
        }else{
          final account =  await GoogleSignInAuth.login();
        print("$account");
      final user = User(userId: account!.id, userName: account.displayName??"", email: account.email, picture: account.photoUrl??"");
      final googleAuntentication = await account.authentication;
      print("${googleAuntentication.idToken}");
      await authentication.loginWithGoogle(user:user, idToken: googleAuntentication.idToken);       
      emit(AuthLoadingSuccess(user: user));  
        }
      }      catch (e){
        print(e);
        emit(GoogleAuthFailed());
      }
    });
  }
}
