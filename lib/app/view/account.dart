/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_user/app/controller/account_controller.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:salon_user/app/env.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (value) {
      return Scaffold(
        backgroundColor: Colors.white,
        // appBar: value.parser.haveLoggedIn() == true
        //     ? AppBar(
        //         automaticallyImplyLeading: false,
        //         backgroundColor: ThemeProvider.appColor,
        //         elevation: 3,
        //         toolbarHeight: 180,
        //         iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
        //         titleSpacing: 0,
        //         title: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.symmetric(vertical: 20),
        //               child: Column(
        //                 children: [
        //                   Container(
        //                     height: 80,
        //                     width: 80,
        //                     padding: const EdgeInsets.all(3),
        //                     decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(100)),
        //                     child: ClipRRect(
        //                       borderRadius: BorderRadius.circular(100),
        //                       child: FadeInImage(
        //                         height: 80,
        //                         width: 80,
        //                         image: NetworkImage('${Environments.apiBaseURL}storage/images/${value.cover}'),
        //                         placeholder: const AssetImage("assets/images/placeholder.jpeg"),
        //                         imageErrorBuilder: (context, error, stackTrace) {
        //                           return Image.asset('assets/images/notfound.png', fit: BoxFit.fitWidth);
        //                         },
        //                         fit: BoxFit.fitWidth,
        //                       ),
        //                     ),
        //                   ),
        //                   const SizedBox(
        //                     height: 10,
        //                   ),
        //                   Text(
        //                     '${value.firstName} ${value.lastName}',
        //                     style: const TextStyle(fontFamily: 'bold', fontSize: 14, color: ThemeProvider.whiteColor),
        //                   ),
        //                   Text(
        //                     value.email,
        //                     style: const TextStyle(color: ThemeProvider.whiteColor, fontSize: 10, fontFamily: 'regular'),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       )
        //     : AppBar(
        //         automaticallyImplyLeading: false,
        //         backgroundColor: ThemeProvider.appColor,
        //         title: Text(
        //           'Acount'.tr,
        //           style: ThemeProvider.titleStyle,
        //         ),
        //       ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Stack(children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/home_bg_pink.png'), fit: BoxFit.fill),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                'Profile',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 20, fontFamily: 'bold'),
                              ),
                            ),
                            value.parser.haveLoggedIn()==true?Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: ()
                                {
                                  value.onEdit();
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.all(8.0),
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white, shape: BoxShape.rectangle, border: Border.all(width: 1, color: Colors.white)),
                                  child: Image.asset(
                                    'assets/images/icon_edit.png',
                                    fit: BoxFit.fitHeight,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                            ):SizedBox()
                          ],
                        ),
                      ),
                      value.parser.haveLoggedIn() == true?Positioned(
                        left: 0.0,
                        right: 0.0,
                        bottom: 0,
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(100)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: FadeInImage(
                                  height: 80,
                                  width: 80,
                                  image: NetworkImage('${Environments.apiBaseURL}storage/images/${value.cover}'),
                                  placeholder: const AssetImage("assets/images/placeholder.jpeg"),
                                  imageErrorBuilder: (context, error, stackTrace) {
                                    return Image.asset('assets/images/notfound.png', fit: BoxFit.fitWidth);
                                  },
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${value.firstName} ${value.lastName}',
                              style: const TextStyle(fontFamily: 'bold', fontSize: 14, color: ThemeProvider.blackColor),
                            ),
                            Text(
                              value.email,
                              style: const TextStyle(color: ThemeProvider.darkPink, fontSize: 10, fontFamily: 'regular'),
                            ),
                          ],
                        ),
                      ):SizedBox(),
                    ])),

              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ThemeProvider.whiteColor,
                ),
                child: _listItems(value),
              ),
              // Container(
              //   padding: const EdgeInsets.all(10),
              //   margin: const EdgeInsets.symmetric(vertical: 10),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //     color: ThemeProvider.whiteColor,
              //     boxShadow: const [
              //       BoxShadow(
              //         color: ThemeProvider.greyColor,
              //         blurRadius: 5.0,
              //       ),
              //     ],
              //   ),
              //   child: Column(
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           value.onAppPages('FAQs'.tr, '5');
              //         },
              //         child: _buildList(Icons.flag_outlined, 'FAQs'.tr),
              //       ),
              //       // InkWell(
              //       //   onTap: () {
              //       //     value.onAppPages('Help'.tr, '6');
              //       //   },
              //       //   child: _buildList(Icons.help_outline, 'Help'.tr),
              //       // ),
              //       InkWell(
              //         onTap: () {
              //           value.onAppPages('Privacy Policy'.tr, '2');
              //         },
              //         child: _buildList(Icons.security_outlined, 'Privacy Policy'.tr),
              //       ),
              //       InkWell(
              //         onTap: () {
              //           value.onAppPages('Terms & Conditions'.tr, '3');
              //         },
              //         child: _buildList(Icons.privacy_tip_outlined, 'Terms & Conditions'.tr),
              //       ),
              //       // InkWell(
              //       //   onTap: () {
              //       //     value.onAppPages('About us'.tr, '1');
              //       //   },
              //       //   child: _buildList(Icons.info_outline, 'About'.tr),
              //       // ),
              //       value.parser.haveLoggedIn() == true
              //           ? InkWell(
              //               onTap: () {
              //                 value.logout();
              //               },
              //               child: _buildList(Icons.logout, 'Logout'.tr),
              //             )
              //           : const SizedBox()
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildList(icn, txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ThemeProvider.appColor,
            child: Icon(
              icn,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '$txt',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _account_data(String iconPath, String text, AccountController value) {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 10),
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1.0,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0, top: 10, bottom: 5),
            child: Image.asset(
              iconPath,
              fit: BoxFit.fill,
              height: 50,
              width: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listItems(AccountController value) {
    return GridView.count(
      childAspectRatio: (1 / .6),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      crossAxisCount: 2,
      children: [
        if (value.parser.haveLoggedIn() == false) InkWell(
            onTap: ()=>value.onLogin(),
            child: _account_data('assets/images/icon_address.png', 'Login / Registration'.tr, value)),
        if (value.parser.haveLoggedIn() == true) InkWell(onTap: () => value.onProductOrder(), child: _account_data('assets/images/icon_address.png', 'Product Order'.tr, value)),
        if (value.parser.haveLoggedIn() == true) InkWell(onTap: () => value.onWallet(), child: _account_data('assets/images/icon_wallet.png', 'Wallet'.tr, value)),
        if (value.parser.haveLoggedIn() == true) InkWell(onTap: () => value.onAddress(), child: _account_data('assets/images/icon_address.png', 'Your Address'.tr, value)),
        if (value.parser.haveLoggedIn() == true) InkWell(onTap: () => value.onReferAndEarn(), child: _account_data('assets/images/icon_refer.png', 'Refer & Earn'.tr, value)),
        if (value.parser.haveLoggedIn() == true) InkWell(onTap: () => value.onChangePassword(), child: _account_data('assets/images/icon_changepassword.png', 'Change Password'.tr, value)),
        InkWell(onTap: () => value.onLanguages(), child: _account_data('assets/images/icon_language.png', 'Languages'.tr, value)),
        InkWell(onTap: () => value.onContactUs(), child: _account_data('assets/images/icon_contact.png', 'Contact Us'.tr, value)),
        InkWell(onTap: () => value.onAppPages('FAQs'.tr, '5'), child: _account_data('assets/images/icon_faq.png', 'FAQs'.tr, value)),
        InkWell(onTap: () => value.onAppPages('Privacy Policy'.tr, '2'), child: _account_data('assets/images/icon_language.png', 'Privacy Policy'.tr, value)),
        InkWell(onTap: () => value.onAppPages('Terms & Conditions'.tr, '3'), child: _account_data('assets/images/icon_language.png', 'Terms & Conditions'.tr, value)),
        if (value.parser.haveLoggedIn() == true) InkWell(onTap: () => value.logout(), child: _account_data('assets/images/icon_language.png', 'Logout'.tr, value)),
      ],
    );
  }
}
