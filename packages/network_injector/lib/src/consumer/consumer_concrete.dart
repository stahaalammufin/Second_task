import 'dart:convert';
import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'package:http/io_client.dart';
import 'package:network_injector/network_injector.dart';
import 'package:network_injector/src/consumer/consumer_abst.dart';
import 'package:network_injector/src/consumer/response_generator.dart';

@immutable
// ignore: must_be_immutable
class NetworkInjector implements ApiCall {
  String _baseUrl;
  http.Client _httpClient;
  static final NetworkInjector _instance =
      NetworkInjector._internal(baseUrl: '', isProd: false);

  factory NetworkInjector({
    required String baseUrl,
    required bool isProd,
  }) {
    _instance._baseUrl = baseUrl;
    _instance._httpClient =
    isProd
        ? http.Client()
        :
    ChuckerHttpClient(
      http.Client(),
    );

    return _instance;
  }

  NetworkInjector._internal({
    required String baseUrl,
    required bool isProd,
  })  : _baseUrl = baseUrl,
        _httpClient =
        isProd
            ? http.Client()
            :
  ChuckerHttpClient(
          http.Client(),
        );


  @override
  Future<ApiResponse> call(ApiType type, String url,
      {Map<String, String>? headers,
      body,
      Encoding? encoding,
      String? token,
      bool isWithBaseUrl = false,
      Map<String, dynamic>? queryParameter}) async {
    final bool networkStatus = await connectivityChecker();

    if (networkStatus == true) {
      ApiModel _model = ApiModel()
        ..data = null
        ..success = false;
      ApiResponse _apiResponse = ApiInitial(_model);
      if (!isWithBaseUrl) url = _baseUrl + url;
      Uri uri = getUriForEndpoint(url, queryParameter);
      print('url is ============= $url');

      try {
        switch (type) {
          case ApiType.get:
            http.Response res = await _httpClient.get(uri, headers: headers);
            _apiResponse = await ResponseGenerator().generate(res);
            break;
          case ApiType.post:
            http.Response res = await _httpClient.post(uri,
                headers: headers, body: body, encoding: encoding,);

          _apiResponse = await ResponseGenerator().generate(res);
          break;
        case ApiType.delete:
          http.Response res =
              await _httpClient.delete(uri, body: body, headers: headers);
          _apiResponse = await ResponseGenerator().generate(res);
          break;
        case ApiType.put:
          http.Response res = await _httpClient.put(uri,
              headers: headers, body: body, encoding: encoding);
          _apiResponse = await ResponseGenerator().generate(res);
          break;
        case ApiType.patch:
          http.Response res = await _httpClient.patch(uri,
              headers: headers, body: body, encoding: encoding);
          _apiResponse = await ResponseGenerator().generate(res);
          break;

        case ApiType.multipart:
          var request = http.MultipartRequest('POST', uri);
          request.headers.addAll(headers!);
          request.files.add(await http.MultipartFile.fromPath('image', body));

          var response = await request.send();
          var response2 = await http.Response.fromStream(response);
          _apiResponse = await ResponseGenerator().generate(response2);
          break;

          case ApiType.multipartwithBody:
          var request = http.MultipartRequest('POST', uri);
          Map<String,dynamic> data = jsonDecode(body);
          data.entries.forEach((element) {
            request.fields[element.key] = element.value;
          });
          request.headers.addAll(headers!);
          request.files.add(await http.MultipartFile.fromPath('image', data['image']));

          var response = await request.send();
          var response2 = await http.Response.fromStream(response);
          _apiResponse = await ResponseGenerator().generate(response2);
          break;
      }

        return _apiResponse;
      } catch (e) {
        debugPrint('exception is ==== $e');
        ApiResponse apiRes = ApiFail(ApiModel()
          ..message = 'Network Connection Failed'
          ..data = {'code': 10001, 'message': 'Network Connection Failed'});
        return apiRes;
      }
    } else {
      ApiResponse apiRes = ApiFail(ApiModel()
        ..message = 'Network Connection Failed'
        ..data = {'code': 10001, 'message': 'Network Connection Failed'});
      return apiRes;
    }
  }

  Uri getUriForEndpoint(String url, Map<String, dynamic>? queryParameter) {
    Uri uri = Uri.parse(url);
    // if [queryParameter] is passed so add it to the uri
    if (queryParameter != null) {
      uri = Uri(
          scheme: uri.scheme,
          userInfo: uri.userInfo,
          host: uri.host,
          port: uri.port,
          path: uri.path,
          queryParameters: queryParameter,
          query: uri.query,
          fragment: uri.fragment);
    }

    return uri;
  }
}

Future<bool> connectivityChecker() async {
  var connected = false;
  try {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.wifi) ||
        (connectivityResult == ConnectivityResult.mobile)) {
      connected = true;
    } else {
      connected = false;
    }
  } on SocketException catch (_) {
    connected = false;
  }
  return connected;
}
