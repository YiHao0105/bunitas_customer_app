/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';

import '../backend/parse/display_parse.dart';


class DisplayController extends GetxController implements GetxService {

  final DisplayParser parser;
  DisplayController({required this.parser});
  String url = "";

  @override
  void onInit() {
    super.onInit();
     url = Get.arguments[1];
     print("HelloImageUrl==>    "+url);
  }
}
