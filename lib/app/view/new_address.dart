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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salon_user/app/controller/new_address_controller.dart';
import 'package:salon_user/app/util/theme.dart';

class NewAddressScreen extends StatefulWidget {
  const NewAddressScreen({Key? key}) : super(key: key);

  @override
  State<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewAddressController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            elevation: 0,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            titleSpacing: 0,
            centerTitle: true,
            title: Text(
              'Add New Address'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? const Center(
                  child: CircularProgressIndicator(
                    color: ThemeProvider.appColor,
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        value.getList.isEmpty
                            ? SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: GoogleMap(
                            onMapCreated: value.onMapCreated,
                            markers: value.markers,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(value.myLat, value.myLng), zoom: 10),
                          ),
                        )
                            : const SizedBox(),
                        SizedBox(
                          height: value.getList.isEmpty ? 20 : 0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: ThemeProvider.greyColor.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: ThemeProvider.greyColor,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextField(
                                    controller: value.searchbarText,
                                    onChanged: (content) {
                                      value.onSearchChanged(content);
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Search location'.tr),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        value.getList.isNotEmpty
                            ? Container(
                          decoration:
                          const BoxDecoration(color: ThemeProvider.whiteColor),
                          child: Column(
                            children: [
                              for (var item in value.getList)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: InkWell(
                                    onTap: () {

                                      value.getNewLatLngFromAddress(
                                          item.description.toString());
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(Icons.search),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          item.description!.length > 25
                                              ? '${item.description!.substring(0, 25)}...'
                                              : item.description!,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                            : const SizedBox(),

                        SizedBox(
                          height: value.getList.isEmpty ? 20 : 0,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: value.addressTextEditor,
                              decoration: InputDecoration(
                                labelText: '1st Line of address'.tr,
                                labelStyle: const TextStyle(
                                    color: ThemeProvider.appColor,
                                    fontSize: 15),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(
                                    bottom: 8.0, top: 14.0),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ThemeProvider.appColor),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: value.houseTextEditor,
                              decoration: InputDecoration(
                                labelText: 'House / Flat No.'.tr,
                                labelStyle: const TextStyle(
                                    color: ThemeProvider.appColor,
                                    fontSize: 15),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(
                                    bottom: 8.0, top: 14.0),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ThemeProvider.appColor),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: value.landmarkTextEditor,
                              decoration: InputDecoration(
                                labelText: 'City'.tr,
                                labelStyle: const TextStyle(
                                    color: ThemeProvider.appColor,
                                    fontSize: 15),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(
                                    bottom: 8.0, top: 14.0),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ThemeProvider.appColor),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: value.pincodeTextEditor,
                              decoration: InputDecoration(
                                labelText: 'Postcode'.tr,
                                labelStyle: const TextStyle(
                                    color: ThemeProvider.appColor,
                                    fontSize: 15),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(
                                    bottom: 8.0, top: 14.0),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ThemeProvider.appColor),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Save Address'.tr,
                              style: const TextStyle(
                                  fontFamily: 'bold', fontSize: 14),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                           /* GestureDetector(
                              onTap: () {
                                value.onFilter(0);
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.home_outlined,
                                  color: value.title == 0
                                      ? ThemeProvider.appColor
                                      : ThemeProvider.greyColor,
                                ),
                                minLeadingWidth: 0,
                                title: Text('Home'.tr),
                                trailing: Icon(
                                  value.title == 0
                                      ? Icons.radio_button_checked
                                      : Icons.circle_outlined,
                                  color: value.title == 0
                                      ? ThemeProvider.appColor
                                      : ThemeProvider.greyColor,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                value.onFilter(1);
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.work_outline,
                                  color: value.title == 1
                                      ? ThemeProvider.appColor
                                      : ThemeProvider.greyColor,
                                ),
                                minLeadingWidth: 0,
                                title: Text('Work'.tr),
                                trailing: Icon(
                                  value.title == 1
                                      ? Icons.radio_button_checked
                                      : Icons.circle_outlined,
                                  color: value.title == 1
                                      ? ThemeProvider.appColor
                                      : ThemeProvider.greyColor,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                value.onFilter(2);
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.home_work_outlined,
                                  color: value.title == 2
                                      ? ThemeProvider.appColor
                                      : ThemeProvider.greyColor,
                                ),
                                minLeadingWidth: 0,
                                title: Text('Other'.tr),
                                trailing: Icon(
                                  value.title == 2
                                      ? Icons.radio_button_checked
                                      : Icons.circle_outlined,
                                  color: value.title == 2
                                      ? ThemeProvider.appColor
                                      : ThemeProvider.greyColor,
                                ),
                              ),
                            ),*/
                            DropdownButton(
                              isExpanded: true,
                              value: value.dropdownvalue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              // Array list of items
                              items: value.items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  value.dropdownvalue = newValue!;
                                });
                              },
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: value.action == 'new'
              ? Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, bottom: 20, left: 20, right: 20),
                  child: InkWell(
                    onTap: () {
                      value.getLatLngFromAddress();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      decoration: contentButtonStyle(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Submit'.tr,
                            style: const TextStyle(
                                color: ThemeProvider.whiteColor, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, bottom: 20, left: 20, right: 20),
                  child: InkWell(
                    onTap: () {
                      value.updateAddress();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100.0),
                          ),
                          color: ThemeProvider.greenColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Update'.tr,
                            style: const TextStyle(
                                color: ThemeProvider.whiteColor, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

contentButtonStyle() {
  return const BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.circular(100.0),
    ),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color.fromARGB(229, 52, 1, 255),
        Color.fromARGB(228, 111, 75, 255),
      ],
    ),
  );
}
