import 'package:get/get.dart';

import '../models/customer_model.dart';

class CustomerProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Customer.fromJson(map);
      if (map is List)
        return map.map((item) => Customer.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Customer?> getCustomer(int id) async {
    final response = await get('customer/$id');
    return response.body;
  }

  Future<Response<Customer>> postCustomer(Customer customer) async =>
      await post('customer', customer);
  Future<Response> deleteCustomer(int id) async => await delete('customer/$id');
}
