import 'package:evently/authentication/forget_password/forget_password.dart';
import 'package:evently/authentication/signIn/signIn.dart';
import 'package:flutter/cupertino.dart';

import '../../../authentication/signUp/sign_up.dart';

class RoutesManager{
  static const String signIn="/signIn";
  static const String signUp="/signUn";
  static const String forgetPassword="/forgetPassword";
  static Route? router (RouteSettings settings){
    switch(settings.name){
      case signIn:
        return CupertinoPageRoute(builder: (context)=>SignIn());
      case signUp:
        return CupertinoPageRoute(builder: (context)=>SignUp());
      case forgetPassword:
        return CupertinoPageRoute(builder: (context)=>ForgetPassword());
    }
  }


}