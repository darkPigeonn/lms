import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/app/data/models/user.dart';
import 'package:lms/app/data/repository/chat_repository.dart';

import '../../../data/models/chat.dart';

class DiscusionsController extends GetxController {
  final ChatRepository chatRepository;

  DiscusionsController(this.chatRepository);
  //TODO: Implement DiscusionsController

  final ImagePicker _picker = ImagePicker();
  final _messages = Rx<List<ChatItem>>([]);
  final _isLoadingMessages = false.obs;
  final _selectedFile = Rx<XFile?>(null);

  List<ChatItem> get messages => _messages.value;
  bool get isLoadingMessages => _isLoadingMessages.value;
  XFile? get selectedFile => _selectedFile.value;

  UserData? user = Get.arguments;

  TextEditingController messageController = TextEditingController();
  //firebase
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference getCollection() {
    return firebaseFirestore.collection("discusions");
  }

  // Future<Stream<QuerySnapshot<Map<String, dynamic>>>> streamChats2(
  //     String chat_id) async {
  //   CollectionReference chats = firebaseFirestore.collection("discusions");

  //   QuerySnapshot querySnapshot = await chats.get();
  //   return querySnapshot.docs;
  // }

  @override
  Future<void> onInit() async {
    super.onInit();
    await retrieveMessages;
  }

  Future<void> get retrieveMessages async {
    _isLoadingMessages.value = true;
    final values = await chatRepository.messages;
    await Future.delayed(const Duration(seconds: 2));
    _messages.value = values;
    _isLoadingMessages.value = false;
  }

  Future<void> openCamera() async {
    final cameraFile = await _picker.pickImage(source: ImageSource.camera);
    _selectedFile.value = cameraFile;
  }

  Future<void> openGallery() async {
    final galleryFile = await _picker.pickImage(source: ImageSource.gallery);
    _selectedFile.value = galleryFile;
  }

  Future<void> sendMessage(String content, type) async {
    if (content.trim().isNotEmpty) {
      await firebaseFirestore.collection('discusions').add({
        'email': user!.userEmail,
        'name': user!.userName,
        'message': content,
        'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      });
    }
  }

  int get messageLength => _messages.value.length;
}
