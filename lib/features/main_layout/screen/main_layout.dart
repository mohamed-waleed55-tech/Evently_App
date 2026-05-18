import 'package:evently/core/resources/icons/icons_manager.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../tabs/favourite/screen/favourite.dart';
import '../../tabs/home/screen/home.dart';
import '../../tabs/map/screen/map.dart';
import '../../tabs/profile/screen/profile.dart';
import '../cubit/main_layout_cubit.dart';
class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  static const List<Widget> tabs = [Home(), GoogleMap(), Favourite(), Profile()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainLayoutCubit(),
      child: BlocBuilder<MainLayoutCubit, int>(
        builder: (context, currentIndex) {
          final cubit = context.read<MainLayoutCubit>();

          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;

              if (currentIndex != 0) {
                cubit.backToHome();
              } else {
                Navigator.of(context).maybePop();
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              extendBody: true,
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.pushNamed(context, RoutesManager.createEvent),
                child: SvgPicture.asset(IconsManager.add, semanticsLabel: "add"),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomAppBar(
                notchMargin: 8,
                shape: const CircularNotchedRectangle(),
                child: BottomNavigationBar(
                  onTap: (index) => cubit.changeTab(index),
                  currentIndex: currentIndex,
                  items: _getItems(context),
                ),
              ),
              body: tabs[currentIndex],
            ),
          );
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _getItems(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return [
      _buildNavItem(IconsManager.homeOutlined, IconsManager.homeFilled, loc.home),
      _buildNavItem(IconsManager.mapOutlined, IconsManager.mapFilled, loc.map),
      _buildNavItem(IconsManager.loveOutlined, IconsManager.loveFilled, loc.favourite),
      _buildNavItem(IconsManager.profileOutlined, IconsManager.profileFilled, loc.profile),
    ];
  }

  BottomNavigationBarItem _buildNavItem(String icon, String activeIcon, String label) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(icon),
      activeIcon: SvgPicture.asset(activeIcon),
      label: label,
    );
  }
}