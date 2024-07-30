import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../generated/assets.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';
import 'button.dart';

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

// Snack bar for showing success message
successSnackBar({String title = 'Success', String? message}) {
  if (Get.isSnackbarOpen) {
    Get.back();
  }
  Get.log('\x1B[92m[$title] => $message\x1B[0m');
  if (message != null && message.isNotEmpty) {
    return Get.showSnackbar(
      GetSnackBar(
        titleText: Text(
          title,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            height: 1.0,
            fontFamily: boldGoogleSansFont,
          ),
        ),
        messageText: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            height: 1.0,
            fontFamily: mediumGoogleSansFont,
          ),
          textAlign: TextAlign.left,
        ),
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        backgroundColor: Colors.green.withOpacity(0.80),
        icon: const Icon(Icons.task_alt_outlined, size: 30.0, color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 700),
      ),
    );
  }
}

// Snack bar for showing error message
errorSnackBar({String title = 'Failure', String? message}) {
  if (Get.isSnackbarOpen) {
    Get.back();
  }
  Get.log('\x1B[91m[$title] => $message\x1B[0m', isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.0,
          fontFamily: boldGoogleSansFont,
        ),
        textAlign: TextAlign.left,
      ),
      messageText: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontFamily: mediumGoogleSansFont,
        ),
        textAlign: TextAlign.left,
      ),
      snackPosition: SnackPosition.TOP,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.red.withOpacity(0.80),
      icon: const Icon(Icons.gpp_bad_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 700),
    ),
  );
}

// Show progress indicator
showProgressIndicator() {
  return EasyLoading.show(
    maskType: EasyLoadingMaskType.black,
    status: 'Loading',
    dismissOnTap: false,
  );
}

// Dismiss progress indicator
dismissProgressIndicator() {
  return EasyLoading.dismiss();
}

// Custom dialog
Future<dynamic> customSimpleDialog({
  required BuildContext context,
  Widget? title,
  Widget? description,
  String? noText,
  Function()? onNo,
  String? yesText,
  Function()? onYes,
  bool? preventToClose,
  bool? isButtonVisible = true,
  bool? barrierDismissible = false,
}) {
  return showDialog(
    barrierDismissible: barrierDismissible!,
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return preventToClose ?? true;
        },
        child: SimpleDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
          contentPadding: const EdgeInsets.only(top: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: title!,
          children: [
            SizedBox(
              width: 100.w,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: description!,
                    ),
                    height(20),
                    Visibility(
                      visible: isButtonVisible == true ? true : false,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: onNo ??
                                  () {
                                    Get.back();
                                  },
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: ColorsForApp.greyColor,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  noText ?? 'No',
                                  style: TextHelper.size15.copyWith(
                                    color: ColorsForApp.lightBlackColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.7,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: onYes,
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorsForApp.primaryColorBlue,
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  yesText ?? 'Yes',
                                  style: TextHelper.size15.copyWith(
                                    color: ColorsForApp.whiteColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.7,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

// Not fount text
Widget notFoundText({required String text, TextStyle? textStyle}) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.imagesNoDataFound,
          fit: BoxFit.contain,
          height: 25.h,
          width: 25.h,
        ),
        height(1.h),
        Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle ??
              TextHelper.size18.copyWith(
                color: ColorsForApp.greyColor,
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    ),
  );
}

Widget customKeyValueText({required String key, required String value, TextStyle? keyTextStyle, TextStyle? valueTextStyle}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key,
            style: keyTextStyle ??
                TextHelper.size13.copyWith(
                  fontFamily: mediumGoogleSansFont,
                  color: ColorsForApp.greyColor,
                ),
          ),
          width(5),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : '',
              textAlign: TextAlign.start,
              style: valueTextStyle ??
                  TextHelper.size13.copyWith(
                    color: ColorsForApp.lightBlackColor,
                  ),
            ),
          ),
        ],
      ),
      height(0.8.h),
    ],
  );
}

// Custom card for report
Widget customCard({required Widget child, Color? shadowColor, Color? borderColor, Color? cardColor, int? elevation}) {
  return Card(
    elevation: 2,
    color: cardColor ?? ColorsForApp.whiteColor,
    shadowColor: shadowColor,
    margin: const EdgeInsets.all(4),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: borderColor ?? ColorsForApp.grayScale500.withOpacity(0.5),
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: child,
  );
}

// Common message dialog
showCommonMessageDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 4,
        title: Text(
          title,
          style: TextHelper.size20.copyWith(
            fontFamily: mediumGoogleSansFont,
          ),
        ),
        content: Text(
          message,
          style: TextHelper.size14.copyWith(
            color: ColorsForApp.lightBlackColor.withOpacity(0.7),
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              Get.back();
            },
            splashColor: ColorsForApp.primaryColorBlue.withOpacity(0.1),
            highlightColor: ColorsForApp.primaryColorBlue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(100),
            child: Text(
              'Okay',
              style: TextHelper.size14.copyWith(
                fontFamily: mediumGoogleSansFont,
                color: ColorsForApp.primaryColorBlue,
              ),
            ),
          ),
        ],
      );
    },
  );
}

// Exit dailog
showExitDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 4,
        title: Text(
          'Exit',
          style: TextHelper.size20.copyWith(
            fontFamily: mediumGoogleSansFont,
          ),
        ),
        content: Text(
          'Are you sure you want to exit?',
          style: TextHelper.size14.copyWith(
            color: ColorsForApp.lightBlackColor.withOpacity(0.7),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  Get.back();
                },
                splashColor: ColorsForApp.primaryColorBlue.withOpacity(0.1),
                highlightColor: ColorsForApp.primaryColorBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
                child: Text(
                  'Cancel',
                  style: TextHelper.size14.copyWith(
                    fontFamily: mediumGoogleSansFont,
                    color: ColorsForApp.primaryColorBlue,
                  ),
                ),
              ),
              width(4.w),
              InkWell(
                onTap: () async {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                },
                splashColor: ColorsForApp.primaryColorBlue.withOpacity(0.1),
                highlightColor: ColorsForApp.primaryColorBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
                child: Text(
                  'Confirm',
                  style: TextHelper.size14.copyWith(
                    fontFamily: mediumGoogleSansFont,
                    color: ColorsForApp.primaryColorBlue,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
