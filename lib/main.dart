import 'package:evently/features/tabs/profile/provider/config_provider.dart';
import 'package:evently/main_app/evently_app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => ConfigProvider(),
      child: const PulseApp(), 
    ),
  );
}
