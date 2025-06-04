import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:eschool/ui/styles/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'logger.dart';

class MyUtil {
  static launchURLCall() async {
    const url = 'tel:+91 9289790045';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchURLCallTrainer(String? mobileNumber) async {
    if (mobileNumber == null) {
      MyUtil.showToast("Mobile Number not available");
      return;
    }
    var url = 'tel:+91 $mobileNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: onBackgroundColor,
        textColor: backgroundColor,
        fontSize: 16.0);
  }

  static Future<void> launchMap(double lat, double long) async {
    final Uri mapUri = Uri.parse("geo:$lat,$long?q=$lat,$long");

    if (await canLaunchUrl(mapUri)) {
      showToast("Launching map...");
      await launchUrl(mapUri, mode: LaunchMode.externalApplication);
    } else {
      showToast("Could not launch map");
      throw 'Could not launch Maps';
    }
  }

  static Future<bool> checkConnectivityStatus() async {
    bool activeConnection = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        activeConnection = true;
      }
    } on SocketException catch (_) {
      activeConnection = false;
    }
    return activeConnection;
  }

  static void removeFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

// Function to convert string to camel case
  static String toCamelCase(String input) {
    List<String> words = input.split(" ");
    return words.map((word) {
      if (word.isEmpty) return "";
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(" ");
  }

  static String convertDateFromString(String strDate, String formate) {
    DateTime dateTime = DateTime.parse(strDate);
    return DateFormat(formate).format(dateTime).toString();
  }

  static String convertDateFromStringForServer(String strDate, String format) {
    DateTime date = DateFormat(format, "en_US").parse(strDate);
    final df = DateFormat('yyyy-MM-dd');
    return df.format(date);
  }

  static String convertDateFromStringFormServer(String strDate, String format) {
    DateTime date = DateFormat(format, "en_US").parse(strDate);
    final df = DateFormat('dd MMM yyyy');
    return df.format(date);
  }

  static String convertDateDDmmYYYFormServer(String strDate, String format) {
    DateTime date = DateFormat(format, "en_US").parse(strDate);
    final df = DateFormat('MMMM dd, yyyy');
    return df.format(date);
  }

  static String convertDateMMYYYFormServer(String? strDate, String format) {
    if (strDate == null || strDate.isEmpty) {
      return "";
    }
    DateTime date = DateFormat(format, "en_US").parse(strDate);
    final df = DateFormat('MMMM yyyy');
    return df.format(date);
  }

  static DateTime dateFromStringForDatePicker(String text) {
    if (text.isEmpty) {
      return DateTime.now();
    }
    DateTime dateTime = DateTime.parse(text);
    return dateTime;
  }

  static String stringForDate(DateTime? dateTime) {
    DateTime date = dateTime!;
    final df = DateFormat('dd MMM yyyy');
    return df.format(date);
  }

  static printWW(String text) {
    if (kDebugMode) {
      // color yellow
      MyLogger.warning("<<<<<<<<< MyDebugger >>>>>>>>>");
      MyLogger.warning(text);
    }
  }

  static printV(String text) {
    if (kDebugMode) {
      // color blue
      MyLogger.debug("<<<<<<<<< MyDebugger >>>>>>>>>");
      MyLogger.debug(text);
    }
  }

  static printW(String text) {
    if (kDebugMode) {
      // color green
      MyLogger.info("<<<<<<<<< MyDebugger >>>>>>>>>");
      developer.log(text, level: 500);
    }
  }

  static printE(String text) {
    if (kDebugMode) {
      // color red
      MyLogger.info("<<<<<<<<< MyDebugger >>>>>>>>>");
      MyLogger.info(text);
    }
  }

  static printI(String text) {
    if (kDebugMode) {
      // color blue
      MyLogger.error("<<<<<<<<< MyDebugger >>>>>>>>>");
      MyLogger.error(text);
    }
  }

  static printD(String text) {
    if (kDebugMode) {
      MyLogger.info("<<<<<<<<< MyDebugger >>>>>>>>>");
      MyLogger.info(text);
    }
  }

  static showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(
              color: backgroundColor,
              fontWeight: FontWeight.w400,
              fontSize: 13),
        ),
        backgroundColor: onBackgroundColor,
      ),
    );
  }

  static hideKeyBoard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void showSnackBarr(BuildContext context, String msg) {
    MyUtil.showSnackBar(context, msg);
  }

  static loadTrainerDashBoard(BuildContext context, String moveScreen) {
    Navigator.pushNamedAndRemoveUntil(context, moveScreen, (r) => false);
  }

  static Future<String> loadImage(String userImageUrl) async {
    // Simulate an asynchronous operation
    await Future.delayed(const Duration(seconds: 4));
    return userImageUrl;
  }

  static String? modifiedPhone(String? phone) {
    if (phone == null || phone.length < 10) {
      return phone;
    }
    return "${phone.substring(0, 4)}XXXX${phone.substring(8, 10)}";
  }

  static String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "y" : "ys"}";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "m" : "ms"}";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "w" : "ws"}";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "d" : "ds"}";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "h" : "hs"}";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "m" : "ms"}";
    }
    return "just now";
  }

  static String getDayWish() {
    String wish;
    DateTime cal = DateTime.now();
    int hour = cal.hour;
    if (hour >= 16) {
      wish = "Good Evening!";
    } else if (hour >= 12) {
      wish = "Good Afternoon!";
    } else {
      wish = "Good Morning!";
    }
    return wish;
  }

  static String dateFormate(String? s, String current, String required) {
    var formattedDate = "";
    if (s == null) {
      formattedDate = "";
    }
    try {
      formattedDate =
          DateFormat(required).format(DateFormat(current).parse(s!));
    } catch (e) {
      MyUtil.printW("Exceptions in the: $s");
      MyUtil.printW(e.toString());
      formattedDate = "";
    }
    return formattedDate;
  }

  static DateTime getDateTimeFromStringDate(
    String s,
    String dateFormate,
  ) {
    return DateFormat(dateFormate).parse(s);
  }
}
