import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_gen_ai_healthcare/blocs/theme_bloc/theme_bloc.dart';
import 'package:next_gen_ai_healthcare/pages/auth/splash_page.dart';
import 'package:next_gen_ai_healthcare/widgets/item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              itemCount: 40,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.85,
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                return ItemWidget();
              }),
        ),
      ),
    );
  }
}
