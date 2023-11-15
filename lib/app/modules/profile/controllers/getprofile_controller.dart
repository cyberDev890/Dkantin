import 'dart:convert';

import 'package:dikantin/app/data/models/customer_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetprofileController extends GetxController {
  //TODO: Implement GetprofileController
  var customer = Customer().obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  Future<void> fetchData() async {
    try {
      // Replace 'your_api_url' with the actual API endpoint
      final response = await http.get(Uri.parse('your_api_url'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Assuming your API response is a JSON object with a 'customer' key
        final customerData = data['customer'];

        if (customerData != null) {
          final Customer newCustomer = Customer.fromJson(customerData);
          customer.value = newCustomer;
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
