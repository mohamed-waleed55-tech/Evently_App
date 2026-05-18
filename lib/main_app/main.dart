import 'package:evently/main_app/evently_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import '../features/tabs/map/provider/location_map.dart';
import '../features/tabs/profile/provider/config_provider.dart';
import '../firebase_options.dart';
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