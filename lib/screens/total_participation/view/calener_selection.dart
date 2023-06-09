

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnYearChanged = void Function(String year);
typedef OnMonthChanged = void Function(int month);
class Picker extends StatefulWidget {
  final OnYearChanged onYearChanged;
  final OnMonthChanged onMonthChanged;

  const Picker({super.key, required this.onYearChanged, required this.onMonthChanged});

  @override
  _PickerState createState() =>
      _PickerState();
}

class _PickerState extends State<Picker> {
  int selectedMonth = 0;
  String selectedYear = '';
  List<String> monthList = [];
  List<String> yearList = [];

  @override
  void initState() {
    super.initState();
    monthList = List.generate(12, (index) => '${index+1} 월');
    widget.onMonthChanged(1);
    var halfyearList = List.generate(4, (index) => '${DateTime.now().year + index}');
    halfyearList.remove('${DateTime.now().year}');
    yearList.addAll(halfyearList);
    halfyearList  = List.generate(3, (index) => '${DateTime.now().year - index}');
    yearList.addAll(halfyearList);
    widget.onYearChanged(
        yearList[yearList.indexOf('${DateTime.now().year}')]
    );

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Adjust the height as needed
      child: Row(
        children: [
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40, // Adjust the item height as needed
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedYear = yearList[index];
                });
                widget.onYearChanged(selectedYear);

              },
              scrollController: FixedExtentScrollController(
                  initialItem: yearList.indexOf('${DateTime.now().year}'),
              ),
              children: yearList.map((item) {
                return Center(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40, // Adjust the item height as needed
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedMonth = index;
                });
                widget.onMonthChanged(selectedMonth+1);

              },
              children: monthList.map((item) {
                return Center(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}