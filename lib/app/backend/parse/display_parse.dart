/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/

import '../../helper/shared_pref.dart';
import '../api/api.dart';

class DisplayParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  DisplayParser({required this.sharedPreferencesManager, required this.apiService});
}
