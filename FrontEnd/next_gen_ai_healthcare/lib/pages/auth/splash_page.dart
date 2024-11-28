import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_gen_ai_healthcare/blocs/auth_bloc/auth_bloc.dart';
import 'package:next_gen_ai_healthcare/pages/auth/welcome_page.dart';
import 'package:next_gen_ai_healthcare/pages/home/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      BlocBuilder<AuthBloc, AuthState>(builder: (context, state){
        switch(state) {
          case AuthLoading():
            return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
          case AuthLoadingSuccess():
            return const HomePage();
          case AuthError():
            return const WelcomePage();
          default:
            return const WelcomePage();
        }
      });
  }
}