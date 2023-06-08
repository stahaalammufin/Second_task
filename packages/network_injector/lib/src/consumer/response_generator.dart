import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../enums/network_exceptions_enums.dart';
import '../enums/network_status.dart';
import '../models/api_model_states.dart';

class ResponseGenerator {
  /// [ResponseGenerator Singleton]
  static final ResponseGenerator _instance = ResponseGenerator._internal();
  factory ResponseGenerator() => _instance;
  ResponseGenerator._internal();

  /// [ApiModel]
  ApiModel apiModel = ApiModel()
    ..data = null
    ..success = false;

  Future<ApiResponse> generate(Response res) async {
    ApiResponse apiRes = ApiInitial(apiModel);
    String responseBody = res.body.isNotEmpty ? res.body : '{}';

    var data = jsonDecode('[]');
    try {
      data = jsonDecode(responseBody);
    } catch (e) {}

    try {
      apiModel.status = res.statusCode /*?? data['status']*/;

      if (data is List) {
        apiModel.success = (res.statusCode >= 200 && res.statusCode < 300);
        apiModel.message = apiModel.success ? '' : 'Some error occurred';
      } else {
        apiModel.success = res.statusCode >= 200 && res.statusCode < 300;
        apiModel.message = data["message"] ?? (apiModel.success ? '' : 'Some error occurred');
      }
      if(!apiModel.success){
        print('response is ${res}');
      }
      apiModel.data = !ApiStatus.contains(apiModel.status) ? null : data;

      if (ApiStatus.contains(apiModel.status)) {
        apiRes = ApiSuccess(apiModel);
      } else {
        apiModel.message = Exceptions.server.customMessage(apiModel.message);
        apiModel.body = data;
        apiRes = ApiFail(apiModel);
      }
    } on SocketException {
      apiModel.message = Exceptions.internet.message;
      apiRes = ApiFail(apiModel);
    } on FormatException {
      apiModel.message = Exceptions.formate.message;
      apiRes = ApiFail(apiModel);
    } on HttpException {
      apiModel.message = Exceptions.http.message;
      apiRes = ApiFail(apiModel);
    } catch (e) {
      apiModel.message = apiModel.message != ''
          ? apiModel.message
          : Exceptions.unknown.message;
      apiRes = ApiFail(apiModel);
    }
    return apiRes;
  }
}
