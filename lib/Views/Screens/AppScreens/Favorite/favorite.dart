import 'package:flutter/material.dart';
import 'package:flutter_test_project/Models/chat_model.dart';
import 'package:flutter_test_project/Providers/ChatProvider/chat_provider.dart';
import 'package:flutter_test_project/common/widgets/custom_appbar.dart/custom_appbar.dart';
import 'package:flutter_test_project/common/widgets/favorite/favorit_ui.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../../Utils/Colors/colors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.gcolor,
      appBar: const CustomAppBar(
          title: 'Favorites',
          backgroundColor: AppColors.myblue,
          centerTitle: true,
          automaticallyImplyLeading: false,
          titleTextStyle: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ChatModel>>(
              future: chatProvider.getAllFavorites(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading messages'));
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No favorites',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      ChatModel chat = snapshot.data![index];
                      return FavoriteUI(
                        id: chat.id!,
                        question: snapshot.data![index].question,
                        answer: snapshot.data![index].answer,
                        date: snapshot.data![index].createdDateTime,
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Unknown error occurred'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
