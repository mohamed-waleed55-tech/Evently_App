import 'package:evently/authentication/forget_password/forget_password.dart';
import 'package:evently/authentication/signIn/signIn.dart';
import 'package:evently/main_layout/main_layout.dart';
import 'package:evently/main_layout/screens/create_event/create_event.dart';
import 'package:evently/main_layout/screens/onboarding/onboarding.dart';
import 'package:evently/main_layout/tabs/home/home.dart';
import 'package:evently/main_layout/tabs/love/love.dart';
import 'package:evently/main_layout/tabs/profile/profile.dart';
import 'package:flutter/cupertino.dart';

import '../../../authentication/signUp/sign_up.dart';
import '../../../main_app/auth_gate.dart';
import '../../../main_layout/tabs/map/map.dart';

abstract final class RoutesManager {
  static const String signIn = "/signIn";
  static const String signUp = "/signUn";
  static const String forgetPassword = "/forgetPassword";
  static const String mainLayout = "/mainLayout";
  static const String home = "/home";
  static const String map = "/map";
  static const String love = "/love";
  static const String profile = "/profile";
  static const String onboarding = "/onboarding";
  static const String createEvent = "/createEvent";
  static const String authGate = "/authGate";

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return CupertinoPageRoute(builder: (context) => SignIn());
      case signUp:
        return CupertinoPageRoute(builder: (context) => SignUp());
      case forgetPassword:
        return CupertinoPageRoute(builder: (context) => ForgetPassword());
      case mainLayout:
        return CupertinoPageRoute(builder: (context) => MainLayout());
      case home:
        return CupertinoPageRoute(builder: (context) => Home());
      case map:
        return CupertinoPageRoute(builder: (context) => GoogleMap());
      case love:
        return CupertinoPageRoute(builder: (context) => Love());
      case profile:
        return CupertinoPageRoute(builder: (context) => Profile());
      case createEvent:
        return CupertinoPageRoute(builder: (context) => CreateEventScreen());
      case onboarding:
        return CupertinoPageRoute(builder: (context) => Onboarding());

      case authGate:
        return CupertinoPageRoute(builder: (context) => AuthGate());
    }
    return null;
  }
}
