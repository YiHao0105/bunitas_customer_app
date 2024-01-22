/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
// import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/models/address_model.dart';
import 'package:salon_user/app/backend/parse/new_address_parse.dart';
import 'package:salon_user/app/controller/address_controller.dart';
import 'package:salon_user/app/controller/address_list_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:salon_user/app/util/toast.dart';
import '../helper/uuid_generator.dart';
import 'package:salon_user/app/backend/models/google_places_model.dart';


class NewAddressController extends GetxController implements GetxService {
  final NewAddressParser parser;

  int title = 0;
  final Set<Marker> markers = {};

  final addressTextEditor = TextEditingController();
  final houseTextEditor = TextEditingController();
  final landmarkTextEditor = TextEditingController();
  final pincodeTextEditor = TextEditingController();
  final searchbarText = TextEditingController();

  int addressId = 0;
  double lat = 0.0;
  double lng = 0.0;
  String action = 'new';
  bool isConfirmed = false;

  String dropdownvalue = 'Home';

  var items = [
    'Home',
    'Work',
    'Other'
  ];

  List<GooglePlacesModel> _getList = <GooglePlacesModel>[];
  List<GooglePlacesModel> get getList => _getList;

  AddressModel _addressInfo = AddressModel();
  AddressModel get addressInfo => _addressInfo;
  bool apiCalled = false;
  double myLat = 51.509865;
  double myLng = -0.118092;

  NewAddressController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    var pinPosition = LatLng(myLat, myLng);
    markers.add(Marker(
      markerId: const MarkerId('sourcePin'),
      position: pinPosition, // updated position
    ));

