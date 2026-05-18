import 'package:flutter/material.dart';

class ConfigProvider extends ChangeNotifier {
  ThemeMode currentTheme= ThemeMode.light;
  String currentLang="en";
  bool get isLight => currentTheme==ThemeMode.light;
  bool get isEnglish => currentLang=="en";
  void changeTheme(ThemeMode newTheme){
    if(currentTheme==newTheme) return;
    currentTheme=newTheme;
    notifyListeners();
  }
  void changeLang(String newLang){
    if(currentLang == newLang) return;
    currentLang=newLang;
    notifyListeners();
  }

}