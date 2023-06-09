import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:task/core/constants/app_words.dart';
import 'package:task/model/partication_daily_history_response.dart';
import 'package:task/screens/total_participation/bloc/participation_bloc.dart';
import 'package:task/screens/total_participation/view/DatePickerbottomSheet.dart';
import 'package:task/screens/total_participation/view/participation_transaction_detail.dart';
import 'package:task/util/bottomsheet/bottomsheet_utils.dart';
import 'package:task/util/time_converter.dart';

class StickyDateTab extends StatefulWidget {
  const StickyDateTab({super.key});

  @override
  State<StickyDateTab> createState() => _StickyDateTabState();
}

class _StickyDateTabState extends State<StickyDateTab> {
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipationBloc, ParticipationState>(
        buildWhen: (current, previous) =>
        current.isDailyParticipationLoading !=
            previous.isDailyParticipationLoading,
        builder: (_, state) {
          return Column(
            // shrinkWrap: true,
            children: [
              StickyHeader(
                header: Container(
                  height: 68,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF), border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),),
                  child: ListTile(
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(0),
                    //     side: BorderSide(color: Color(0xFFDCDEE6), width: 1)),
                    title: const Text(
                      '지급내역',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        // showModalBottomSheet(context: context, builder: (context){
                        //  return DatePickerBottomSheet();
                        // });

                        BottomSheetUtil.showBottomSheet(context, SizedBox(
                            height: 400,
                            child: DatePickerBottomSheet()),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            state.getSelectedDate(),
                            style: const TextStyle(
                              color: Color(0xFF838799),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          SvgPicture.asset('assets/drop_down.svg')
                        ],
                      ),
                    ),
                  ),
                ),
                content: state.isDailyParticipationLoading
                    ? const SizedBox(height: 250,child:  Center(child: CircularProgressIndicator(color: Color(0xFF0335B4),)))
                    : ListView(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding:  EdgeInsets.only(left:20.0),
                      child:  Text(
                        '- 결제대금 지급기간 동안 일일 분할지급 되며 \n매주 월요일 주간 정산하며 지급됩니다.',
                        style: TextStyle(
                          color: Color(0xFF838799),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    transactionList(state.dailyParticipationHistory)
                  ],
                ),
              ),
            ],
          );
        });
  }

  transactionList(DailyParticipationHistory? dailyParticipationHistory) {
    if (dailyParticipationHistory != null) {
      if (dailyParticipationHistory.list?.isNotEmpty == true) {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: dailyParticipationHistory.list?.length ?? 0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      child: transactionHeader(
                          dailyParticipationHistory.list?[index].date ??
                              AppWords.emptyString,
                          '${dailyParticipationHistory.list?[index]
                              .totalPayoutAmount ?? AppWords.emptyString}')),
                  const Divider(
                    color: Color(0xFFDCDEE6),
                    height: 1,
                  ),
                  Wrap(
                      children: payments(
                          dailyParticipationHistory.list?[index].payments)),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(
                    color: Color(0xFFDCDEE6),
                    height: 1,
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              );
            });
      }
    }
    return const SizedBox.shrink();
  }

  transactionHeader(String date, String totalAmount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          date,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        RichText(
          text: TextSpan(children: [
            const TextSpan(
                text: '누적지급금 ',
                style: TextStyle(
                  color: Color(0xFF838799),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                )),
            TextSpan(
                text: '$totalAmount원',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                )),
          ]),
        )
      ],
    );
  }

  List<Widget> payments(PaymentList? payments) {
    if (payments != null) {
      if (payments.list?.isNotEmpty == true) {
        return List.generate(payments.list?.length ?? 0,
                (index) => payment(payments.list?[index]));
      }
    }

    return [const SizedBox.shrink()];
  }

  payment(PaymentItem? item) {
    return ListTile(
      leading: Text(
        item?.createdAt?.gethmmDate() ?? '',
        style: const TextStyle(
          color: Color(0xFF838799),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      title: Text(
        (item?.dailyPayout ?? '').toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        '(전송일시 ${item?.createdAt?.getmmDDDate()??''})',
        style: const TextStyle(
          color: Color(0xFF838799),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          Navigator.push(context, ParticipationDetails.route(item!.uuid));
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          SvgPicture.asset('assets/detail.svg'),
          Text(
            (item?.dailyPayoutMsq ?? '').toString(),
            style: const TextStyle(
              color: Color(0xFF0A41CC),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ]),
      ),
    );
  }
}