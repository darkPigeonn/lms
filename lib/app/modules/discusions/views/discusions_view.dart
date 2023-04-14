import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lms/app/core/values/colors.dart';
import 'package:lms/app/core/widgets/loading.dart';
import 'package:lms/app/data/models/chat.dart';

import '../controllers/discusions_controller.dart';
import 'chat_item_widget.dart';
import 'input_chat_widget.dart';

class DiscusionsView extends GetView<DiscusionsController> {
  const DiscusionsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diskusi Soal'),
        centerTitle: true,
        backgroundColor: AppColors.blueBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                if (controller.isLoadingMessages) {
                  return buildLoading(context);
                }
                // return ListView.builder(
                //   padding: EdgeInsets.symmetric(vertical: 16),
                //   itemBuilder: (context, index) {
                //     final chat = controller.messages[index];
                //     return ChatItemWidget(chat: chat);
                //   },
                //   itemCount: controller.messages.length,
                //   reverse: true,
                // );

                return StreamBuilder(
                  stream: controller
                      .getCollection()
                      .orderBy('timestamp', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      controller.scrollAutomatic();
                    });
                    return ListView.builder(
                        shrinkWrap: true,
                        controller: controller.scrollController,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot chat = snapshot.data!.docs[index];
                          return ChatItemWidget(
                            chat: ChatItem(
                              content: chat['message'],
                              id: 0,
                              name: chat['name'],
                              isSender:
                                  chat['email'] == controller.user!.userEmail
                                      ? true
                                      : false,
                              dateTime: DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(chat['timestamp'])),
                            ),
                          );
                        });
                  },
                );
              },
            ),
          ),
          // Obx(() {
          buildBottom(context),
          // })
        ],
      ),
    );
  }

  Widget buildBottom(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: const Offset(0, 0),
          blurRadius: 7,
          spreadRadius: 0,
          color: Colors.black.withOpacity(0.25),
        ),
      ]),
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding, top: bottomPadding),
        child: InputChatWidget(
          onTapAdd: () => onTapAdd(context),
          onTapCamera: () => onTapCamera(context),
          onTapSend: () => onSend(context),
          controller: controller.messageController,
        ),
      ),
    );
  }

  void onTapCamera(BuildContext context) {
    controller.openCamera();
  }

  void onSend(BuildContext context) {
    var message = controller.messageController.text;
    if (message.isNotEmpty) {
      controller.sendMessage(message, 'text');
    }

    controller.messageController.clear();
  }

  void onTapAdd(BuildContext context) {
    controller.openGallery();
  }
}
