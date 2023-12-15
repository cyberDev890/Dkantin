import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    final RegisterController c = Get.put(RegisterController());
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/bg.png'), // Ganti dengan path gambar latar belakang Anda
            fit: BoxFit.cover, // Sesuaikan sesuai kebutuhan Anda
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text("Register",
                    style: TextStyle(
                        fontSize: textScaleFactor <= 1.15 ? 40 : 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: TextField(
                  style: TextStyle(
                    fontSize: textScaleFactor <= 1.15 ? 14 : 14,
                  ),
                  keyboardType: TextInputType.name,
                  controller: c.nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Enter your name',
                    suffixIcon: Icon(
                      CarbonIcons.user_avatar,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: TextField(
                  style: TextStyle(
                    fontSize: textScaleFactor <= 1.15 ? 14 : 14,
                  ),
                  keyboardType: TextInputType.name,
                  controller: c.emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Enter your email',
                    suffixIcon: Icon(
                      CarbonIcons.mail_all,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: TextField(
                  style: TextStyle(
                    fontSize: textScaleFactor <= 1.15 ? 14 : 14,
                  ),
                  controller: c
                      .phoneController, // Anda dapat mengganti controller sesuai kebutuhan
                  keyboardType: TextInputType
                      .phone, // Menentukan jenis keyboard untuk nomor telepon
                  maxLength: 12,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Enter your phone number', // Ubah teks petunjuk
                    suffixIcon: Icon(
                      Icons.phone, // Mengganti ikon ke ikon telepon
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: TextField(
                  style: TextStyle(
                    fontSize: textScaleFactor <= 1.15 ? 14 : 14,
                  ),
                  controller: c.addressController,
                  keyboardType: TextInputType
                      .streetAddress, // Menentukan jenis keyboard untuk teks
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Enter your address', // Ubah teks petunjuk
                    suffixIcon: Icon(
                      Icons.location_on, // Mengganti ikon ke ikon alamat
                    ),
                  ),
                ),
              ),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: TextField(
                    style: TextStyle(
                      fontSize: textScaleFactor <= 1.15 ? 14 : 14,
                    ),
                    controller: c.passwordController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          c.obscureText.value
                              ? CarbonIcons.view_off
                              : CarbonIcons.view,
                        ),
                        onPressed: () {
                          c.toggleObscureText();
                        },
                      ),
                    ),
                    obscureText: c.obscureText.value,
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: 300,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Color.fromARGB(255, 55, 156, 211),
                    ),
                    onPressed: () async {
                      // Ambil data dari controller
                      final name = controller.nameController.text;
                      final email = controller.emailController.text;
                      final phone = controller.phoneController.text;
                      final address = controller.addressController.text;
                      final password = controller.passwordController.text;

                      // Panggil metode register dari RegisterProvider
                      try {
                        await controller.registerProvider
                            .register(name, email, phone, address, password);
                        // Pendaftaran berhasil, tambahkan logika sesuai kebutuhan Anda
                      } catch (e) {
                        // Penanganan kesalahan saat pendaftaran gagal
                        print('Pendaftaran gagal: $e');
                      }
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: textScaleFactor <= 1.15 ? 14 : 14,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: 300,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Get.toNamed('/login');
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: textScaleFactor <= 1.15 ? 14 : 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
