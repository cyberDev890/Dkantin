import 'package:carbon_icons/carbon_icons.dart';
import 'package:dikantin/app/modules/utils/formatDate.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../data/models/search_model.dart';
import '../../../data/providers/services.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartList = Get.arguments as List<Datasearch>;
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Order',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.16,
              // decoration: BoxDecoration(
              //     border: Border.all(
              //   width: 1.0,
              //   color: Colors.grey[900]!,
              // )),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delivery Address",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Jl. Mastrip,Sumbersari",
                        style: GoogleFonts.poppins(fontSize: 16)),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Rw 03, Rt 01,",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    FittedBox(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.0,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(4),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              CarbonIcons.request_quote,
                              size: 14.0,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Edit Address"),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                // //ini container list view
                // decoration: BoxDecoration(
                //     border: Border.all(
                //   width: 1.0,
                //   color: Colors.grey[900]!,
                // )),
                child: Obx(
                  () => cartList.isEmpty
                      ? Center(
                          child: Lottie.asset('assets/animation_lokccsws.json',
                              repeat: false))
                      : ListView.builder(
                          itemCount: cartList.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final menuData = cartList[index];
                            final harga = menuData.harga ?? 0;
                            final int priceAfterDiscount = homeController
                                .calculatePriceAfterDiscount(menuData);
                            final int quantity = homeController
                                    .itemQuantities[menuData.idMenu!] ??
                                1;

                            return Card(
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(
                              //       10.0), // Sesuaikan dengan radius yang diinginkan
                              // ),
                              elevation: 2,
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
                                          CrossAxisAlignment.start,
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
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    menuData.nama ?? '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          priceAfterDiscount
                                                              .toRupiah(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                        Text(
                                                          "* ${quantity.toString()}",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    homeController
                                                        .calculateSubtotal(
                                                            menuData.idMenu!)
                                                        .toRupiah(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
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
                            );
                          },
                        ),
                ),
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1.0,
              color: Colors.grey,
            ),
            Container(
              padding: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height * 0.16,
              child: Obx(
                () => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Payment',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          homeController.totalPrice.toRupiah(),
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // decoration: BoxDecoration(
                          //     border: Border.all(
                          //   width: 1.0,
                          //   color: Colors.grey[900]!,
                          // )),
                          child: Row(
                            children: [
                              Icon(
                                CarbonIcons.money,
                                size: 24.0,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FittedBox(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFD0E0FE),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'Cash',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Rp. 50.000',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.bottomSheet(Container(
                              height: MediaQuery.of(context).size.height * 0.30,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      height: 60,
                                      decoration: BoxDecoration(
                                        // color: Colors.orange,
                                        border: Border.all(
                                          width: 1.5,
                                          color: Colors.blue,
                                        ),

                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                  color: Colors.blue,
                                                ),
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          const Icon(
                                            CarbonIcons.money,
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'Cash',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      height: 60,
                                      decoration: BoxDecoration(
                                        // color: Colors.orange,
                                        border: Border.all(
                                          width: 1.5,
                                          color: Colors.blue,
                                        ),

                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                  color: Colors.blue,
                                                ),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          const Icon(
                                            CarbonIcons.wallet,
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'Polije Pay',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFD0E0FE),
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              CarbonIcons.overflow_menu_horizontal,
                              size: 24.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2579FD),
                        fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.70,
                            50), // Anda dapat menyesuaikan nilai ini untuk mendapatkan lebar yang diinginkan

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (cartList.isNotEmpty) {
                          homeController.submitOrder();
                        } else {
                          Get.snackbar('Error', 'Your cart is empty');
                        }
                      },
                      child: Text(
                        'Pesan',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
