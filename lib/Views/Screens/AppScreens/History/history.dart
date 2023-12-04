import 'package:flutter/material.dart';
import 'package:flutter_test_project/Models/chat_model.dart';
import 'package:flutter_test_project/Providers/ChatProvider/chat_provider.dart';
import 'package:flutter_test_project/common/widgets/chat_ui.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/AuthProvider/auth_provider.dart';
import '../../../../Utils/Colors/colors.dart';
import '../../../../common/widgets/custom_appbar.dart/custom_appbar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.gcolor,
      appBar: const CustomAppBar(
          title: 'History',
          backgroundColor: AppColors.myblue,
          centerTitle: true,
          automaticallyImplyLeading: false,
          titleTextStyle: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ChatModel>>(
                future: chatProvider.getAllHistory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ChatUI(
                            question: snapshot.data![index].question,
                            answer: snapshot.data![index].answer,
                            date: snapshot.data![index].createdDateTime,
                          );
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }
}
