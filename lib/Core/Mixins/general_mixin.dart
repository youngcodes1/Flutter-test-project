import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'dart:convert';
import 'package:get/get.dart';

import '../../Utils/Colors/colors.dart';

mixin GeneralMixin {
  Map<String, String> setHeaders() {
    return {
      'Content-Type': "application/json",
      'accept': "*/*",
    };
  }

  Future<http.Response?> post(
      {required String route, required Map data}) async {
    Map<String, String> headers = setHeaders();
    try {
      http.Response res = await http
          .post(
            Uri.parse(route),
            body: jsonEncode(data),
            headers: headers,
          )
          .timeout(
            const Duration(seconds: 60),
          );
      return res;
    } on TimeoutException {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Connection timed out',
        confirmBtnColor: AppColors.myblue,
      );
      return null;
    } catch (error) {
      // Utils.debugPrints(error);
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Something went wrong. Try again.',
        confirmBtnColor: AppColors.myblue,
      );
      return null;
    }
  }

  Future<http.Response?> get({required String route}) async {
    Map<String, String> headers = setHeaders();
    try {
      http.Response res = await http
          .get(
            Uri.parse(route),
            headers: headers,
          )
          .timeout(
            const Duration(seconds: 60),
          );
      return res;
    } on TimeoutException {
      //handle timeout
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Connection timed out',
        confirmBtnColor: AppColors.myblue,
      );
      return null;
    } catch (error) {
      // Utils.debugPrints(error);
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Something went wrong. Try again.',
        confirmBtnColor: AppColors.myblue,
      );
      return null;
    }
  }
}
