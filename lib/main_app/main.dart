import 'package:evently/main_app/evently_app.dart';
import 'package:evently/features/main_layout/tabs/profile/provider/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import '../features/main_layout/tabs/map/provider/location_map.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConfigProvider()),
        ChangeNotifierProvider(create: (_) => LocationMapProvider()),
      ],
      child: const EventlyApp(),
    ),
  );

}