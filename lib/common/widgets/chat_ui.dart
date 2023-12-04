import 'package:flutter/material.dart';
import 'package:flutter_test_project/Utils/Colors/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Providers/ChatProvider/chat_provider.dart';

class ChatUI extends StatelessWidget {
  final String? question;
  final String? answer;
  final String? date;
  const ChatUI({super.key, this.question, this.answer, this.date});

  // @override
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(color: Colors.blueGrey),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Card(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          question!,
                          style: const TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Card(
                  elevation: 10,
                  color: AppColors.myblue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          answer!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      )
                    ],
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd/MM/yy HH:mm').format(DateTime.parse(date!)),

                    // '23/12/23',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      size: 30,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
