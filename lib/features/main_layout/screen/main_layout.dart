import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/features/tabs/favourite/screen/favourite.dart';
import 'package:evently/features/tabs/home/screen/home.dart';
import 'package:evently/features/tabs/map/provider/location_map.dart';
import 'package:evently/features/tabs/map/screen/map.dart';
import 'package:evently/features/tabs/profile/screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  List<Widget> get _tabs => [
        const HomeView(),
        ChangeNotifierProvider(
          create: (_) => LocationMapProvider(),
          child: const EventMapView(),
        ),
        const Favourite(),
        const Profile(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        
        onPressed: () {
          Navigator.pushNamed(context, RoutesManager.createEvent);
        },
        shape: const CircleBorder(),
        elevation: 4,
        
        child: const Icon(Icons.add, size: 28),
      ),
      resizeToAvoidBottomInset: false,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0, 
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(icon: Icons.home_rounded, label: 'Home', index: 0),
            _buildNavItem(icon: Icons.map_rounded, label: 'Map', index: 1),

            const SizedBox(width: 32),

            _buildNavItem(icon: Icons.favorite_rounded, label: 'Favourite', index: 2),
            _buildNavItem(icon: Icons.person_rounded, label: 'Profile', index: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _currentIndex == index;
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? theme.colorScheme.primary : Colors.grey,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? theme.colorScheme.primary : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}