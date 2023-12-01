import 'package:flutter/material.dart';
import 'package:flutter_test_project/Providers/ChatProvider/chat_provider.dart';
import 'package:flutter_test_project/Providers/GptProvider/gpt_provider.dart';
import 'package:flutter_test_project/Utils/Colors/colors.dart';
import 'package:flutter_test_project/common/widgets/custom_appbar.dart/custom_appbar.dart';
import 'package:flutter_test_project/common/widgets/custom_textform/custom_textform.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

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
    final gptProvider = Provider.of<GptProvider>(context);

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
            child: ListView(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomTextFormField(
                hintText: 'Ask a Question ',
                hintTextColor: Colors.white,
                controller: message,
                suffixIcon: IconButton(
                    onPressed: () async {
                      final messages = message.text;
                      if (messages.isNotEmpty) {
                        await gptProvider.sendMessage(messages);
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
        ],
      ),
    );
  }
}
