/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/models/chat_list_model.dart';
import 'package:salon_user/app/backend/parse/chat_parse.dart';

import '../helper/router.dart';
import '../util/theme.dart';
import '../util/toast.dart';
import 'display_image_controller.dart';

class ChatController extends GetxController implements GetxService {
  final ChatParser parser;

  String receiverId = '';
  String uid = '';
  String name = '';
  bool apiCalled = false;
  bool yourMessage = false;
  int roomId = 0;
  final message = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<ChatListModel> _chatList = <ChatListModel>[];
  List<ChatListModel> get chatList => _chatList;
  XFile? _selectedImage;
  String sendVideo = '';
  XFile? pickedFile;
  String sendImage = '';
  final picker = ImagePicker();

  ChatController({required this.parser});


  @override
  void onInit() {
    super.onInit();
    receiverId = Get.arguments[0].toString();
    name = Get.arguments[1].toString();
    uid = parser.getUID();
    debugPrint(name);
    getChatRooms();
  }

  Future<void> getChatRooms() async {
    Response response = await parser.getChatRooms(uid, receiverId);

    if (response.statusCode == 200) {
      apiCalled = true;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic data1 = myMap["data"];
      dynamic data2 = myMap["data2"];
      if (data1 != null &&
          data1 != '' &&
          data1['id'] != null &&
          data1['id'] != '') {
        roomId = data1['id'];
      } else if (data2 != null &&
          data2 != '' &&
          data2['id'] != null &&
          data2['id'] != '') {
        roomId = data2['id'];
      }
      getChatList();
    } else if (response.statusCode == 404) {
      createChatRooms();
    } else {
      apiCalled = true;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> createChatRooms() async {
    Response response = await parser.createChatRooms(uid, receiverId);
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      if (body != null && body != '') {
        roomId = body['id'];
        getChatList();
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getChatList() async {
    debugPrint('calling API');
    if (roomId != 0) {
      Response response = await parser.getChatList(roomId);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["data"];
        _chatList = [];
        body.forEach((data) {
          ChatListModel datas = ChatListModel.fromJson(data);
          _chatList.add(datas);
        });
        update();
        scrollDown();
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  Future<void> sendMessage() async {
    String msg = message.text;
    message.clear();
    yourMessage = true;
    update();

    sendNewMessage(0, msg);
  }


  Future<void> sendNewMessage(int type, String msg) async {
    var param = {
      'room_id': roomId,
      'uid': uid,
      'sender_id': uid,
      'message': msg,
      'message_type': type,
      'reported': 0,
      'status': 1,
    };
    Response response = await parser.sendMessage(param);
    yourMessage = false;
    update();
    if (response.statusCode == 200) {
      var notificationParam = {
        "id": receiverId,
        "title": 'New message received',
        "message": message
      };
      await parser.sendNotification(notificationParam);
      getChatList();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


  void selectFromGallery(String kind) async {
    _selectedImage = await ImagePicker().pickImage(
        source: kind == 'gallery' ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 25);

    update();
    if (_selectedImage != null) {
      Get.dialog(
          SimpleDialog(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const CircularProgressIndicator(
                    color: ThemeProvider.appColor,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                      child: Text(
                        "Please wait".tr,
                        style: const TextStyle(fontFamily: 'bold'),
                      )),
                ],
              )
            ],
          ),
          barrierDismissible: false);
      Response response = await parser.uploadImage(_selectedImage as XFile);
      Get.back();
      if (response.statusCode == 200) {
        _selectedImage = null;
        if (response.body['data'] != null && response.body['data'] != '') {
          dynamic body = response.body["data"];
          if (body['image_name'] != null && body['image_name'] != '') {
            sendImage = body['image_name'];
            sendNewMessage(1, sendImage);
            debugPrint(sendImage);
            update();
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }

  Future getVideo(ImageSource img, BuildContext context) async {
    pickedFile = await picker.pickVideo(
        source: img,
        preferredCameraDevice: CameraDevice.front,
        maxDuration: const Duration(minutes: 10));
    XFile? xfilePick = pickedFile;

    var file = File(pickedFile!.path.toString());
    var size = file.lengthSync() / 1000 / 1000;

    print("video_size ==== ${file.toString()}");



    if (size.toInt() < 10) {
      if (xfilePick != null) {
        Get.dialog(
            SimpleDialog(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    const CircularProgressIndicator(
                      color: ThemeProvider.appColor,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                        child: Text(
                          "Please wait".tr,
                          style: const TextStyle(fontFamily: 'bold'),
                        )),
                  ],
                )
              ],
            ),
            barrierDismissible: false);

        Response response = await parser.uploadVideo(xfilePick);

        Get.back();
        if (response.statusCode == 200) {
          pickedFile = null;
          if (response.body['data'] != null && response.body['data'] != '') {
            dynamic body = response.body["data"];
            if (body['video_name'] != null && body['video_name'] != '') {
              sendVideo = body['video_name'];
              sendNewMessage(2, sendVideo);
              update();
            }
          }
        } else {
          ApiChecker.checkApi(response);
        }
      }
    } else {
      showToast('Video size must be less then 10mb');
    }
  }

  String getFileExtension(String fileName) {

    return "." + fileName.split('.').last;
  }

  void onDisplay(String? message) {
    Get.delete<DisplayController>(force: true);
    Get.toNamed(AppRouter.getDisplayRoute(),  arguments: ['url',message]);
  }


  void scrollDown() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    // scrollController.animateTo(0,
    //     duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    update();
  }
}
