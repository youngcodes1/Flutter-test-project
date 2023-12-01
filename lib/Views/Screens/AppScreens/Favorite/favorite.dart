import 'package:flutter/material.dart';
import 'package:flutter_test_project/common/widgets/custom_appbar.dart/custom_appbar.dart';

import '../../../../Utils/Colors/colors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: 'Favorite',
          backgroundColor: AppColors.myblue,
          centerTitle: true,
          automaticallyImplyLeading: false,
          titleTextStyle: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
      body: ListView(),
    );
  }
}
