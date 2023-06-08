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
        superSaveRequestid = json['user_id'],
        payoutDate = json['user_id'],
        updatedAt = json['user_id'],
        dailyPayout = json['user_id'],
        cumulativePayment = json['user_id'],
        uuid = json['user_id'],
        weekHistoryId = json['user_id'],
        dailyPayoutMsq = json['user_id'];
}
