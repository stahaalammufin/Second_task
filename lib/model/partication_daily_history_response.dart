class DailyParticipationHistory {
  List<DailyParticipationHistoryItem>? list;

  DailyParticipationHistory.fromJson(List json) {
    final data = <DailyParticipationHistoryItem>[];
    for (var item in json) {
      var dataItem = DailyParticipationHistoryItem.fromJson(item);

      data.add(dataItem);
    }
    list = data;
  }
}

class DailyParticipationHistoryItem {
  String? date;
  int? totalPayoutAmount;
  bool? isWeeklyPaymentDay;
  int? weeklyPayoutAmount;
  int? depositPayoutAmount;
  PaymentList? payments;

  DailyParticipationHistoryItem.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        totalPayoutAmount = json['total_payout_amount'],
        isWeeklyPaymentDay = json['is_weekly_payment_day'],
        weeklyPayoutAmount = json['weekly_payout_amount'],
        depositPayoutAmount = json['deposit_payout_amount'],
        payments = PaymentList.fromJson(json['payments']);
}

class PaymentList {
  List<PaymentItem>? list;

  PaymentList.fromJson(List json) {
    final data = <PaymentItem>[];
    for (var item in json) {
      var dataItem = PaymentItem.fromJson(item);

      data.add(dataItem);
    }
    list = data;
  }
}

class PaymentItem {
  String? userid;
  String? superSaveRequestid;
  String? payoutDate;
  String? updatedAt;
  int? dailyPayout;
  String? createdAt;
  int? cumulativePayment;
  String? uuid;
  String? weekHistoryId;
  double? dailyPayoutMsq;

  PaymentItem.fromJson(Map<String, dynamic> json)
      : userid = json['user_id'],
        superSaveRequestid = json['super_save_request_id'],
        payoutDate = json['payout_date'],
        updatedAt = json['updatedAt'],
        dailyPayout = json['daily_payout'],
        createdAt = json['createdAt'],
        cumulativePayment = json['cumulative_payment'],
        uuid = json['uuid'],
        weekHistoryId = json['week_history_id'],
        dailyPayoutMsq = json['daily_payout_msq'];
}
