import 'package:backend_services_repository/backend_service_repositoy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_gen_ai_healthcare/blocs/create_item_bloc/create_item_bloc.dart';
import 'package:next_gen_ai_healthcare/pages/ai_diagnosis_pages/ai_diagnosis_page.dart';
import 'package:next_gen_ai_healthcare/pages/item_pages/add_item.dart';
import 'package:next_gen_ai_healthcare/pages/item_pages/item_page.dart';
import 'package:next_gen_ai_healthcare/widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final darkerPrimaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomCard(
                icon: Icons.medical_information_sharp,
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 172, 201, 6),
                    Color.fromARGB(255, 85, 97, 20)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                heightRatio: .2,
                text: "Diagnose with AI",
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AiDiagnosisPage(),
                    ),
                  );
                },
                widthRatio: 1),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCard(
                    icon: Icons.receipt_long_outlined,
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Color.fromARGB(255, 42, 69, 90)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    heightRatio: .2,
                    text: "Rent Medical Instruments",
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ItemPage()));
                    },
                    widthRatio: .5),
                const SizedBox(
                  width: 5,
                ),
                CustomCard(
                    icon: Icons.add_box_sharp,
                    gradient: const LinearGradient(
                      colors: [
                        Colors.redAccent,
                        Color.fromARGB(255, 148, 35, 27)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    heightRatio: .2,
                    text: "Add Medical Instruments",
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (BlocProvider(
                                    create: (context) => CreateItemBloc(
                                        storeData: StoreDataImp()),
                                    child: const AddItem(),
                                  ))));
                    },
                    widthRatio: .5)
              ],
            )
          ],
        ),
      ),
    );
  }
}
