import 'package:get/get.dart';

import '../rekap_pendapatanharian_model.dart';

class RekapPendapatanharianProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>)
        return RekapPendapatanharian.fromJson(map);
      if (map is List)
        return map.map((item) => RekapPendapatanharian.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<RekapPendapatanharian?> getRekapPendapatanharian(int id) async {
    final response = await get('rekappendapatanharian/$id');
    return response.body;
  }

  Future<Response<RekapPendapatanharian>> postRekapPendapatanharian(
          RekapPendapatanharian rekappendapatanharian) async =>
      await post('rekappendapatanharian', rekappendapatanharian);
  Future<Response> deleteRekapPendapatanharian(int id) async =>
      await delete('rekappendapatanharian/$id');
}
