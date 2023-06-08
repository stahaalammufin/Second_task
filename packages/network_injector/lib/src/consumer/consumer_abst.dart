import 'dart:convert' show Encoding;

import '../enums/api_call_enum.dart';
import '../models/api_model_states.dart';

///[An abstract class for API Calling]
abstract class ApiCall {
  Future<ApiResponse> call(ApiType type, String url,
      {Map<String, String>? headers,
      body,
      Encoding? encoding,
      String? token,
      bool isWithBaseUrl = false});
}
