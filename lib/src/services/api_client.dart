import 'dart:convert';

import 'package:get/get.dart';

import '../utils/local_storage/local_storage.dart';



class ApiClient extends GetConnect implements GetxService{
  late String sessionID;
  late String csrfToken;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late BlottLocalStorage localStorage = BlottLocalStorage();

  ApiClient({required this.appBaseUrl, required this.localStorage}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'HttpHeaders.contentTypeHeader': 'application/json'
    };
  }

  void updateHeader(){
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'HttpHeaders.contentTypeHeader': 'application/json'
    };
  }

  // Request for getting data from api server
  Future<Response> getData(String uri, {Map<String, String>? headers}) async{
    try{
      Response response = await get(uri, headers: headers??_mainHeaders);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}