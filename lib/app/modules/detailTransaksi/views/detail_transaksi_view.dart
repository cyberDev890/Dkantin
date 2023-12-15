import 'package:carbon_icons/carbon_icons.dart';
import 'package:dikantin/app/modules/utils/formatDate.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../data/providers/services.dart';
import '../../pesanan/controllers/pesanan_controller.dart';
import '../controllers/detail_transaksi_controller.dart';

// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class DetailTransaksiView extends GetView<DetailTransaksiController> {
  const DetailTransaksiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    final orderId = Get.arguments as String?;
    final orderData =
        Get.find<PesananController>().findOrderById(orderId ?? '');

    if (orderData == null) {
      return const Scaffold(
        body: Center(
          child: Text('Pesanan tidak ditemukan'),
        ),
      );
    }

    final transaksi = orderData.transaksi;
    final totalBayar = transaksi!.totalBayar ?? 0;
    final detailTransaksiList = transaksi?.detailTransaksi ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Pesanan Saya',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
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
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                CarbonIcons.arrow_left,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width,
                // color: Colors.blue,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Sesuaikan dengan radius yang diinginkan
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detail Pesanan',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            Text(
                              'Nomor Pesanan :',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 15 : 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '#${transaksi!.kodeTr}',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 14 : 11,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Waktu Pemesanan :',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 15 : 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              transaksi.tanggal.toString(),
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 14 : 11,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.38,
                          // decoration: BoxDecoration(
                          //   border: Border.all(
                          //     width: 1.0,
                          //     color: Colors.grey[900]!,
                          //   ),
                          // ),
                          child: ListView.builder(
                            itemCount: detailTransaksiList.length,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final detailTransaksi =
                                  detailTransaksiList[index];
                              final menuData = detailTransaksi.menu;
                              final harga = menuData?.harga ?? 0;
                              return Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  image: NetworkImage(Api
                                                          .gambar +
                                                      detailTransaksi.menu!.foto
                                                          .toString()),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  detailTransaksi.menu!.nama
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          textScaleFactor <=
                                                                  1.15
                                                              ? 15
                                                              : 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Kantin :${detailTransaksi.menu!.idKantin.toString()}",
                                                      style: TextStyle(
                                                          fontSize:
                                                              textScaleFactor <=
                                                                      1.15
                                                                  ? 15
                                                                  : 12,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      detailTransaksi
                                                              .statusKonfirm
                                                              .toString()
                                                              .contains("null")
                                                          ? ""
                                                          : detailTransaksi
                                                              .statusKonfirm
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              textScaleFactor <=
                                                                      1.15
                                                                  ? 15
                                                                  : 12,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        harga.toRupiah(),
                                                        style: TextStyle(
                                                            fontSize:
                                                                textScaleFactor <=
                                                                        1.15
                                                                    ? 15
                                                                    : 12,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        "* ${detailTransaksi.qTY.toString()}",
                                                        style: TextStyle(
                                                            fontSize:
                                                                textScaleFactor <=
                                                                        1.15
                                                                    ? 15
                                                                    : 12,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ]),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          height: MediaQuery.of(context).size.height * 0.09,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              QrImageView(
                                data: transaksi!.kodeTr.toString(),
                                version: QrVersions.auto,
                                size: 100,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Note :',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize:
                                            textScaleFactor <= 1.15 ? 13 : 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Tunjukkan kode barcode di sebelah \nkepada kurir jika makanan sampai ',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize:
                                            textScaleFactor <= 1.15 ? 10 : 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.21,
                width: MediaQuery.of(context).size.width,
                // color: Colors.blue,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Sesuaikan dengan radius yang diinginkan
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi Pembayaran',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: textScaleFactor <= 1.15 ? 14 : 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Metode Pembayaran  :',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 12 : 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              transaksi!.modelPembayaran.toString(),
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 12 : 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total :',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 12 : 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              totalBayar.toRupiah(),
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 12 : 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Diskon :',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 12 : 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              'Rp 0',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 12 : 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Kembalian :',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 12 : 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              'Rp 0',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 12 : 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total bayar :',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 12 : 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              totalBayar.toRupiah(),
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 12 : 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
