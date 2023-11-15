import 'package:carbon_icons/carbon_icons.dart';
import 'package:dikantin/app/modules/order/views/order_view.dart';
import 'package:dikantin/app/modules/utils/formatDate.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../data/providers/services.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/keranjang_controller.dart';

class KeranjangView extends GetView<KeranjangController> {
  KeranjangView({Key? key}) : super(key: key);
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Keranjang',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            CarbonIcons.arrow_left,
            color: Colors.blue,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: Obx(
                () => homeController.cartList.isEmpty
                    ? Center(
                        child: Lottie.asset('assets/animation_lokccsws.json',
                            repeat: false))
                    : ListView.builder(
                        itemCount: homeController.cartList.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final menuData = homeController.cartList[index];
                          final harga = menuData.harga ?? 0;

                          final int priceAfterDiscount = homeController
                              .calculatePriceAfterDiscount(menuData);

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(13, 10, 13, 0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Sesuaikan dengan radius yang diinginkan
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          alignment: Alignment.topLeft,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(Api.gambar +
                                                    menuData.foto.toString()),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    menuData.nama ?? '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      homeController
                                                          .removeFromCart(
                                                              menuData);
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    priceAfterDiscount
                                                        .toRupiah(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                      harga ==
                                                              priceAfterDiscount
                                                          ? ''
                                                          : harga.toRupiah(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.red,
                                                      )),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Obx(
                                                () => Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color: Color(
                                                                    0xFFD0E0FE),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: InkWell(
                                                              onTap: () {
                                                                homeController
                                                                    .subtractQuantity(
                                                                        menuData
                                                                            .idMenu!);
                                                              },
                                                              child: Icon(
                                                                color:
                                                                    Colors.blue,
                                                                Icons.remove,
                                                                size: 20.0,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                              '${homeController.itemQuantities[menuData.idMenu] ?? 1}', // Tampilkan kuantitas dari map

                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 14,
                                                              )),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.blue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: InkWell(
                                                              onTap: () {
                                                                homeController
                                                                    .addQuantity(
                                                                        menuData
                                                                            .idMenu!);
                                                              },
                                                              child: Icon(
                                                                color: Colors
                                                                    .white,
                                                                Icons.add,
                                                                size: 20.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      homeController
                                                          .calculateSubtotal(
                                                              menuData.idMenu!)
                                                          .toRupiah(),
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),
          Divider(
            height: 2,
            color: Color(0xFFEAEAEA),
            thickness: 2,
            indent: 40, //spacing at the start of divider
            endIndent: 40,
          ),
          // height: 100.0,
          // decoration: const BoxDecoration(
          //   color: Colors.orange,
          // ),
          Obx(
            () => Container(
              padding:
                  EdgeInsets.only(bottom: 10, right: 20, left: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Jumlah : ${homeController.count}",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(homeController.totalPrice.toRupiah(),
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Get.to(OrderView(),
                              arguments: homeController.cartList);
                        },
                        child: Text("Pesan Sekarang",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
