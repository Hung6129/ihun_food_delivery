import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastInfor({
  required String text,
  Color bgColor = Colors.black,
  Color textColor = Colors.white,
}) =>
    Fluttertoast.showToast(
      webPosition: "center",
      msg: text,
      backgroundColor: bgColor,
      textColor: textColor,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2,
      gravity: ToastGravity.TOP,
      fontSize: 14.sp,
    );
