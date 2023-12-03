import 'package:flutter/material.dart';
import 'package:flutter_test_project/Utils/Colors/colors.dart';
import 'package:provider/provider.dart';

import '../../Providers/ChatProvider/chat_provider.dart';

class ChatUI extends StatefulWidget {
  const ChatUI({super.key});

  @override
  State<ChatUI> createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<ChatProvider>(context, listen: false).fetchTodayMessages();
  // }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        if (chatProvider.loading) {
          return const CircularProgressIndicator();
        } else if (chatProvider.todayMessages.isEmpty) {
          return const Center(
            child: Text(
              'Start a new chat',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          );
        } else {
          final chat = chatProvider.messages;

          return Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: ListView.builder(
              itemCount: chatProvider.todayMessages.length,
              itemBuilder: (context, index) {
                final chatMessage = chat[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.blueGrey),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
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
                                      chatMessage.question!,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            ),
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
                                      chatMessage.answer!,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "",
                                  // chatMessage.date,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Implement your favorite logic
                                    // chatProvider.markFavorite(chatMessage.id);
                                  },
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
                  ),
                );
              },
            ),
          );
        }
      },
    );
    // return Padding(
    //   padding: const EdgeInsets.only(top: 30.0),
    //   child: ListView(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 10),
    //         child: Container(
    //           decoration: const BoxDecoration(color: Colors.blueGrey),
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(vertical: 10),
    //             child: Column(
    //               children: [
    //                 SizedBox(
    //                   width: MediaQuery.of(context).size.width * 0.8,
    //                   child: Card(
    //                       elevation: 10,
    //                       color: Colors.white,
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(20),
    //                       ),
    //                       child: const Wrap(
    //                         children: [
    //                           Padding(
    //                             padding: EdgeInsets.all(10.0),
    //                             child: Text(
    //                               'What is flutter',
    //                               style: TextStyle(fontSize: 20),
    //                             ),
    //                           )
    //                         ],
    //                       )),
    //                 ),
    //                 const SizedBox(
    //                   height: 10,
    //                 ),
    //                 SizedBox(
    //                   width: MediaQuery.of(context).size.width * 0.8,
    //                   child: Card(
    //                       elevation: 10,
    //                       color: AppColors.myblue,
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(20),
    //                       ),
    //                       child: const Wrap(
    //                         children: [
    //                           Padding(
    //                             padding: EdgeInsets.all(10.0),
    //                             child: Text(
    //                               'flutter is a cross-platform framework',
    //                               style: TextStyle(
    //                                   color: Colors.white, fontSize: 20),
    //                             ),
    //                           )
    //                         ],
    //                       )),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(
    //                       horizontal: 8.0, vertical: 8.0),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       const Text(
    //                         '23/12/23',
    //                         style: TextStyle(
    //                             fontSize: 18,
    //                             color: Colors.white,
    //                             fontWeight: FontWeight.bold),
    //                       ),
    //                       IconButton(
    //                           onPressed: () {},
    //                           icon: const Icon(
    //                             Icons.favorite_border_outlined,
    //                             size: 30,
    //                           ))
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
