// ignore_for_file: unused_local_variable

import 'package:carbon_icons/carbon_icons.dart';
import 'package:dikantin/app/data/models/keranjang_model.dart';
import 'package:dikantin/app/modules/order/views/order_view.dart';
import 'package:dikantin/app/modules/utils/formatDate.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../controllers/keranjang_controller.dart';

class KeranjangView extends GetView<KeranjangController> {
  KeranjangView({Key? key}) : super(key: key);
  List<Map<String, dynamic>> items = [
    {
      "image": "assets/basreng.jpg",
      "name": "Basreng",
      "kantin": "Kantin 1",
      "price": "Rp. 6.000",
      "Terjual": "20 porsi"
    },
    {
      "image": "assets/sate.jpg",
      "name": "Sate Madura",
      "kantin": "Kantin 1",
      "price": "Rp. 15.000",
      "Terjual": "15 porsi"
    },
    {
      "image": "assets/nasi.jpeg",
      "name": "Nasi Liwet ",
      "kantin": "Kantin 1",
      "price": "Rp. 12.000",
      "Terjual": "100 porsi"
    },
    {
      "image": "assets/nasi.jpeg",
      "name": "Lalapan jamur",
      "kantin": "Kantin 1",
      "price": "Rp. 12.000",
      "Terjual": "100 porsi"
    },
    {
      "image": "assets/nasi.jpeg",
      "name": "Lalapan jamur",
      "kantin": "Kantin 1",
      "price": "Rp. 12.000",
      "Terjual": "100 porsi"
    },
    {
      "image": "assets/nasi.jpeg",
      "name": "Lalapan jamur",
      "kantin": "Kantin 1",
      "price": "Rp. 12.000",
      "Terjual": "100 porsi"
    },
    {
      "image": "assets/nasi.jpeg",
      "name": "Lalapan jamur",
      "kantin": "Kantin 1",
      "price": "Rp. 12.000",
      "Terjual": "100 porsi"
    },
    {
      "image": "assets/nasi.jpeg",
      "name": "Lalapan jamur",
      "kantin": "Kantin 1",
      "price": "Rp. 12.000",
      "Terjual": "100 porsi"
    },
    {
      "image": "assets/nasi.jpeg",
      "name": "Lalapan jamur",
      "kantin": "Kantin 1",
      "price": "Rp. 12.000",
      "Terjual": "100 porsi"
    },
    {
      "image": "assets/nasi.jpeg",
      "name": "Lalapan jamur",
      "kantin": "Kantin 1",
      "price": "Rp. 12.000",
      "Terjual": "100 porsi"
    },
  ];
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
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          items[index]["image"],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Nasi Goreng Mawut",
                                              maxLines: 2,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14)),
                                          InkWell(
                                            onTap: () {},
                                            child: const Icon(
                                              Icons.delete,
                                              size: 24.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Rp. 100.000",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Rp. 100.000",
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.red,
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
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
                                                      color: Color(0xFFD0E0FE),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Icon(
                                                      color: Colors.blue,
                                                      Icons.remove,
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                ),
                                                Text("1",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                    )),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Icon(
                                                      color: Colors.white,
                                                      Icons.add,
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Rp. 300.000",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ],
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
                          Get.to(OrderView());
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
