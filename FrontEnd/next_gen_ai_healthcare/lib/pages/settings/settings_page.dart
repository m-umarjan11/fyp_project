import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_gen_ai_healthcare/blocs/auth_bloc/auth_bloc.dart';
import 'package:next_gen_ai_healthcare/blocs/theme_bloc/theme_bloc.dart';
import 'package:next_gen_ai_healthcare/pages/auth/splash_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              context.read<AuthBloc>().authentication.logout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const SplashPage()));
            },
            leading: const Icon(Icons.color_lens),
            title: const Text("Change Theme"),
            trailing: Switch(
                value: context.read<ThemeBloc>().isDark,
                onChanged: (v) {
                  v
                      ? context.read<ThemeBloc>().add(ThemeToggleDarkEvent())
                      : context.read<ThemeBloc>().add(ThemeToggleLightEvent());
                }),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text("LogOut"),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(AuthLogout());
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SplashPage()));
                                Navigator.pop(context);
                              },
                              child: const Text("LogOut"))
                        ],
                      ));
            },
            leading: const Icon(Icons.logout),
            title: const Text("Log out"),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
          )
        ],
      ),
    );
  }
}
