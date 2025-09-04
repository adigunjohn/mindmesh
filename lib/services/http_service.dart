import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mindmesh/services/exception_handler.dart';

class HttpService {

  Future<dynamic> fetch(String url) async {
    try{
      http.Response response = await http.get(Uri.parse(url),).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception("Connection timeout, poor internet");
      });
      log('${response.statusCode}');
      ExceptionHandler.checkStatusCode(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 204 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 203) {
        log(response.body);
        final fetchedData = jsonDecode(response.body);
        return fetchedData;
      }
      else {
        log('${response.statusCode}');
        log('failed to get/fetch result from the endpoint');
        log(response.body);
        return null;
      }
    }
    catch(e){
      log('$e');
    }
  }


}

///flutter build apk --split-per-abi