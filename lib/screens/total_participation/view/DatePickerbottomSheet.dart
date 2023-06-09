import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task/screens/total_participation/bloc/participation_bloc.dart';
import 'package:task/widgets/button.dart';

import '../../../util/bottomsheet/bottom_sheet_handler_view.dart';
import 'calener_selection.dart';

class DatePickerBottomSheet extends StatelessWidget {
  Widget _buildBottomSheetContent(BuildContext context) {
    int selectedMonth = 0;
    String selectedYear = '';
    return Wrap(children: [
      Container(
        height: 370,
        child: Padding(
          padding: const EdgeInsets.only(bottom:20.0,left: 20, right: 20),
          child: Column(
            children: [
              const BottomSheetHandlerView(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '조회 기간 선택',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Picker(
                onMonthChanged: (month) {
                  selectedMonth = month;
                },
                onYearChanged: (year) {
                  selectedYear = year;
                },
              ),
              SizedBox(height: 16),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 52,
                  child: BottomButton(buttonText: '확인', callback: () {
                    var month = selectedMonth.toString();
                    if(selectedMonth<10) {
                      debugPrint('month is  $selectedMonth');

                      month = '0$selectedMonth';
                    }
                    var date = '$selectedYear-$month';
                    debugPrint('date is $date');
                    context.read<ParticipationBloc>().add(UpdateSelectedDate(date));
                    Navigator.pop(context);
                  })),
            ],
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildBottomSheetContent(context),
    );
  }
}
