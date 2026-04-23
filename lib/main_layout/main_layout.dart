import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:evently/core/resources/icons/icons_manager.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/main_layout/tabs/home/home.dart';
import 'package:evently/main_layout/tabs/love/love.dart';
import 'package:evently/main_layout/tabs/map/map.dart';
import 'package:evently/main_layout/tabs/profile/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  List<BottomNavigationBarItem> getItems(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          IconsManager.homeOutlined,
          semanticsLabel: 'home tab',
        ),
        activeIcon: SvgPicture.asset(
          IconsManager.homeFilled,
          semanticsLabel: 'home tab',
        ),
        label: AppLocalizations.of(context)!.home,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          IconsManager.mapOutlined,
          semanticsLabel: 'map tab',
        ),
        activeIcon: SvgPicture.asset(
          IconsManager.mapFilled,
          semanticsLabel: 'map tab',
        ),
        label: AppLocalizations.of(context)!.map,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          IconsManager.loveOutlined,
          semanticsLabel: 'love tab',
        ),
        activeIcon: SvgPicture.asset(
          IconsManager.loveFilled,
          semanticsLabel: 'love tab',
        ),
        label: AppLocalizations.of(context)!.favourite,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          IconsManager.profileOutlined,
          semanticsLabel: 'profile tab',
        ),
        activeIcon: SvgPicture.asset(
          IconsManager.profileFilled,
          semanticsLabel: 'profile tab',
        ),
        label: AppLocalizations.of(context)!.profile,
      ),
    ];
  }

  List<Widget> tabs = const [Home(), GoogleMap(), Love(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesManager.createEvent);
        },
        child: SvgPicture.asset(IconsManager.add, semanticsLabel: "add"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
          items: getItems(context),
        ),
      ),
      body: tabs[currentIndex],
    );
  }
}
