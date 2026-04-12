import 'package:intl/intl.dart';

extension  FormateDate on DateTime{
  String get getMonth{
    DateFormat formattedDate=DateFormat("MMMM");
    return formattedDate.format(this);
  }

}