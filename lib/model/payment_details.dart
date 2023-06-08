class PaymentDetails {
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
  String? userName;
  String? userEmail;
  String? sentDate;
  String? bankName;
  String? bankAccountNumber;

  PaymentDetails.fromJson(Map<String, dynamic> json)
      : userid = json['user_id'],
        superSaveRequestid = json['super_save_request_id'],
        payoutDate = json['payout_date'],
        updatedAt = json['updatedAt'],
        dailyPayout = json['daily_payout'],
        createdAt = json['createdAt'],
        cumulativePayment = json['cumulative_payment'],
        uuid = json['uuid'],
        weekHistoryId = json['week_history_id'],
        dailyPayoutMsq = json['daily_payout_msq'],
        userName = json['user_name'],
        userEmail = json['user_email'],
        sentDate = json['sent_date'],
        bankName = json['bank_name'],
        bankAccountNumber = json['bank_account_number'];
}
