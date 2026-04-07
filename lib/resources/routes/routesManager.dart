import 'package:evently/authentication/signIn/signIn.dart';
import 'package:flutter/cupertino.dart';

import '../../authentication/signUp/signUp.dart';

class RoutesManager{
  static const String signIn="/signIn";
  static const String signUn="/signUn";
  static Route? router (RouteSettings settings){
    switch(settings.name){
      case signIn:
        return CupertinoPageRoute(builder: (context)=>SignIn());
      case signUn:
        return CupertinoPageRoute(builder: (context)=>SignUp());
    }
  }


}