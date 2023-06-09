import 'package:flutter/material.dart';
import 'package:task/model/participation_response.dart';

class ParticipationCases extends StatelessWidget {
  final SuperSaveRequestList data;

  const ParticipationCases({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.list != null) {
      return Wrap(
          children: List.generate(data.list!.length, (index) {
            debugPrint('the value is ${data.list![index].lastSentDate}');
            return Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: participationCard(data.list![index]));
          }));
    } else {
      debugPrint('the list is null');
      return const SizedBox.shrink();
    }
  }

  Widget participationCard(SuperSaveRequest data) =>
      Card(
        color: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(width: 1, color: Color(0xFFDCDEE6))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            children: [
              msqAndPercentageRow(
                data,
              ),
              const SizedBox(height: 10),
              paymentProgressIndicator(data.completedPayoutPercentage),
            ],
          ),
        ),
      );

  msqAndPercentageRow(SuperSaveRequest data) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('${data.dailyPayoutAmountMsq}(전송일시 ${data.lastSentDate})',
              style: const TextStyle(
                color: Color(0xFF838799),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              )),
          Text(
            '${data.completedPayoutPercentage}%',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          )
        ],
      );

  paymentProgressIndicator(int? completedPayoutPercentage) =>
      ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: SizedBox(
          height: 6,
          child: LinearProgressIndicator(
            value: (completedPayoutPercentage ?? 0).toDouble(),
            color: const Color(0xFF0335B4),
            backgroundColor: const Color(0xFFE8EEFF),
          ),
        ),
      );
}