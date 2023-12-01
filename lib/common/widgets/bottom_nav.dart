import 'package:flutter/material.dart';
import 'package:flutter_test_project/Utils/Colors/colors.dart';
import 'package:provider/provider.dart';
import '../../Providers/BottomNavProvider/bottomnav_provider.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    final bottomprovider = context.watch<BottomNavProvider>();
    return Scaffold(
        body: bottomprovider.screens[bottomprovider.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.myblue,
            unselectedItemColor: Colors.grey,
            iconSize: 30,
            selectedFontSize: 18,
            unselectedFontSize: 16,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            currentIndex: bottomprovider.currentIndex,
            onTap: (index) {
              bottomprovider.updateIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: "first"),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "second"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "third"),
            ]));
  }
}
