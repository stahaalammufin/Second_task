
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:task/core/constants/app_words.dart';
import 'package:task/model/partication_daily_history_response.dart';
import 'package:task/model/participation_response.dart';
import 'package:task/screens/total_participation/bloc/participation_bloc.dart';
import 'package:task/screens/total_participation/view/participation_payment_screen.dart';
import 'package:task/screens/total_participation/view/participation_transaction_detail.dart';
import 'package:task/util/snack_bar_util.dart';
import 'package:task/util/time_converter.dart';

import '../../../util/bottomsheet/bottomsheet_utils.dart';
import 'DatePickerbottomSheet.dart';

class ParticipationScren extends StatelessWidget {
  const ParticipationScren({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            AppWords.superSavePaymentDetails,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: const Color(0xFFDCDEE6),
                height: 2.0,
              )),
        ),
        body: BlocConsumer<ParticipationBloc, ParticipationState>(
          listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage,
          listener: (context, state) {
            SnackBarUtil.critical(text: state.errorMessage);
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator(
                color: Color(0xFF0335B4),
              ));
            } else if (state.response != null) {
              return ParticipationPaymentScreen(
                response: state.response!,
                date: state.selectedDate,
              );
            } else {
              return const Center(child: Text(AppWords.noDataFound));
            }
          },
        ),
      ),
    );
  }
}



