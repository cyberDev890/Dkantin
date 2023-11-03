import 'package:dikantin/app/data/providers/services.dart';
import 'package:dikantin/app/modules/utils/formatDate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/riwayat_controller.dart';

class RiwayatView extends GetView<RiwayatController> {
  RiwayatView({Key? key}) : super(key: key);
  final RiwayatController riwayatController = Get.put(RiwayatController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Riwayat",
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await riwayatController.refreshData();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (text) {
                  riwayatController
                      .search(text); // Trigger the search as the user types
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      riwayatController.search(searchController.text);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (riwayatController.isLoading.value) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!, // Warna base untuk Shimmer
                    highlightColor:
                        Colors.grey[100]!, // Warna highlight untuk Shimmer
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.80,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  side: BorderSide(color: Colors.grey.shade200),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else if (riwayatController.searchResults.isEmpty) {
                  return Center(
                    child: Text(
                      "Data Not Found",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  );
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.80,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: riwayatController.searchResults.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final menuData = riwayatController.searchResults[index];
                      final harga = menuData.harga ?? 0;
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: Colors.grey.shade200),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 120,
                                  alignment: Alignment.topRight,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(Api.gambar +
                                          menuData.foto.toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          menuData.nama ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          'Kantin: ${menuData.idKantin ?? ''}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            harga.toRupiah(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                          SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: Ink(
                                              decoration: ShapeDecoration(
                                                color: Colors.blue,
                                                shape: CircleBorder(),
                                              ),
                                              child: IconButton.filled(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  // controller.increment();
                                                  // controller.update();
                                                },
                                                iconSize: 18,
                                                icon: const Icon(Icons.add),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
