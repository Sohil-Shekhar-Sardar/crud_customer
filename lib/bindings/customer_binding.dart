import 'package:get/get.dart';

import '../controllers/customer_controller.dart';

class CustomerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerController>(() => CustomerController());
  }
}
