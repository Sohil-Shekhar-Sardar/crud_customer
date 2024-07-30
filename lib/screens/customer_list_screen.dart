import 'package:crud_customer_assignment/utils/text_styles.dart';
import 'package:crud_customer_assignment/widgets/constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/customer_controller.dart';
import '../controllers/network_controller.dart';
import 'customer_form_screen.dart';

class CustomerListScreen extends StatefulWidget {
  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final NetworkController networkController = Get.put(NetworkController(), permanent: true);
  CustomerController customerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Customer List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Get.to(() => CustomerFormScreen());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Obx(() {
        return customerController.customersList.isEmpty
            ? notFoundText(text: 'No customer data found')
            : ListView.builder(
                itemCount: customerController.customersList.length,
                padding: EdgeInsets.only(top: 15).add(EdgeInsets.symmetric(horizontal: 10)),
                itemBuilder: (context, index) {
                  final customer = customerController.customersList[index];
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(customer.fullName),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customerInfo(customer.email),
                          customerInfo(customer.pan),
                          customerInfo(customer.mobileNumber),
                          customerInfo(customer.addresses.first.postcode),
                          customerInfo(customer.addresses.first.city),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Get.to(CustomerFormScreen(
                                customer: customer,
                                index: index,
                              ));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              customerController.removeCustomer(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      }),
    );
  }

  Widget customerInfo(String text) {
    return Text(
      text,
      style: TextHelper.size15,
    );
  }
}