    if (Get.arguments[0] == 'update') {
      action = 'update';
      addressId = Get.arguments[1] as int;
      debugPrint('address id --> $addressId');
      getAddressById();
    } else {
      apiCalled = true;
    }
  }

  void onSearchChanged(String value) {
    debugPrint(value);
    if (value.isNotEmpty) {
      getPlacesList(value);
    }
  }

  Future<void> getPlacesList(String value) async {
    String googleURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    var sessionToken = Uuid().generateV4();
    var googleKey = Environments.googleMapsKey;
    String request =
        '$googleURL?input=$value&key=$googleKey&sessiontoken=$sessionToken&types=locality';

    '$googleURL?input=$value&key=$Environments.googleMapsKey&sessiontoken=$sessionToken';
    Response response = await parser.getPlacesList(request);

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['predictions'];
      _getList = [];
      body.forEach((data) {
        GooglePlacesModel datas = GooglePlacesModel.fromJson(data);
        _getList.add(datas);
      });
      isConfirmed = false;
      update();
      debugPrint(_getList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void onFilter(int choice) {
    title = choice;
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  Future<void> getNewLatLngFromAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    debugPrint(locations.toString());
    if (locations.isNotEmpty) {
      _getList = [];
      searchbarText.text = address;
      myLat = locations[0].latitude;
      myLng = locations[0].longitude;
      isConfirmed = true;
      var pinPosition = LatLng(myLat, myLng);
      markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      markers.add(Marker(
        markerId: const MarkerId('sourcePin'),
        position: pinPosition, // updated position
      ));
      update();
    }
  }

  void getLatLngFromAddress() async {
    if (addressTextEditor.text == '' ||
        addressTextEditor.text.isEmpty ||
        houseTextEditor.text == '' ||
        houseTextEditor.text.isEmpty ||
        landmarkTextEditor.text == '' ||
        landmarkTextEditor.text.isEmpty ||
        pincodeTextEditor.text == '' ||
        pincodeTextEditor.text.isEmpty) {
      showToast('All fields are required'.tr);
      return;
    }
    if(searchbarText.text.isEmpty || searchbarText.text == ''){
      showToast("could not determine your location");
      return ;
    }

    print("Hello I am here =====>");


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
      barrierDismissible: false,
    );

    if (searchbarText.text.isNotEmpty) {
      debugPrint('ok');
      if (action == 'new') {
        debugPrint('create');
        lat = myLat;
        lng = myLng;
        saveAddress();
      } else {
        debugPrint('update');
        lat = myLat;
        lng = myLng;
        updateAddress();
      }
    } else {
      showToast("could not determine your location");
      update();
    }




   /* var response = await parser.getLatLngFromAddress(
        'https://maps.googleapis.com/maps/api/geocode/json?address=${addressTextEditor.text} ${houseTextEditor.text} ${landmarkTextEditor.text}${pincodeTextEditor.text}&key=${Environments.googleMapsKey}');
    debugPrint("HelloAddress===>"+response.bodyString.toString());
    Get.back();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

      GoogleAddresModel address = GoogleAddresModel.fromJson(myMap);
      debugPrint(address.toString());
      if (address.results!.isNotEmpty) {
        debugPrint('ok');
        if (action == 'new') {
          debugPrint('create');
          lat = address.results![0].geometry!.location!.lat!;
          lng = address.results![0].geometry!.location!.lng!;
          saveAddress();
        } else {
          debugPrint('update');
          lat = address.results![0].geometry!.location!.lat!;
          lng = address.results![0].geometry!.location!.lng!;
          updateAddress();
        }
      } else {
        showToast("could not determine your location");
        update();
      }
    } else {
      ApiChecker.checkApi(response);
      update();
    }*/
  }

  Future<void> saveAddress() async {
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
      barrierDismissible: false,
    );

    if(dropdownvalue == "Home")
       title = 0;
    else if(dropdownvalue == "Work")
       title = 1;
    else
      title = 2;

    var body = {
      "uid": parser.getUId(),
      "title": title,
      "address": searchbarText.text,
      "house": houseTextEditor.text,
      "landmark": landmarkTextEditor.text,
      "pincode": pincodeTextEditor.text,
      "lat": lat,
      "lng": lng,
      "status": 1
    };

    print("HelloAddress====>"+body.toString());

    var response = await parser.saveAddress(body);
    Get.back();

    if (response.statusCode == 200) {
      Get.find<AddressController>().getSavedAddress();
      Get.find<AddressListController>().getSavedAddress();
      successToast('Successfully Added'.tr);
      // onBack();
      Get.back();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onMapCreated(GoogleMapController controller) {
    markers.add(
      const Marker(
        markerId: MarkerId('Id-1'),
        position: LatLng(51.509865, -0.118092),
      ),
    );
    update();
  }

  Future<void> getAddressById() async {
    var param = {"id": addressId};

    Response response = await parser.getAddressByID(param);
    apiCalled = true;
    if (response.statusCode == 200) {
      _addressInfo = AddressModel();
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      AddressModel datas = AddressModel.fromJson(body);
      _addressInfo = datas;
      addressTextEditor.text = _addressInfo.address.toString();
      houseTextEditor.text = _addressInfo.house.toString();
      landmarkTextEditor.text = _addressInfo.landmark.toString();
      pincodeTextEditor.text = _addressInfo.pincode.toString();
      title = _addressInfo.title as int;
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> updateAddress() async {

    if (addressTextEditor.text == '' ||
        addressTextEditor.text.isEmpty ||
        houseTextEditor.text == '' ||
        houseTextEditor.text.isEmpty ||
        landmarkTextEditor.text == '' ||
        landmarkTextEditor.text.isEmpty ||
        pincodeTextEditor.text == '' ||
        pincodeTextEditor.text.isEmpty) {
      showToast('All fields are required'.tr);
      return;
    }
    if(searchbarText.text.isEmpty || searchbarText.text == ''){
      showToast("could not determine your location");
      return ;
    }

    var body = {
      "title": title,
      "address": searchbarText.text,
      "house": houseTextEditor.text,
      "landmark": landmarkTextEditor.text,
      "pincode": pincodeTextEditor.text,
      "lat": lat,
      "lng": lng,
      "id": addressId
    };

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
      barrierDismissible: false,
    );

    var response = await parser.updateAddress(body);
    Get.back();
    if (response.statusCode == 200) {
      Get.find<AddressController>().getSavedAddress();
      Get.find<AddressListController>().getSavedAddress();
      successToast('Successfully Updated'.tr);
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
