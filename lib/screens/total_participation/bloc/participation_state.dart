part of 'participation_bloc.dart';

class ParticipationState extends Equatable {
  final ParticipationResponse? response;
  final bool isLoading;
  final String errorMessage;

  const ParticipationState({
    this.response,
    this.isLoading = false,
    this.errorMessage = AppWords.emptyString,
  });

  ParticipationState copyWith({
    ParticipationResponse? participationResponse,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ParticipationState(
      response: participationResponse ?? response,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [isLoading,errorMessage];
}
