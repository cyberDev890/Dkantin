import 'package:carbon_icons/carbon_icons.dart';
import 'package:dikantin/app/modules/profile/views/profile_view.dart';
import 'package:dikantin/app/modules/utils/formatDate.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../data/models/search_model.dart';
import '../../../data/providers/services.dart';
import '../../home/controllers/home_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final cartList = Get.arguments as List<Datasearch>;
    final HomeController homeController = Get.find<HomeController>();
    final ProfileController profileController = Get.find<ProfileController>();
    final OrderController orderController = Get.put(OrderController());
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
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Icon(
                CarbonIcons.arrow_left,
                color: Colors.white,
              ),
            ),
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
                    Text(profileController.customer.value.data?.alamat ?? '',
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
                    InkWell(
                      onTap: () {
                        Get.bottomSheet(Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Obx(
                              () => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                    controller:
                                        profileController.addressController
                                          ..text = profileController.customer
                                                  .value.data?.alamat ??
                                              '',
                                    maxLines:
                                        null, // Memungkinkan input lebih dari satu baris
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[
                                          200], // Atur warna latar belakang
                                      hintStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize:
                                              12), // Atur warna teks hintText
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 30.0,
                                          horizontal:
                                              15.0), // Sesuaikan nilai vertical
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Obx(() =>
                                      Text(controller.myPosition.toString())),
                                  Obx(() =>
                                      Text(controller.addressMessage.value)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF2579FD),
                                          fixedSize: Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              10), // Anda dapat menyesuaikan nilai ini untuk mendapatkan lebar yang diinginkan

                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () async {
                                          await orderController
                                              .determinePosition();
                                          orderController
                                                  .locationMessage.value =
                                              "${orderController.myPosition.value.latitude} ${orderController.myPosition.value.longitude}";
                                          orderController.getAddressFromLatLong(
                                              orderController.myPosition.value);
                                        },
                                        child: Text(
                                          'Maps',
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF2579FD),
                                          fixedSize: Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              10), // Anda dapat menyesuaikan nilai ini untuk mendapatkan lebar yang diinginkan

                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          'Simpan',
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
                                ],
                              ),
                            ),
                          ),
                        ));
                      },
                      child: FittedBox(
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
                                homeController.isCashSelected.value
                                    ? CarbonIcons.money
                                    : CarbonIcons.wallet,
                                size: 24.0,
                                color: homeController.isCashSelected.value
                                    ? Colors.blue
                                    : Colors.blue,
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
                                    homeController.isCashSelected.value
                                        ? ' Cash '
                                        : ' Polije Pay ',
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
                                    InkWell(
                                      onTap: () {
                                        // Ubah nilai variabel untuk menandai pembayaran cash
                                        homeController.isCashSelected.value =
                                            true;
                                        homeController
                                            .isPolijePaySelected.value = false;
                                        Get.back();
                                      },
                                      child: Container(
                                        //
                                        padding: EdgeInsets.all(10),
                                        height: 60,
                                        decoration: BoxDecoration(
                                          // color: Colors.orange,
                                          border: Border.all(
                                            width: 1.5,
                                            color: homeController
                                                    .isCashSelected.value
                                                ? Colors.blue
                                                : Colors.grey,
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
                                              // ini container dot
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 2,
                                                    color: homeController
                                                            .isCashSelected
                                                            .value
                                                        ? Colors.blue
                                                        : Colors.grey,
                                                  ),
                                                  color: homeController
                                                          .isCashSelected.value
                                                      ? Colors.blue
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
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
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Ubah nilai variabel untuk menandai pembayaran Polije Pay
                                        homeController.isCashSelected.value =
                                            false;
                                        homeController
                                            .isPolijePaySelected.value = true;
                                        Get.back();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        height: 60,
                                        decoration: BoxDecoration(
                                          // color: Colors.orange,
                                          border: Border.all(
                                            width: 1.5,
                                            color: homeController
                                                    .isPolijePaySelected.value
                                                ? Colors.blue
                                                : Colors.grey,
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
                                                    color: homeController
                                                            .isPolijePaySelected
                                                            .value
                                                        ? Colors.blue
                                                        : Colors.grey,
                                                  ),
                                                  color: homeController
                                                          .isPolijePaySelected
                                                          .value
                                                      ? Colors.blue
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
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
                        if (homeController.cartList.isNotEmpty) {
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
