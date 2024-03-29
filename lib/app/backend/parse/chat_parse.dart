/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:image_picker/image_picker.dart';
import 'package:salon_user/app/backend/api/api.dart';
import 'package:salon_user/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:salon_user/app/util/constant.dart';

class ChatParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ChatParser(
      {required this.apiService, required this.sharedPreferencesManager});

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  Future<Response> getChatRooms(var uid, var participants) async {
    return await apiService.postPrivate(
        AppConstants.getChatRooms,
        {'sender_id': uid, 'receiver_id': participants},
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> createChatRooms(var uid, var participants) async {
    return await apiService.postPrivate(
        AppConstants.createChatRooms,
        {'sender_id': uid, 'receiver_id': participants, 'status': 1},
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getChatList(var roomId) async {
    return await apiService.postPrivate(AppConstants.getChatList,
        {'room_id': roomId}, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> sendMessage(var param) async {
    return await apiService.postPrivate(AppConstants.sendMessage, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> sendNotification(var body) async {
    var response = await apiService.postPrivate(AppConstants.sendNotification,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> uploadImage(XFile data) async {
    return await apiService.uploadFiles(AppConstants.uploadImage, [MultipartBody('image', data)]);
  }

  Future<Response> uploadVideo(XFile data) async {
    return await apiService.uploadFiles(AppConstants.uploadVideo, [MultipartBody('video', data)]);
  }
}
