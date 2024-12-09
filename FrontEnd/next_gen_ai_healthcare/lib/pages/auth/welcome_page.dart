import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_gen_ai_healthcare/blocs/auth_bloc/auth_bloc.dart';
import 'package:next_gen_ai_healthcare/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:next_gen_ai_healthcare/blocs/sign_up/sign_up_bloc.dart';
import 'package:next_gen_ai_healthcare/blocs/theme_bloc/theme_bloc.dart';
import 'package:next_gen_ai_healthcare/pages/auth/sign_in_page.dart';
import 'package:next_gen_ai_healthcare/pages/auth/sign_up_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(20, -0.6),
                child: Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.8,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: TabBar(
                          controller: tabController,
                          unselectedLabelColor: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.5),
                          labelColor: Theme.of(context).colorScheme.onSurface,
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                        controller: tabController,
                        children: [
                          BlocProvider<SignInBloc>(
                            create: (context) => SignInBloc(
                                authBloc: context.read<AuthBloc>(),
                                auth: context.read<AuthBloc>().authentication),
                            child: const SignInPage(),
                          ),
                          BlocProvider<SignUpBloc>(
                            create: (context) => SignUpBloc(
                                authBloc: context.read<AuthBloc>(),
                                auth: context.read<AuthBloc>().authentication),
                            child: const SignUpPage(),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 30,
                  right: 10,
                  child: Switch(
                      value: context.read<ThemeBloc>().isDark,
                      onChanged: (v) {
                        v
                            ? context
                                .read<ThemeBloc>()
                                .add(ThemeToggleDarkEvent())
                            : context
                                .read<ThemeBloc>()
                                .add(ThemeToggleLightEvent());
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
