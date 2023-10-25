// // ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class bar extends StatefulWidget {
//   const bar({Key? key}) : super(key: key);

//   @override
//   State<bar> createState() => _barState();
// }

// class _barState extends State<bar> {
//   @override
//   Widget build(BuildContext context) {
//     // final mediaHeight = MediaQuery.of(context).size.height;
//     // final app = AppBar(
//     //   elevation: 0, // Menghilangkan shadow di bawah AppBar
//     //   backgroundColor: Colors.transparent, // Membuat AppBar transparan
//     //   actions: [
//     //     Container(
//     //       margin:
//     //           EdgeInsets.only(right: 10), // Margin kanan untuk ikon keranjang
//     //       child: Icon(
//     //         Icons.shopping_cart,
//     //         color: Color(0xFF00C2FF),
//     //       ),
//     //     ),
//     //   ],
//     //   title: Image.asset(
//     //     'assets/logo_dikantin.png',
//     //     height: 80, // Sesuaikan dengan tinggi yang Anda inginkan
//     //     width: 90, // Sesuaikan dengan lebar yang Anda inginkan
//     //     fit: BoxFit.cover,
//     //   ),
//     // );
//     // final x = mediaHeight -
//     //     app.preferredSize.height -
//     //     MediaQuery.of(context).padding.top;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Colors.blue,
//             // gradient: LinearGradient(
//             //   begin: Alignment.topCenter,
//             //   end: Alignment.bottomCenter,
//             //   colors: [Color(0xFFFFFFFF), Color(0xEEFBFF)],
//             // ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     Container(
//               //       width: 60,
//               //       child: Image.asset(
//               //         height: 100,
//               //         width: 100,
//               //         'assets/logo_dikantin.png',
//               //         fit: BoxFit.cover,
//               //       ),
//               //     ),
//               //     Container(
//               //         height: 50,
//               //         width: 50,
//               //         decoration: BoxDecoration(
//               //             color: Color(0xFFAAEBFF),
//               //             borderRadius: BorderRadius.all(Radius.circular(15))),
//               //         child: Icon(
//               //           Icons.shopping_cart,
//               //           color: Color(0xFF00C2FF),
//               //         )),
//               //   ],
//               // ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 10),
//                     child: Text(
//                       "Saldo Polije Pay ",
//                       style: GoogleFonts.poppins(
//                         textStyle: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 31,
//                   ),
//                   Container(
//                     height: 22,
//                     width: 64,
//                     decoration: BoxDecoration(
//                         border:
//                             Border.all(color: Color(0xFF00C2FF), width: 1.5),
//                         borderRadius: BorderRadius.all(Radius.circular(7))),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           child: Text(
//                             "Top Up",
//                             style: GoogleFonts.poppins(
//                               textStyle: TextStyle(
//                                 color: Color(0xFF00C2FF),
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                             child: Icon(
//                           Icons.add_circle_rounded,
//                           size: 15,
//                           color: Color(0xFF00C2FF),
//                         ))
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.88,
//                 child: Text(
//                   "Rp. 1.000.000",
//                   style: GoogleFonts.poppins(
//                     textStyle: TextStyle(
//                       color: Colors.black,
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 23,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
