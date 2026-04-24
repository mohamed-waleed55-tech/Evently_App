import 'package:intl/intl.dart';

extension  FormateDate on DateTime{
  String get getMonth{
    DateFormat formattedDate=DateFormat("MMMM");
    return formattedDate.format(this);
  }
  String get toFormattedDate{
    DateFormat formattedDate=DateFormat("dd / MM / yyyy ");
    return formattedDate.format(this);

  }

  String get date {
    return DateFormat('d MMMM yyyy').format(this);
  }

  String get time {
    return DateFormat('hh:mm a').format(this);
  }
}