import 'package:flutter/material.dart';

class AiDiagnosisPage extends StatefulWidget {
  const AiDiagnosisPage({super.key});

  @override
  State<AiDiagnosisPage> createState() => _AiDiagnosisPageState();
}

class _AiDiagnosisPageState extends State<AiDiagnosisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("AI Diagnosis"),),);
  }
}