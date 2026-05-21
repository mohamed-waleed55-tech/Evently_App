import 'package:evently/DM/eventDM.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../features/authentication/forget_password/screen/forget_password.dart';
import '../../../features/authentication/signIn/screen/signIn.dart';
import '../../../features/authentication/signUp/sign_up.dart';
import '../../../features/events/create_event/screen/create_event.dart';
import '../../../features/events/details/screen/event_details.dart';
import '../../../features/events/onboarding/onboarding.dart';
import '../../../features/events/update_event/update_event.dart';
import '../../../features/main_layout/screen/main_layout.dart';
import '../../../features/tabs/favourite/screen/favourite.dart';
import '../../../features/tabs/home/screen/home.dart';
import '../../../features/tabs/map/provider/location_map.dart';
import '../../../features/tabs/map/screen/map.dart';
import '../../../features/tabs/map/widgets/pick_location.dart';
import '../../../features/tabs/profile/provider/config_provider.dart';
import '../../../features/tabs/profile/screen/profile.dart';
import '../../../main_app/auth_gate.dart';

abstract final class RoutesManager {
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String forgetPassword = "/forgetPassword";
  static const String mainLayout = "/mainLayout";
  static const String home = "/home";
  static const String map = "/map";
  static const String love = "/favourite";
  static const String profile = "/profile";
  static const String onboarding = "/onboarding";
  static const String createEvent = "/createEvent";
  static const String authGate = "/authGate";
  static const String eventDetails = "/eventDetails";
  static const String updateEvent = "/updateEvent";
  static const String pickLocation = "/pickLocation";

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
      case love:
        return CupertinoPageRoute(builder: (context) => Favourite());
      case profile:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) {
              return ConfigProvider();
            },
            child: Profile(),
          ),
        );
      case createEvent:
        return CupertinoPageRoute(builder: (context) => CreateEventScreen());
      case onboarding:
        return CupertinoPageRoute(builder: (context) => Onboarding());

      case authGate:
        return CupertinoPageRoute(builder: (context) => AuthGate());
      case map:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) {
              return LocationMapProvider();
            },
            child: GoogleMap(),
          ),
        );
      case eventDetails:
        final event = settings.arguments as EventDM;
        return CupertinoPageRoute(
          builder: (context) => EventDetails(event: event),
        );
      case updateEvent:
        final event = settings.arguments as EventDM;
        return CupertinoPageRoute(
          builder: (context) => UpdateEvent(event: event),
        );
      case pickLocation:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) {
              return LocationMapProvider();
            },
            child: PickLocation(),
          ),
        );
      default:
        return null;
    }
  }
}
