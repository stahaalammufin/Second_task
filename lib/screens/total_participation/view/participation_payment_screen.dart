import 'package:flutter/material.dart';
import 'package:task/model/participation_response.dart';
import 'package:task/screens/total_participation/view/participation_cases.dart';
import 'package:task/screens/total_participation/view/participation_screen.dart';
import 'package:task/screens/total_participation/view/pie.dart';
import 'package:task/screens/total_participation/view/sticky_tab.dart';

class ParticipationPaymentScreen extends StatelessWidget {
  final ParticipationResponse response;
  final String date;

  const ParticipationPaymentScreen(
      {super.key, required this.response, required this.date});

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
        Pie(
          completedPayoutPercentage: response.completedPayoutPercentage ?? 0,
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
        const SizedBox(
          height: 10,
        ),
        const StickyDateTab()
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