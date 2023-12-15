// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dikantin/app/data/providers/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../pesananKurir/controllers/pesananKurir_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileKurirView extends GetView<ProfileKurirController> {
  ProfileKurirView({Key? key}) : super(key: key);
  final ProfileKurirController profileKurirController =
      Get.put(ProfileKurirController());
  final PesananKurirController pesananKurirController =
      Get.find<PesananKurirController>();

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    final myAppbar = AppBar(
      centerTitle: true,
      title: Text(
        "Edit Profile",
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            width: 40.0,
            height: 40.0,
            child: Center(
              // Atau bisa juga menggunakan Align
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  size: 20.0,
                  color: Colors.black,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Lottie.asset(
                              "assets/Animation_logout.json", // Ganti dengan nama file Lottie Anda
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                "Anda Akan Logout ?",
                                style: TextStyle(
                                  color: Color(0xff3CA2D9),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                child: Text('Ya'),
                                onPressed: () {
                                  print("logout clicked");
                                  profileKurirController.logout();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                child: Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );

    final x = mediaHeight -
        myAppbar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: myAppbar,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Align(
                  alignment: AlignmentDirectional(0.00, -1.00),
                  child: // Generated code for this Column Widget...
                      Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10, left: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                                alignment: AlignmentDirectional(1, 0.5),
                                children: [
                                  Obx(
                                    () => ClipOval(
                                      child: profileKurirController.profileKurir
                                                  .value.data?.foto !=
                                              null
                                          ? Image.network(
                                              Api.gambar +
                                                  profileKurirController
                                                      .profileKurir
                                                      .value
                                                      .data!
                                                      .foto!
                                                      .toString(),
                                              width:
                                                  90.0, // Sesuaikan lebar gambar
                                              height:
                                                  90.0, // Sesuaikan tinggi gambar
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              "assets/logo_dikantin.png", // Ganti dengan path gambar default Anda
                                              width:
                                                  90.0, // Sesuaikan lebar gambar
                                              height:
                                                  90.0, // Sesuaikan tinggi gambar
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  Container(
                                    width: 30.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size: 16.0,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        // Panggil fungsi pickImage saat ikon edit ditekan
                                        profileKurirController.pickImage();
                                      },
                                    ),
                                  ),
                                ]),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 4, 0, 4),
                                child: Obx(
                                  () => Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        profileKurirController.profileKurir
                                                .value.data?.nama ??
                                            '',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              textScaleFactor <= 1.15 ? 14 : 12,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                        child: Text(
                                          profileKurirController.profileKurir
                                                  .value.data?.email ??
                                              '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: textScaleFactor <= 1.15
                                                ? 12
                                                : 12,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                        child: Text(
                                          profileKurirController.profileKurir
                                                  .value.data?.telepon ??
                                              '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: textScaleFactor <= 1.15
                                                ? 14
                                                : 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Obx(() => Switch(
                                  value:
                                      profileKurirController.isSwitchOn.value,
                                  onChanged: (value) {
                                    profileKurirController.toggleSwitch(value);
                                  },
                                )),
                          ],
                        ),
                      ),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Colors.black38,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 12),
                                  child: Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[300],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 12, 12, 12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.receipt_rounded,
                                            color: Colors.white,
                                            size: 44,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 8, 0, 4),
                                            child: Obx(
                                              () => Text(
                                                pesananKurirController
                                                    .orderUntukDikirim.length
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      textScaleFactor <= 1.15
                                                          ? 14
                                                          : 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Untuk Dikirim',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: textScaleFactor <= 1.15
                                                  ? 14
                                                  : 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Expanded(
                              child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 12),
                                  child: Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[300],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 12, 12, 12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Icon(
                                            Icons.ssid_chart_rounded,
                                            color: Colors.white,
                                            size: 44,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 8, 0, 4),
                                            child: Obx(
                                              () => Text(
                                                pesananKurirController
                                                    .orderKonfirmasi.length
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      textScaleFactor <= 1.15
                                                          ? 14
                                                          : 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Konfirmasi',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: textScaleFactor <= 1.15
                                                  ? 14
                                                  : 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
