import 'package:crud_customer_assignment/bindings/customer_binding.dart';
import 'package:crud_customer_assignment/screens/customer_list_screen.dart';
import 'package:crud_customer_assignment/widgets/no_internet_connection_screen.dart';
import 'package:get/get.dart';

import '../bindings/network_binding.dart';
import '../routes/routes.dart';

const Transition transition = Transition.fadeIn;

class AppPages {
  static const INITIAL_ROUTE = Routes.CUSTOMER_LIST_SCREEN;

  static final routes = [
    GetPage(
      name: Routes.CUSTOMER_LIST_SCREEN,
      page: () => CustomerListScreen(),
      binding: CustomerBinding(),
      transition: transition,
    ),
    GetPage(
      name: Routes.CUSTOMER_LIST_SCREEN,
      page: () => CustomerListScreen(),
      binding: CustomerBinding(),
      transition: transition,
    ),
    GetPage(
      name: Routes.NO_INTERNET_CONNECTION_SCREEN,
      page: () => NoInternetConnectionScreen(),
      binding: NetworkBinding(),
      transition: transition,
    ),
  ];
}
