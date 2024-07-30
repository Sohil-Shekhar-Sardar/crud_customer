import 'package:crud_customer_assignment/utils/app_colors.dart';
import 'package:crud_customer_assignment/widgets/button.dart';
import 'package:crud_customer_assignment/widgets/constant_widgets.dart';
import 'package:crud_customer_assignment/widgets/text_field_with_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/customer_controller.dart';
import '../models/customer_model.dart';
import '../routes/routes.dart';

class CustomerFormScreen extends StatefulWidget {
  final Customer? customer;
  final int? index;

  CustomerFormScreen({this.customer, this.index});

  @override
  CustomerFormScreenState createState() => CustomerFormScreenState();
}

class CustomerFormScreenState extends State<CustomerFormScreen> {
  CustomerController customerController = Get.find();
  final formKey = GlobalKey<FormState>();
  final panController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final postcodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  RxBool isPanVerified = false.obs;

  @override
  void initState() {
    super.initState();

    if (widget.customer != null) {
      final customer = widget.customer!;
      panController.text = customer.pan;
      fullNameController.text = customer.fullName;
      emailController.text = customer.email;
      mobileController.text = customer.mobileNumber;
      addressLine1Controller.text = customer.addresses[0].addressLine1;
      addressLine2Controller.text = customer.addresses[0].addressLine2 ?? '';
      postcodeController.text = customer.addresses[0].postcode;
      customerController.city.value = customer.addresses[0].city;
      customerController.state.value = customer.addresses[0].state;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer == null ? 'Add Customer' : 'Edit Customer'),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Obx(
            () => Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextFieldWithTitle(
                      controller: panController,
                      title: 'Pan Number',
                      hintText: 'Enter pan number',
                      isCompulsory: true,
                      textCapitalization: TextCapitalization.characters,
                      suffixIcon: Icon(
                        Icons.done,
                        color: isPanVerified.value ? ColorsForApp.successColor : Colors.transparent,
                      ),
                      onChange: (value) async {
                        if (value!.isNotEmpty && value.trim().length == 10) {
                          await verifyPan();
                        } else {
                          isPanVerified.value = false;
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter PAN';
                        }
                        if (!RegExp(r'[A-Z]{5}[0-9]{4}[A-Z]{1}').hasMatch(value)) {
                          return 'Invalid PAN format';
                        }
                        return null;
                      },
                    ),
                    CustomTextFieldWithTitle(
                      title: 'Full name',
                      hintText: 'Enter full name',
                      controller: fullNameController,
                      isCompulsory: true,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter full name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextFieldWithTitle(
                      title: 'Email',
                      hintText: 'Enter email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      isCompulsory: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                    ),
                    CustomTextFieldWithTitle(
                      controller: mobileController,
                      title: 'Mobile Number',
                      hintText: 'Enter mobile number',
                      keyboardType: TextInputType.phone,
                      isCompulsory: true,
                      prefixIcon: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 14.0).add(EdgeInsets.only(left: 10.0)),
                          child: Text(
                            '+91',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter mobile number';
                        }
                        if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Invalid mobile number';
                        }
                        return null;
                      },
                    ),
                    CustomTextFieldWithTitle(
                      controller: addressLine1Controller,
                      title: 'Address Line 1',
                      hintText: 'Enter address',
                      keyboardType: TextInputType.streetAddress,
                      isCompulsory: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address line 1';
                        }
                        return null;
                      },
                    ),
                    CustomTextFieldWithTitle(
                      controller: addressLine2Controller,
                      keyboardType: TextInputType.streetAddress,
                      title: 'Address Line 2',
                      hintText: 'Enter address',
                      isCompulsory: false,
                    ),
                    CustomTextFieldWithTitle(
                      controller: postcodeController,
                      title: 'Postcode',
                      keyboardType: TextInputType.number,
                      hintText: 'Enter postcode',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter postcode';
                        }
                        if (value.length != 6 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Invalid postcode';
                        }
                        return null;
                      },
                      isCompulsory: true,
                      onChange: (value) async {
                        if (value!.isNotEmpty && value.trim().length == 6) {
                          await getPostcodeDetails();
                        }
                      },
                    ),
                    CustomTextFieldWithTitle(
                      title: 'City',
                      controller: cityController,
                      hintText: 'Enter city',
                      isCompulsory: true,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter city name';
                        } else if (value.isAlphabetOnly) {
                          return null;
                        } else {
                          return 'Please enter valid city name';
                        }
                      },
                    ),
                    CustomTextFieldWithTitle(
                      title: 'State',
                      hintText: 'Enter state',
                      controller: stateController,
                      isCompulsory: true,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter state name';
                        } else if (value.isAlphabetOnly) {
                          return null;
                        } else {
                          return 'Please enter valid state name';
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    CommonButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final newCustomer = Customer(
                            pan: panController.text,
                            fullName: fullNameController.text,
                            email: emailController.text,
                            mobileNumber: mobileController.text,
                            addresses: [
                              Address(
                                addressLine1: addressLine1Controller.text,
                                addressLine2: addressLine2Controller.text,
                                postcode: postcodeController.text,
                                city: cityController.text,
                                state: stateController.text,
                              ),
                            ],
                          );
                          if (widget.index == null) {
                            // new customer
                            customerController.addCustomer(newCustomer);
                            successSnackBar(message: 'Successfully added!');
                          } else {
                            // Update existing customer
                            customerController.updateCustomer(widget.index!, newCustomer);
                            successSnackBar(message: 'Successfully updated!');
                          }
                          Get.offNamed(Routes.CUSTOMER_LIST_SCREEN);
                        }
                      },
                      label: widget.customer == null ? 'Add Customer' : 'Update Customer',
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  //verify pan api call
  Future<void> verifyPan() async {
    try {
      showProgressIndicator();
      final fullName = await customerController.verifyPan(panController.text);
      if (fullName.isNotEmpty) {
        fullNameController.text = fullName;
        isPanVerified.value = true;
        dismissProgressIndicator();
      } else {
        dismissProgressIndicator();
        errorSnackBar(message: 'Something went wrong! Please enter another pan card number.');
      }
    } catch (e) {
      dismissProgressIndicator();
      // Handle error
      errorSnackBar(message: 'Invalid PAN');
    }
  }

  //post code api call
  Future<void> getPostcodeDetails() async {
    try {
      showProgressIndicator();
      final details = await customerController.getPostcodeDetails(postcodeController.text);
      if (details.isNotEmpty) {
        cityController.text = details['city'][0]['name'];
        stateController.text = details['state'][0]['name'];
        dismissProgressIndicator();
      } else {
        dismissProgressIndicator();
        errorSnackBar(message: 'Something went wrong! Please enter another post code.');
      }
    } catch (e) {
      dismissProgressIndicator();
      // Handle error
      errorSnackBar(message: 'Invalid Postcode');
    }
  }
}
