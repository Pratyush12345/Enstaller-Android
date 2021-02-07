import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'api_error.dart';


GetIt getIt = GetIt.instance;

abstract class BaseApi {
  // TODO: Move the endpoint to some settings file?
  static const _ENDPOINT = 'https://enstallapi.enpaas.com/api/';
  final client = http.Client();



  @protected
  Future<dynamic> getRequest(String path, Function(Response) success,var param) async {

    return _processResponse(await client.get(_ENDPOINT+'$path'+param,
        ), success);
  }
  @protected
  Future<dynamic> getRequestWithParam(String path, Function(Response) success,var param) async {
    return _processResponse(await http.get(_ENDPOINT+path+'?'+param,
//        headers: {
//      HttpHeaders.authorizationHeader: 'Token $token',
//      HttpHeaders.contentTypeHeader: 'application/json',
//    }
    ), success);
  }




  @protected
  Future<dynamic> postRequest(String path, Function(Response) success, [Map body]) async {
    print(body);

    return _processResponse(

        await client.post(
            _ENDPOINT+path,

            body: body != null ? body : null,

        ), success
    );
  }


  @protected
  Future<dynamic> postRequestMap(String path, Function(Response) success, [Map body]) async {
    print(body);

    return _processResponse(

        await client.post(
          _ENDPOINT+path,
          headers: {HttpHeaders.CONTENT_TYPE: "application/json"},
          body: body != null ? json.encode(body) : null,

        ), success
    );
  }


  @protected
  Future<dynamic> postRequestList(String path, Function(Response) success, [var body]) async {
    debugPrint(body);

    var response = await http.post('${BaseApi._ENDPOINT}/$path',
        // ignore: deprecated_member_use
        headers: {HttpHeaders.CONTENT_TYPE: "application/json"},
        body: body);

    if (200 >= response.statusCode && response.statusCode < 300) {
      return success(response);
    } else {
      print(response.body);
      return ApiError.fromJson(json.decode(response.body));
    }
//    return _processResponse(
//
//        await client.post(
//         'http://enstallapi.enpaas.com/api/SurveyQuestionAnswer/AddSurveyQuestionAnswerDetail',
//          headers: {HttpHeaders.CONTENT_TYPE: "application/json"},
//          body:  body,
//
//        ), success
//    );
  }

  @protected
  Future<dynamic> putRequest(String path, Function(Response) success, [Map body]) async {
    return _processResponse(
        await client.put(
            '${BaseApi._ENDPOINT}/$path',

            body: body != null ? jsonEncode(body) : null
        ), success
    );
  }

  @protected
  Future<dynamic> deleteRequest(String path, Function(Response) success) async {
    return _processResponse(await client.delete('${BaseApi._ENDPOINT}/$path'), success);
  }

  dynamic _processResponse(Response response, Function(Response) success) {
    if (200 >= response.statusCode && response.statusCode < 300) {
      return success(response);
    } else {
      print(response.body);
      return ApiError.fromJson(json.decode(response.body));
    }
  }

}
