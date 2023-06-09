part of 'participation_bloc.dart';


abstract class ParticipationEvent extends Equatable {
  const ParticipationEvent();

  @override
  List<Object> get props => [];
}

///event will be used to get the participations
class GetParticipationHistory extends ParticipationEvent {
  const GetParticipationHistory();
}

///event will be used to get daily participation based on the provided
///[startDate] and [endDate] provided by the user
class GetDailyParticipationHistory extends ParticipationEvent {
  final String startDate;
  final String endDate;

  const GetDailyParticipationHistory(this.startDate, this.endDate);

  @override
  List<Object> get props => [
        startDate,
        endDate,
      ];
}


/// event that will be used to view the details of the payment
/// against the provided [paymentId]
class GetPaymentDetailEvent extends ParticipationEvent {
  final String paymentId;

  const GetPaymentDetailEvent(
    this.paymentId,
  );

  @override
  List<Object> get props => [
        paymentId,
      ];
}
class UpdateSelectedDate extends ParticipationEvent {
  final String selectedDate;

  const UpdateSelectedDate(
    this.selectedDate,
  );

  @override
  List<Object> get props => [
    selectedDate,
      ];
}
