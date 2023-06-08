class ParticipationResponse {
  String? totalPayout;
  String? remainingBalance;
  String? dailyPayout;
  int? completedPayoutPercentage;
  SuperSaveRequestList? superSaveRequest;

  ParticipationResponse.fromJson(Map<String, dynamic> json)
      : totalPayout = json['total_payout'],
        remainingBalance = json['remaining_balance'],
        dailyPayout = json['daily_payout'],
        completedPayoutPercentage = json['completed_payout_percentage'],
        superSaveRequest =
            SuperSaveRequestList.fromJson(json['super_save_requests']);
}

class SuperSaveRequestList {
  List<SuperSaveRequest>? list;

  SuperSaveRequestList.fromJson(List json) {
    final data = <SuperSaveRequest>[];
    for (var item in json) {
      var dataItem = SuperSaveRequest.fromJson(item);

      data.add(dataItem);
    }
    list = data;
  }
}

class SuperSaveRequest {
  int? dailyPayoutAmount;
  int? completedPayoutPercentage;
  String? lastSentDate;
  String? dailyPayoutAmountMsq;
  String? msqAmount;

  SuperSaveRequest.fromJson(Map<String, dynamic> json)
      : dailyPayoutAmount = json['daily_payout_amount'],
        completedPayoutPercentage = json['completed_payout_percentage'],
        lastSentDate = json['last_sent_date'],
        dailyPayoutAmountMsq = json['daily_payout_amount_msq'],
        msqAmount = json['daily_payout_amount_msq'];
}
