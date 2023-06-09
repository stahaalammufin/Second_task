part of 'participation_bloc.dart';


class ParticipationState extends Equatable {
  final ParticipationResponse? response;
  final DailyParticipationHistory? dailyParticipationHistory;
  final PaymentDetails? paymentDetail;
  final bool isDailyParticipationLoading;
  final bool isLoading;
  final String errorMessage;
  String selectedDate;

   ParticipationState({
    this.response,
    this.dailyParticipationHistory,
    this.paymentDetail,
    this.isLoading = false,
    this.isDailyParticipationLoading = false,
    this.errorMessage = AppWords.emptyString,
    this.selectedDate = AppWords.emptyString,
  });

  ParticipationState copyWith({
    ParticipationResponse? participationResponse,
    bool? isLoading,
    DailyParticipationHistory? dailyParticipationHistory,
    PaymentDetails? paymentDetail,
    bool? isDailyParticipationLoading,
    String? errorMessage,
    String? selectedDate,
  }) {
    return ParticipationState(
      response: participationResponse ?? response,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedDate: selectedDate ?? this.selectedDate,
      isDailyParticipationLoading: isDailyParticipationLoading ?? this.isDailyParticipationLoading,
      dailyParticipationHistory: dailyParticipationHistory ?? this.dailyParticipationHistory,
      paymentDetail: paymentDetail ,
    );
  }

  @override
  List<Object> get props => [isLoading,errorMessage,selectedDate,isDailyParticipationLoading];

  String getSelectedDate() {
    if(selectedDate.isEmpty){
      var time = DateTime
          .now();
      var month = DateFormat('MM').format(time);
      selectedDate =' ${time
          .year}-${month}';
    }

    return selectedDate;
  }
}
