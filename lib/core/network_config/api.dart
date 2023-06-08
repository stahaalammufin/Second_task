import 'package:network_injector/network_injector.dart';
import 'package:task/core/network_config/enp.dart';

class API {
  /// [Singleton instance of API]
  static final API _instance = API._internal();

  factory API() => _instance;

  API._internal();

  /// [Network Injector for calling http request]
  final NetworkInjector _ntCall = NetworkInjector(
    baseUrl: ENP().baseUrl,
    isProd: false,
  );

  Future<ApiResponse> getTotalParticipationHistory() async {
    return await _ntCall.call(ApiType.get, ENP().getTotalParticipationHistory);
  }

  Future<ApiResponse> getTotalParticipationDailyHistory(
      {required Map<String, dynamic> queryParameter}) async {
    return await _ntCall.call(
        ApiType.get, ENP().getTotalParticipationDailyHistory,
        queryParameter: queryParameter);
  }

  Future<ApiResponse> getPaymentDetails(
      {required Map<String, dynamic> queryParameter}) async {
    return await _ntCall.call(ApiType.get, ENP().getPaymentDetails,
        queryParameter: queryParameter);
  }
}
