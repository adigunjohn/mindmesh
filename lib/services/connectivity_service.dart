import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService{
  static Future<bool> hasInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    log('$connectivityResult');
    if (connectivityResult.first == ConnectivityResult.none) {
      log('No Internet Connection');
      return false;
    }
    else{
      log('Internet Connection available');
      return true;
    }
  }

}