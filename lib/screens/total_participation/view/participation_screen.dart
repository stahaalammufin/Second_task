import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:task/core/constants/app_words.dart';
import 'package:task/model/participation_response.dart';
import 'package:task/screens/total_participation/bloc/participation_bloc.dart';
import 'package:task/util/snack_bar_util.dart';

class ParticipationScren extends StatelessWidget {
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
              child: Container(
                color: Color(0xFFDCDEE6),
                height: 2.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        body: BlocConsumer<ParticipationBloc, ParticipationState>(
          listenWhen: (previous, current) =>
              previous.errorMessage != current.errorMessage,
          listener: (context, state) {
            SnackBarUtil.critical(text: state.errorMessage);
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.response != null) {
              return ParticipationPaymentScreen(
                response: state.response!,
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

class ParticipationPaymentScreen extends StatelessWidget {
  final ParticipationResponse response;

  const ParticipationPaymentScreen({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: participationText(
              '참여 현황 총 ${response.superSaveRequest?.list?.length ?? 0} 건'),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(
                width: 1.0,
                color: const Color(0xFFDCDEE6),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  getBoxData('총 지급완료 외상대금', '${response.totalPayout ?? 0}'),
                  const SizedBox(
                    height: 14,
                  ),
                  getBoxData('총 잔여 외상대금', '${response.remainingBalance ?? 0}'),
                  const SizedBox(
                    height: 14,
                  ),
                  getBoxData('총 일일균등지급금', '${response.dailyPayout ?? 0}'),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 46,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: PieChart(
            dataMap: {
              "지급예정 금액": (response.completedPayoutPercentage ?? 0).toDouble(),
              "지급완료 금액":
                  (100 - (response.completedPayoutPercentage ?? 0).toDouble()),
            },
            chartType: ChartType.ring,
            colorList: const [
              Color(0xFF0335B4),
              Color(0xFFDBE5FE),
            ],
            chartRadius: MediaQuery.of(context).size.width / 2.7,
            ringStrokeWidth: 40,
            initialAngleInDegree: -90,
            animationDuration: const Duration(seconds: 2),
            chartValuesOptions: const ChartValuesOptions(
                chartValueBackgroundColor: Colors.white,
                showChartValuesInPercentage: true,
                showChartValuesOutside: true),
            legendOptions: const LegendOptions(showLegends: false),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pieLegend(color: const Color(0xFF0335B4), label: '지급완료 금액'),
              const SizedBox(
                width: 14,
              ),
              pieLegend(color: const Color(0xFFDBE5FE), label: '지급완료 금액'),
            ],
          ),
        ),
        const SizedBox(
          height: 46,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: participationText(
              '참여 건별 지급 현황 총 ${response.superSaveRequest?.list?.length ?? 0}건'),
        ),
        const SizedBox(
          height: 10,
        ),
        ParticipationCases(data: response.superSaveRequest!),
      ],
    );
    // );
  }

  Widget pieLegend({required Color color, required String label}) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF838799),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      );

  Widget getBoxData(String title, String value) => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF838799),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          )
        ],
      );

  Widget participationText(statusValue) => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            statusValue,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const Text(
            '참여중 기준 ',
            style: TextStyle(
              color: Color(0xFF838799),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          )
        ],
      );
}

class ParticipationCases extends StatelessWidget {
  final SuperSaveRequestList data;

  ParticipationCases({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.list != null) {
      return Wrap(
          children: List.generate(data.list!.length, (index) {
        return participationCard(data.list![index]);
      }));
    } else {
      debugPrint('the list is null');
      return const SizedBox.shrink();
    }
  }

  Widget participationCard(SuperSaveRequest superSaveRequest) => Card(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                      '${superSaveRequest.dailyPayoutAmountMsq}(전송일시 ${superSaveRequest.lastSentDate})')
                ],
              )
            ],
          ),
        ),
      );
}
