class ENP{
  /// [ENP]
  static final ENP _instance = ENP._internal();

  factory ENP() => _instance;

  ENP._internal();


  final baseUrl = "https://api.dev.msq.market/";


  final  String getTotalParticipationHistory = 'super-save/test/get_total_participation_history';
  final String getTotalParticipationDailyHistory = 'super-save/test/get_total_participation_daily_history';
  final String getPaymentDetails= 'super-save/test/get_daily_payment_details';
}