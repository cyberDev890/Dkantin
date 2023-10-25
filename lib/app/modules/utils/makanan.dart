// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:dikantin/app/modules/home/controllers/home_controller.dart';
import 'package:dikantin/app/modules/utils/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Makanan extends StatefulWidget {
  const Makanan({Key? key}) : super(key: key);

  @override
  State<Makanan> createState() => _MakananState();
}

class _MakananState extends State<Makanan> {
  final HomeController homeController = Get.find<HomeController>();

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
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            search(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.020,
            ),
            Builder(builder: (context) {
              List categories = [
                {
                  "name": "Snack ",
                  "price": "Rp. 10.000",
                  "kantin": "Kantin 1",
                  "image":
                      "https://images.unsplash.com/photo-1476224203421-9ac39bcb3327?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80",
                },
                {
                  "name": "Snack",
                  "price": "Rp. 10.000",
                  "kantin": "Kantin 2",
                  "image":
                      "https://images.unsplash.com/photo-1593253787226-567eda4ad32d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80",
                },
                {
                  "name": "Snack",
                  "price": "Rp. 10.000",
                  "kantin": "Kantin 3",
                  "image":
                      "https://images.unsplash.com/photo-1527661591475-527312dd65f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=415&q=80",
                },
                {
                  "name": "Snack",
                  "price": "Rp. 10.000",
                  "kantin": "Kantin 4",
                  "image":
                      "https://images.unsplash.com/photo-1580314552228-5a7ce023fc9e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80",
                },
                {
                  "name": "Snack",
                  "price": "Rp. 10.000",
                  "kantin": "Kantin 5",
                  "image":
                      "https://images.unsplash.com/photo-1580314552228-5a7ce023fc9e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80",
                },
                {
                  "name": "Snack",
                  "price": "Rp. 10.000",
                  "kantin": "Kantin 6",
                  "image":
                      "https://images.unsplash.com/photo-1580314552228-5a7ce023fc9e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80",
                },
                {
                  "name": "Snack",
                  "price": "Rp. 10.000",
                  "kantin": "Kantin 7",
                  "image":
                      "https://images.unsplash.com/photo-1580314552228-5a7ce023fc9e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80",
                },
                {
                  "name": "Snack",
                  "price": "Rp. 10.000",
                  "kantin": "Kantin 8",
                  "image":
                      "https://images.unsplash.com/photo-1580314552228-5a7ce023fc9e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80",
                },
                {
                  "name": "Snack",
                  "price": "Rp. 10.000",
                  "kantin": "Kantin 9",
                  "image":
                      "https://images.unsplash.com/photo-1580314552228-5a7ce023fc9e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80",
                },
                {
                  "name": "Snack",
                  "price": "Rp. 10.000",
                  "kantin": "Kantin 10",
                  "image":
                      "https://images.unsplash.com/photo-1580314552228-5a7ce023fc9e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80",
                },
              ];

              return GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.80,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: items.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var item = categories[index];
                  return GestureDetector(
                    onTap: () {},

                    ///Fungsi
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              alignment: Alignment.topRight,
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    items[index]["image"],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        items[index]["name"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        items[index]["kantin"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          items[index]["price"],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: Ink(
                                            decoration: ShapeDecoration(
                                              color: Colors.blue,
                                              shape: CircleBorder(),
                                            ),
                                            child: IconButton.filled(
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                homeController.increment();
                                                homeController.update();
                                              },
                                              iconSize: 18,
                                              icon: const Icon(Icons.add),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
