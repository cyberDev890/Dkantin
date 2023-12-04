import 'package:dikantin/app/data/providers/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/profile_controller.dart';

class ProfileKurirView extends GetView<ProfileKurirController> {
  ProfileKurirView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileKurirController profileKurirController =
        Get.put(ProfileKurirController());
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    final bottomNavBarHeight = MediaQuery.of(context).padding.bottom;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: 120.0,
                height: 120.0,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 60.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            profileKurirController.customer.value.data?.foto !=
                                    null
                                ? NetworkImage(
                                    Api.gambar +
                                        profileKurirController
                                            .customer.value.data!.foto!
                                            .toString(),
                                  ) as ImageProvider<Object>
                                : AssetImage("assets/logo_dikantin.png"),
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
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // Panggil fungsi pickImage saat ikon edit ditekan
                          profileKurirController.pickImage();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, top: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      "FULL NAME",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    const Icon(
                      Icons.edit,
                      size: 24.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 25, top: 10),
              child: Obx(
                () => TextField(
                  controller: profileKurirController.fullNameController
                    ..text =
                        profileKurirController.customer.value.data?.nama ?? '',
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, top: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    const Icon(
                      Icons.edit,
                      size: 24.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 25, top: 10),
              child: Obx(
                () => TextField(
                  controller: profileKurirController.emailController
                    ..text =
                        profileKurirController.customer.value.data?.email ?? '',
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Menentukan radius untuk membuat bentuk rounded
                      borderSide: BorderSide(
                          color:
                              Colors.black), // Menentukan warna garis pinggir
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Colors
                              .blue), // Menentukan warna garis pinggir saat fokus
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, top: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      "Phone Number",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    const Icon(
                      Icons.edit,
                      size: 24.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 25, top: 10),
              child: Obx(
                () => TextField(
                  controller: profileKurirController.phoneNumberController
                    ..text =
                        profileKurirController.customer.value.data?.noTelepon ??
                            '',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Menentukan radius untuk membuat bentuk rounded
                      borderSide: BorderSide(
                          color:
                              Colors.black), // Menentukan warna garis pinggir
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Colors
                              .blue), // Menentukan warna garis pinggir saat fokus
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, top: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      "Alamat",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    const Icon(
                      Icons.edit,
                      size: 24.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 25, top: 10),
              child: Obx(
                () => TextField(
                  controller: profileKurirController.addressController
                    ..text =
                        profileKurirController.customer.value.data?.alamat ??
                            '',
                  maxLines: null, // Memungkinkan input lebih dari satu baris
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200], // Atur warna latar belakang
                    hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 12), // Atur warna teks hintText
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 30.0,
                        horizontal: 15.0), // Sesuaikan nilai vertical
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Save Change"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () async {
                // Call editProfile function from the controller
                await profileKurirController.editProfile(
                  nama: profileKurirController.fullNameController.text,
                  email: profileKurirController.emailController.text,
                  noTelepon: profileKurirController.phoneNumberController.text,
                  alamat: profileKurirController.addressController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}