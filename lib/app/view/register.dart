/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:salon_user/app/controller/register_controller.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:get/get.dart';

import '../backend/models/city_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passwordVisible = false;
  String genderValue = 'Male';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (value) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,

          backgroundColor: ThemeProvider.appColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeProvider.whiteColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Create an Account'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Center(
            child: Column(
              children: [

                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: value.emailTextEditor,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'Email Address'.tr,
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: value.passwordTextEditor,
                        textInputAction: TextInputAction.next,
                        obscureText: passwordVisible == true ? false : true,
                        decoration: InputDecoration(
                          labelText: 'Password'.tr,
                          filled: true,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: Icon(
                              passwordVisible == false
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: ThemeProvider.appColor,
                            ),
                          ),
                          fillColor: Colors.white,
                          contentPadding:
                          const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      TextFormField(
                        controller: value.firstNameTextEditor,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'First Name'.tr,
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: value.lastNameTextEditor,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'Last Name'.tr,
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        readOnly: true,
                        controller: value.dateInput,
                        cursorColor: ThemeProvider.appColor,
                        decoration: InputDecoration(
                          labelText: 'dd/MM/yyyy'.tr,
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        onTap: () async {
                          value.selectDate(context);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16),
                    decoration: textFieldDecoration(),
                    child: SizedBox(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        value: value.selectedGender,
                        isExpanded: true,
                        underline: const SizedBox(),
                        onChanged: (String? newValue) {
                          value.saveGender(
                              newValue.toString());
                          value.update();
                        },
                        items: value.genderList
                            .map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: CountryCodePicker(
                          onChanged: (e) =>
                              value.updateCountryCode(e.dialCode.toString()),
                          initialSelection: 'IN',
                          favorite: const ['+91', 'IN'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        )),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: TextFormField(
                          controller: value.mobileTextEditor,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Mobile Number'.tr,
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16),
                          decoration: textFieldDecoration(),
                          child: SizedBox(
                            width: double.infinity,
                            child: DropdownButton<CityModal>(
                              underline: const SizedBox(),
                              isExpanded: true,
                              value: value.selectedCity,
                              items: value.cityList
                                  .map((CityModal value) {
                                return DropdownMenuItem<
                                    CityModal>(
                                  value: value,
                                  child:
                                  Text(value.name.toString()),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                value.onCityChanged(
                                    newValue as CityModal);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: value.referralCodeTextEditor,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'Referral Code'.tr,
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   alignment: Alignment.center,
                //   padding: const EdgeInsets.symmetric(vertical: 5),
                //   child: Center(
                //       child: Text.rich(TextSpan(
                //           text: 'By continuing, you agree to our '.tr,
                //           style: const TextStyle(
                //               fontSize: 10,
                //               fontFamily: 'regular',
                //               color: ThemeProvider.blackColor),
                //           children: <TextSpan>[
                //             TextSpan(
                //                 text: 'Terms of Service'.tr,
                //                 style: const TextStyle(
                //                   fontSize: 10,
                //                   color: ThemeProvider.blackColor,
                //                   fontFamily: 'bold',
                //                   decoration: TextDecoration.underline,
                //                 ),
                //                 recognizer: TapGestureRecognizer()
                //                   ..onTap = () {
                //                     value.onAppPages(
                //                         'Terms & Conditions'.tr, '3');
                //                   }),
                //             TextSpan(
                //                 text: ' and '.tr,
                //                 style: const TextStyle(
                //                     fontSize: 10,
                //                     fontFamily: 'regular',
                //                     color: ThemeProvider.blackColor),
                //                 children: <TextSpan>[
                //                   TextSpan(
                //                       text: 'Privacy Policy'.tr,
                //                       style: const TextStyle(
                //                           fontSize: 10,
                //                           color: ThemeProvider.blackColor,
                //                           fontFamily: 'bold',
                //                           decoration: TextDecoration.underline),
                //                       recognizer: TapGestureRecognizer()
                //                         ..onTap = () {
                //                           value.onAppPages(
                //                               'Privacy Policy'.tr, '2');
                //                         })
                //                 ])
                //           ]))),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      children: [
                        Checkbox(
                          activeColor: ThemeProvider.appColor,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          value: value.termCondition,
                          onChanged: (newValue){
                            //Do Something When Value Changes to True Or False
                            value.termCondition = newValue!;
                            value.update();
                          },
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text.rich(
                              TextSpan(
                                text: 'I’ve read and accepted the '.tr,
                                style: TextStyle(fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Terms & conditions'.tr,
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor: ThemeProvider.blackColor,
                                      )),
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(color: ThemeProvider.redColor)
                                  )
                                  // can add more TextSpans here...
                                ],
                              ),
                            ),
                          ),
                        ),

                      ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      children: [
                        Checkbox(

                          activeColor: ThemeProvider.appColor,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          value: value.ageCondition,
                          onChanged: (newValue){
                            value.ageCondition = newValue!;
                            value.update();
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(
                            TextSpan(
                              text: 'I am over 18 years old'.tr,
                              style: TextStyle(fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' *',
                                    style: TextStyle(color: ThemeProvider.redColor)
                                )
                                // can add more TextSpans here...
                              ],
                            ),
                          ),
                        ),

                      ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      children: [
                        Checkbox(
                          activeColor: ThemeProvider.appColor,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          value: value.personalInformation,
                          onChanged: (newValue){
                            value.personalInformation = newValue!;
                            value.update();
                          },
                        ),

                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text.rich(
                                TextSpan(
                                  text: 'I would like to receive the latest news, promos, and updates from Bunitas. Bunitas does not share or sell your personal information'.tr,
                                  style: TextStyle(fontSize: 14),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' *',
                                        style: TextStyle(color: ThemeProvider.redColor)
                                    )
                                    // can add more TextSpans here...
                                  ],
                                ),
                              ),
                            )
                        ),

                      ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 20.0),
                  child: InkWell(
                    onTap: () {
                      value.createAccount();
                      // value.onRegister();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                          color: ThemeProvider.appColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign Up'.tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: 'bold'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You have already account ?'.tr,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            'Log in'.tr,
                            style: const TextStyle(
                                fontFamily: 'bold',
                                fontSize: 14,
                                color: ThemeProvider.appColor),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    });
  }
}

textFieldDecoration() {
  return BoxDecoration(
    color: ThemeProvider.backgroundColor,
    borderRadius: const BorderRadius.all(
      Radius.circular(8.0),
    ),
    boxShadow: [
      BoxShadow(
          color: ThemeProvider.blackColor.withOpacity(0.2),
          offset: const Offset(0, 1),
          blurRadius: 3),
    ],
  );
}
