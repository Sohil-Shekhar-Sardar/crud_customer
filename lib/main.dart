import 'package:crud_customer_assignment/bindings/customer_binding.dart';
import 'package:crud_customer_assignment/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          title: 'CRUD CUSTOMER APP',
          getPages: AppPages.routes,
          initialRoute: AppPages.INITIAL_ROUTE,
          initialBinding: CustomerBinding(),
          theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            dividerColor: Colors.transparent,
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
