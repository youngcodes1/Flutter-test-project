import 'package:flutter/material.dart';
import 'package:flutter_test_project/Providers/ChatProvider/chat_provider.dart';

import 'package:flutter_test_project/Utils/Colors/colors.dart';

import 'package:flutter_test_project/common/widgets/chat_ui.dart';
import 'package:flutter_test_project/common/widgets/custom_appbar.dart/custom_appbar.dart';
import 'package:flutter_test_project/common/widgets/custom_textform/custom_textform.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import '../../../../Models/chat_model.dart';
import '../../../../Providers/AuthProvider/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController message = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    message.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.gcolor,
      appBar: CustomAppBar(
        backgroundColor: AppColors.myblue,
        title: 'Chatbot',
        leading: const Icon(
          Icons.chat,
          size: 30,
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.confirm,
                  headerBackgroundColor: AppColors.myblue,
                  text: 'Do you want to logout',
                  confirmBtnText: 'Yes',
                  cancelBtnText: 'No',
                  confirmBtnColor: Colors.green,
                  onConfirmBtnTap: () {
                    authProvider.logoutUser();
                  },
                );
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
        titleTextStyle: const TextStyle(
            fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ChatModel>>(
              future: chatProvider.fetchTodayMessages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading messages'));
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Start a new message!',
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
                      return ChatUI(
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomTextFormField(
                hintText: 'Ask a Question ',
                hintTextColor: Colors.white,
                controller: message,
                suffixIcon: Container(
                  color: AppColors.myblue,
                  child: IconButton(
                      onPressed: () async {
                        final mes = message.text;
                        if (mes.isNotEmpty) {
                          await chatProvider.sendMessageAndGetResponse(mes);
                          message.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
