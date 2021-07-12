import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime time) {
  if(time != null){
    var dateString = DateFormat('dd/MM/yyyy hh:MM').format(time);
    return dateString;
  }
  return "";
}

void requestFocus(BuildContext context) {
  FocusScope.of(context).unfocus();
}