import 'package:intl/intl.dart';

extension TimeCoverter on String{
  String gethmmDate(){
    DateTime dateTime = DateTime.parse(this);
    return DateFormat('h:mm').format(dateTime);
  }

  String getmmDDDate(){
    DateTime dateTime = DateTime.parse(this);
    return DateFormat('MM-dd HH:mm').format(dateTime);
  }

  String getyyyymmddhhmmssDate(){
    DateTime dateTime = DateTime.parse(this);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  String getyyyymmDate(){
    DateTime dateTime = DateTime.parse(this);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}