import 'package:backend_services_repository/backend_service_repositoy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_gen_ai_healthcare/blocs/auth_bloc/auth_bloc.dart';
import 'package:next_gen_ai_healthcare/blocs/theme_bloc/theme_bloc.dart';
import 'package:next_gen_ai_healthcare/firebase_options.dart';
import 'package:next_gen_ai_healthcare/pages/auth/splash_page.dart';
import 'package:next_gen_ai_healthcare/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp(
    authentication: AuthenticationImp(),
  ));
}

class MyApp extends StatelessWidget {
  final AuthenticationImp authentication;
  const MyApp({super.key, required this.authentication});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => authentication,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(authentication: context.read<AuthenticationImp>()),
          ),
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeState.theme,
              home: const SplashPage(),
            );
          },
        ),
      ),
    );
  }
}
