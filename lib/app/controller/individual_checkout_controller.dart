/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:salon_user/app/backend/models/service_cart_model.dart';
import 'package:salon_user/app/backend/parse/individual_checkout_parse.dart';
import 'package:salon_user/app/controller/coupon_controller.dart';
import 'package:salon_user/app/controller/individual_list_controller.dart';
import 'package:salon_user/app/controller/individual_slot_controller.dart';
import 'package:salon_user/app/controller/login_controller.dart';
import 'package:salon_user/app/controller/service_cart_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/constant.dart';

class IndividualCheckoutController extends GetxController
    implements GetxService {
  final IndividualCheckoutParser parser;

  bool isChecked = false;

  ServiceCartModel _savedInCart = ServiceCartModel();
  ServiceCartModel get savedInCart => _savedInCart;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;
  IndividualCheckoutController({required this.parser});

  @override
  void onInit() {
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    _savedInCart = Get.find<ServiceCartController>().savedInCart;
    super.onInit();
  }

  void onCoupon() {
    Get.delete<CouponController>(force: true);
    Get.toNamed(AppRouter.getCouponRoutes());
  }

  void onSlot() {
    if (parser.isLogin() == true) {
      Get.delete<IndividualSlotController>(force: true);
      Get.toNamed(AppRouter.getIndividualSlot());
    } else {
      Get.delete<LoginController>(force: true);
      Get.toNamed(AppRouter.getLoginRoute());
    }
  }

  void deleteServiceFromCart(int index) {
    Get.find<ServiceCartController>()
        .removeServiceFromCart(_savedInCart.services![index].id as int);
    _savedInCart = Get.find<ServiceCartController>().savedInCart;
    //Added by Geeks to update ui on listing screen
    Get.find<IndividualListController>().getSalonDetails();
    checkCartItems();
    update();
  }

  void deletePackageFromCart(int index) {
    Get.find<ServiceCartController>()
        .removePackageFromCart(_savedInCart.packages![index].id as int);
    _savedInCart = Get.find<ServiceCartController>().savedInCart;
    update();
  }

  durationValue(String text)  {
    String durationValue = "";
    List<String> words = text.split(".");
    if(words.length == 2){
      if(words[0].toString() == '0'){
        durationValue = "30 min";
      }else{
        if(words[1].toString() == '0'){
          durationValue = words[0].toString()+"h";
        }else{
          durationValue = words[0].toString()+"h "+"30 min";
        }
      }
    }else{
      durationValue = words[0].toString()+"h";
    }
    print("helloString====>"+durationValue);
    return durationValue.toString();
  }


  void checkCartItems() {
    if (Get.find<ServiceCartController>().savedInCart.services!.isEmpty &&
        Get.find<ServiceCartController>().savedInCart.packages!.isEmpty) {
      var context = Get.context as BuildContext;
      Navigator.of(context).pop(true);
    }
  }
}
