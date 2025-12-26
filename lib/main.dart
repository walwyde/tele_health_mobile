import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/symptom_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://niubbceotjbeiohcdxrx.supabase.co',
    anonKey: 'sb_publishable_-HRcOxSZ20_HK7xD2RhKVA_HjWWpPtC',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TeleHealth AI Symptom Checker',
      home: SymptomScreen(),
    );
  }
}
