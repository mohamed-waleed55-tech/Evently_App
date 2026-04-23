import 'package:evently/main_app/evently_app.dart';
import 'package:evently/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
  ChangeNotifierProvider(
     child: const EventlyApp(),
    create: (context)=>ConfigProvider(),
  ));

}