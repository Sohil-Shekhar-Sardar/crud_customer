import 'package:crud_customer_assignment/widgets/constant_widgets.dart';
import 'package:get/get.dart';

import '../api/api_service.dart';
import '../models/customer_model.dart';

class CustomerController extends GetxController {
  RxList<Customer> customersList = <Customer>[].obs;
  final ApiService _apiService = ApiService();
  RxString city = ''.obs;
  RxString state = ''.obs;

  // add customer
  void addCustomer(Customer customer) {
    customersList.add(customer);
  }

  // update customer
  void updateCustomer(int index, Customer customer) {
    customersList[index] = customer;
  }

  // remove customer
  void removeCustomer(int index) {
    customersList.removeAt(index);
    successSnackBar(message: 'Successfully deleted!');
  }

  // verify pan api
  Future<String> verifyPan(String panNumber) async {
    try {
      final result = await _apiService.verifyPan(panNumber);
      if (result['isValid']) {
        return result['fullName'];
      } else {
        throw Exception('Invalid PAN');
      }
    } catch (e) {
      throw Exception('Failed to verify PAN');
    }
  }

  // verify post code
  Future<Map<String, dynamic>> getPostcodeDetails(String postcode) async {
    try {
      final result = await _apiService.getPostcodeDetails(postcode);
      print(result);
      return result;
    } catch (e) {
      throw Exception('Failed to get postcode details');
    }
  }
}
