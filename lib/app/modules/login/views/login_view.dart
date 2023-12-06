import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController c = Get.put(LoginController());
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
              Center(
                child: Image.asset(
                  'assets/logoBaru.png', // Ganti dengan path gambar Anda
                  width: 200, // Sesuaikan dengan ukuran yang Anda inginkan
                  height: 200,
                ),
              ),
              Text("Login",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: TextField(
                  controller: c.emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Enter your username',
                    suffixIcon: Icon(
                      CarbonIcons.user_avatar,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: TextField(
                    controller: c.passwordController,
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
                    onPressed: () {
                      // Add code to handle the login button action
                      c.login(
                          c.emailController.text, c.passwordController.text);
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
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
                      Get.toNamed('/register');
                    },
                    child: Text(
                      "Register",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed("/forgot-password");
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      c.loginKurir(
                          c.emailController.text, c.passwordController.text);
                    },
                    child: Text(
                      "Login Sebagai Kurir",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
