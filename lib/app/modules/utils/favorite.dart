import 'package:dikantin/app/modules/home/controllers/home_controller.dart';
import 'package:dikantin/app/modules/utils/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final HomeController homeController = Get.find<HomeController>();

  // Buat sebuah List yang berisi data
  List<Map<String, dynamic>> items = [
    {
      "image": "assets/basreng.jpg",
      "name": "Basreng Kantin 1",
      "price": "Rp. 6.000",
      "Terjual": "20 porsi"
    },
    {
      "image": "assets/sate.jpg",
      "name": "Sate Madura Kantin 2",
      "price": "Rp. 15.000",
      "Terjual": "15 porsi"
    },
    {
      "image": "assets/nasi.jpeg",
      "name": "Nasi Liwet Kantin 3",
      "price": "Rp. 12.000",
      "Terjual": "100 porsi"
    },
  ];
  @override
  Widget build(BuildContext context) {
    final mediaHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    // final bodyHeight =
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            search(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.020,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  "Favorit hari ini",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                homeController.increment();
                homeController.update();
              },
              child: Container(
                height: mediaHeight * 0.40,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                      padding: EdgeInsets.all(5),
                      // color: Colors.blue,
                      // margin: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width *
                          0.5, // Lebar responsif
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.asset(
                              items[index]["image"],
                              height: 300,
                              width: 450,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            // margin: EdgeInsets.all(10),
                            // height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black],
                                stops: [0.7, 1.0],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Icon(
                              Icons.favorite,
                              size: 40,
                              color: Colors.red,
                            ), // Ikon love
                          ),
                          Positioned(
                            bottom: 30,
                            left: 15,
                            right: 10,
                            child: Text(
                              items[index]["name"],
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 15,
                            right: 10,
                            child: Text(
                              items[index]["price"],
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  "Penjualan Hari ini",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                homeController.increment();
                homeController.update();
              },
              child: Container(
                height: mediaHeight * 0.20,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                      padding: EdgeInsets.all(5),
                      // color: Colors.blue,
                      // margin: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width *
                          0.6, // Lebar responsif
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.asset(
                              items[index]["image"],
                              height: 300,
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            // margin: EdgeInsets.all(10),
                            // height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black],
                                stops: [0.4, 1.0],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            left: 15,
                            right: 10,
                            child: Text(
                              items[index]["name"],
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 15,
                            right: 10,
                            child: Text(
                              items[index]["Terjual"],
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
