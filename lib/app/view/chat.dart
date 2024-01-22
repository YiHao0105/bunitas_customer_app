/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_user/app/controller/chat_controller.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:salon_user/app/view/video_player.dart';

import '../env.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              value.name,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? const Center(
                  child: CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ))
              : RefreshIndicator(

                onRefresh: () async {
                  await value.getChatRooms();
                },
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: value.scrollController,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(value.chatList.length, (index) {
                          return value.chatList[index].senderId.toString() !=
                                  value.uid.toString()
                              ? Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  width: MediaQuery.of(context).size.width - 120,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            value.chatList[index].messageType == 0
                                                ? Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15,
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                        color: ThemeProvider
                                                            .greyColor.shade300,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(30),
                                                                topRight: Radius
                                                                    .circular(30),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            30),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        30))),
                                                    child: Text(
                                                      value
                                                          .chatList[index].message
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  )
                                                : value.chatList[index].messageType == 1
                                                    ? InkWell(
                                                        onTap: () {
                                                          value.onDisplay(value.chatList[index].message);
                                                        },
                                                        child: Container(
                                                          margin: const EdgeInsets
                                                              .only(right: 10),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 5,
                                                                  horizontal: 5),
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: ThemeProvider
                                                                      .greyColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            5),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            5),
                                                                    bottomLeft: Radius
                                                                        .circular(
                                                                            5),
                                                                    bottomRight: Radius
                                                                        .circular(
                                                                            5),
                                                                  )),
                                                          child: Image.network(
                                                            "${Environments.apiBaseURL}storage/images/${value.chatList[index].message}",
                                                            height: 150,
                                                            width: 150,
                                                            fit: BoxFit.fitWidth,
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Image.asset(
                                                                  'assets/images/notfound.png',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 150,
                                                                  width: 150);
                                                            },
                                                          ),
                                                        ),
                                                      )
                                                    : Stack(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10),
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        5),
                                                            decoration:
                                                                const BoxDecoration(
                                                                    color: ThemeProvider
                                                                        .greyColor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              5),
                                                                      topRight: Radius
                                                                          .circular(
                                                                              5),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              5),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              5),
                                                                    )),
                                                            child: Image.network(
                                                              "",
                                                              height: 150,
                                                              width: 150,
                                                              fit:
                                                                  BoxFit.fitWidth,
                                                              errorBuilder:
                                                                  (context, error,
                                                                      stackTrace) {
                                                                return Image.asset(
                                                                    'assets/images/notfound.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 150,
                                                                    width: 150);
                                                              },
                                                            ),
                                                          ),
                                                          InkWell(
                                                              onTap: () {
                                                                // Get.toNamed(AppRouter.getPackagesCategoriesRoute(),
                                                                //     arguments: [, savedCategories]);

                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => VideoApp(videourl: "${Environments.apiBaseURL}storage/videos/${value.chatList[index].message}")),
                                                                );
                                                              },
                                                              child: Container(
                                                                  height: 150,
                                                                  width: 150,
                                                                  child: Icon(
                                                                      Icons
                                                                          .play_circle,
                                                                      size: 50)))
                                                        ],
                                                      ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 16),
                                          width:
                                              MediaQuery.of(context).size.width -
                                                  120,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Flexible(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    value.chatList[index]
                                                                .messageType ==
                                                            0
                                                        ? Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10),
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 10,
                                                                    horizontal:
                                                                        15),
                                                            decoration:
                                                                const BoxDecoration(
                                                                    color: ThemeProvider
                                                                        .appColor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              30),
                                                                      topRight: Radius
                                                                          .circular(
                                                                              30),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              30),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              30),
                                                                    )),
                                                            child: Text(
                                                              value
                                                                  .chatList[index]
                                                                  .message
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: ThemeProvider
                                                                      .whiteColor,
                                                                  fontSize: 14),
                                                            ),
                                                          )
                                                        : value.chatList[index].messageType == 1
                                                            ? InkWell(
                                                                onTap: () {
                                                                  value.onDisplay(value.chatList[index].message);
                                                                },
                                                                child: Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              10),
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical: 5,
                                                                      horizontal:
                                                                          5),
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                          color: ThemeProvider
                                                                              .appColor,
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(5),
                                                                            topRight:
                                                                                Radius.circular(5),
                                                                            bottomLeft:
                                                                                Radius.circular(5),
                                                                            bottomRight:
                                                                                Radius.circular(5),
                                                                          )),
                                                                  child: Image
                                                                      .network(
                                                                    "${Environments.apiBaseURL}storage/images/${value.chatList[index].message}",
                                                                    height: 150,
                                                                    width: 150,
                                                                    fit: BoxFit
                                                                        .fitWidth,
                                                                    errorBuilder:
                                                                        (context,
                                                                            error,
                                                                            stackTrace) {
                                                                      return Image.asset(
                                                                          'assets/images/notfound.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              150,
                                                                          width:
                                                                              150);
                                                                    },
                                                                  ),
                                                                ),
                                                              )
                                                            : Stack(
                                                                children: [
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10),
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            5,
                                                                        horizontal:
                                                                            5),
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                            color: ThemeProvider
                                                                                .appColor,
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topLeft:
                                                                                  Radius.circular(5),
                                                                              topRight:
                                                                                  Radius.circular(5),
                                                                              bottomLeft:
                                                                                  Radius.circular(5),
                                                                              bottomRight:
                                                                                  Radius.circular(5),
                                                                            )),
                                                                    child: Image
                                                                        .network(
                                                                      "",
                                                                      height: 150,
                                                                      width: 150,
                                                                      fit: BoxFit
                                                                          .fitWidth,
                                                                      errorBuilder:
                                                                          (context,
                                                                              error,
                                                                              stackTrace) {
                                                                        return Image.asset(
                                                                            'assets/images/notfound.png',
                                                                            fit: BoxFit
                                                                                .cover,
                                                                            height:
                                                                                150,
                                                                            width:
                                                                                150);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                      onTap: () {
                                                                        // Get.toNamed(AppRouter.getPackagesCategoriesRoute(),
                                                                        //     arguments: [, savedCategories]);

                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) =>
                                                                                  VideoApp(videourl: "${Environments.apiBaseURL}storage/videos/${value.chatList[index].message}")),
                                                                        );
                                                                      },
                                                                      child: Container(
                                                                          height:
                                                                              150,
                                                                          width:
                                                                              150,
                                                                          child: Icon(
                                                                              Icons
                                                                                  .play_circle,
                                                                              size:
                                                                                  50)))
                                                                ],
                                                              ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                        }))),
              ),
          bottomNavigationBar: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        color: ThemeProvider.greyColor.shade300,
                      ),
                      child: TextField(
                        controller: value.message,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Message...'.tr),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext context) => CupertinoActionSheet(
                          title: Text('Choose From'.tr),
                          actions: <CupertinoActionSheetAction>[
                            CupertinoActionSheetAction(
                              isDefaultAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                                value.selectFromGallery('camera');
                              },
                              child: Text('Camera'.tr),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.pop(context);
                                value.selectFromGallery('gallery');
                              },
                              child: Text('Gallery'.tr),
                            ),
                            CupertinoActionSheetAction(
                              isDestructiveAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'.tr),
                            )
                          ],
                        ),
                      );
                    },
                    child: Icon(Icons.image, size: 35),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (context) => HomePage()),
                      // );
                      _showPicker(value);
                    },
                    child: Icon(Icons.video_call, size: 35),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      value.sendMessage();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: ThemeProvider.appColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          )),
                      child: const Icon(
                        Icons.near_me,
                        color: ThemeProvider.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showPicker(ChatController value) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Choose From'.tr),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              value.getVideo(ImageSource.camera, context);
              Navigator.of(context).pop();
            },
            child: Text('Camera'.tr),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              value.getVideo(ImageSource.gallery, context);
              Navigator.of(context).pop();
            },
            child: Text('Gallery'.tr),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'.tr),
          )
        ],
      ),
    );
  }
}
