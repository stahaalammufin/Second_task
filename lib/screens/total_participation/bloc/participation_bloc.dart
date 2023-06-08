import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_injector/network_injector.dart';
import 'package:task/core/constants/app_words.dart';

import '../../../core/network_config/api.dart';
import '../../../model/participation_response.dart';

part 'participation_event.dart';

part 'participation_state.dart';

class ParticipationBloc extends Bloc<ParticipationEvent, ParticipationState> {
  ParticipationBloc() : super(const ParticipationState()) {
    on<GetParticipationHistory>(_handleGetParticipationHistoryEvent);
  }

  FutureOr<void> _handleGetParticipationHistoryEvent(
    GetParticipationHistory event,
    Emitter<ParticipationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse response = await API().getTotalParticipationHistory();
    if (response is ApiSuccess) {
      emit(state.copyWith(
        participationResponse: ParticipationResponse.fromJson(response.apiModel.body['data']),
        isLoading: false,
      ));
    } else {
      emit(state.copyWith(
        errorMessage: AppWords.someThingWentWrong,
        isLoading: false,
      ));
    }
  }
}
