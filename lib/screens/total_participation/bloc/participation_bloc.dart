import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:network_injector/network_injector.dart';
import 'package:task/core/constants/app_words.dart';
import 'package:task/util/time_converter.dart';

import '../../../core/network_config/api.dart';
import '../../../model/partication_daily_history_response.dart';
import '../../../model/participation_response.dart';
import '../../../model/payment_details.dart';

part 'participation_event.dart';

part 'participation_state.dart';

class ParticipationBloc extends Bloc<ParticipationEvent, ParticipationState> {
  ParticipationBloc() : super(ParticipationState()) {
    on<GetParticipationHistory>(_handleGetParticipationHistoryEvent);
    on<GetDailyParticipationHistory>(_handleGetDailyParticipationHistoryEvent);
    on<GetPaymentDetailEvent>(_handleGetPaymentDetailEvent);
    on<UpdateSelectedDate>(_handleUpdateSelectedDateEvent);
  }

  FutureOr<void> _handleGetParticipationHistoryEvent(
    GetParticipationHistory event,
    Emitter<ParticipationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse response = await API().getTotalParticipationHistory();
    if (response is ApiSuccess) {
      emit(state.copyWith(
        participationResponse:
            ParticipationResponse.fromJson(response.apiModel.body['data']),
        isLoading: false,
      ));
      add(GetDailyParticipationHistory(state.getSelectedDate(), ''));
    } else {
      emit(state.copyWith(
        errorMessage: AppWords.someThingWentWrong,
        isLoading: false,
      ));
    }
  }

  FutureOr<void> _handleGetDailyParticipationHistoryEvent(
    GetDailyParticipationHistory event,
    Emitter<ParticipationState> emit,
  ) async {
    emit(state.copyWith(isDailyParticipationLoading: true));
    List<String> components = event.startDate.split('-');
    int year = int.parse(components[0]);
    int month = int.parse(components[1]);
    var start = DateTime(year, month);
    int currentMonth = start.month;
    int monthsToAdd = 6;

    int newMonth = (currentMonth + monthsToAdd) % 12;
    int newYear = start.year + ((currentMonth + monthsToAdd) ~/ 12);

    if (newMonth == 0) {
      newMonth = 12;
      newYear -= 1;
    }
    var endDate =
        DateTime(newYear, newMonth, start.day).toString().getyyyymmDate();

    ApiResponse response = await API().getTotalParticipationDailyHistory(
        queryParameter: {
          'start_date': start.toString().getyyyymmDate(),
          'end_date': endDate
        });
    if (response is ApiSuccess) {
      emit(state.copyWith(
        dailyParticipationHistory:
            DailyParticipationHistory.fromJson(response.apiModel.body['data']),
        isDailyParticipationLoading: false,
      ));
    } else {
      emit(state.copyWith(
        errorMessage: AppWords.someThingWentWrong,
        isDailyParticipationLoading: false,
      ));
    }
  }

  FutureOr<void> _handleGetPaymentDetailEvent(
      GetPaymentDetailEvent event, Emitter<ParticipationState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse response = await API().getPaymentDetails(queryParameter: {
      'payment_id': event.paymentId,
    });
    if (response is ApiSuccess) {
      emit(state.copyWith(
        paymentDetail: PaymentDetails.fromJson(response.apiModel.body['data']),
        isLoading: false,
      ));
    } else {
      emit(state.copyWith(
        errorMessage: AppWords.someThingWentWrong,
        isLoading: false,
      ));
    }
  }

  _handleUpdateSelectedDateEvent(
      UpdateSelectedDate event, Emitter<ParticipationState> emit) {
    if (event.selectedDate.isEmpty) {
      return;
    }

    emit(
      state.copyWith(
        selectedDate: event.selectedDate,
      ),
    );

    add(GetDailyParticipationHistory(state.selectedDate,''));
  }
}
