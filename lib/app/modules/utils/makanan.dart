import 'package:dikantin/app/modules/home/controllers/home_controller.dart';
import 'package:dikantin/app/modules/utils/formatDate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dikantin/app/modules/home/controllers/makanan_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/providers/services.dart';

class Makanan extends StatefulWidget {
  @override
  State<Makanan> createState() => _MakananState();
}

class _MakananState extends State<Makanan> {
  @override
  @override
  Widget build(BuildContext context) {
    final MakananController controller = Get.put(MakananController());
    final HomeController homeController = Get.find<HomeController>();
    return RefreshIndicator(
      onRefresh: () async {
        await controller.refreshData();
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF969696), width: 1.5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(14.0),
                    )),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        color: Color(0xFF969696),
                      ),
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: controller.searchController,
                      initialValue: null,
                      onChanged: (text) {
                        controller.search(
                            text); // Trigger the search as the user types
                      },
                      decoration: InputDecoration.collapsed(
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: "Mau makan apa hari ini ganteng ?",
                        hintStyle: TextStyle(
                            color: Colors.grey[500], fontFamily: 'Mulish'),
                        hoverColor: Colors.transparent,
                      ),
                      onFieldSubmitted: (value) {
                        // Get.to(() => searchBuku(keywords: search.toString()));
                      },
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.020,
              ),
              Container(
                child: Obx(() {
                  if (controller.isLoading.value) {
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
                                    side:
                                        BorderSide(color: Colors.grey.shade200),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (controller.searchResults.isEmpty) {
                    return Center(
                        child: Lottie.asset('assets/animation_lokcsauz.json',
                            repeat: false));
                  } else {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.80,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: controller.searchResults.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final menuData = controller.searchResults[index];
                        final harga = menuData.harga ?? 0;
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            menuData.nama ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
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
                                            Obx(() => homeController.cartList
                                                    .contains(menuData)
                                                ? SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: Ink(
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: Colors.blue,
                                                        shape: CircleBorder(),
                                                      ),
                                                      child: IconButton.filled(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        onPressed: () {
                                                          homeController
                                                              .removeFromCart(
                                                                  menuData);
                                                        },
                                                        iconSize: 18,
                                                        icon: const Icon(
                                                            color: Colors.white,
                                                            Icons.remove),
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: Ink(
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: Colors.blue,
                                                        shape: CircleBorder(),
                                                      ),
                                                      child: IconButton.filled(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        onPressed: () {
                                                          homeController
                                                              .addToCart(
                                                                  menuData);
                                                        },
                                                        iconSize: 18,
                                                        icon: const Icon(
                                                            color: Colors.white,
                                                            Icons.add),
                                                      ),
                                                    ),
                                                  ))
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
      ),
    );
  }
}
