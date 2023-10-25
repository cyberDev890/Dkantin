// ignore_for_file: prefer_const_constructors

import 'package:dikantin/app/modules/utils/minuman.dart';
import 'package:dikantin/app/modules/utils/favorite.dart';
import 'package:dikantin/app/modules/utils/makanan.dart';
import 'package:dikantin/app/modules/utils/semua.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final HomeController c = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final app = AppBar(
      elevation: 0, // Menghilangkan shadow di bawah AppBar
      backgroundColor: Colors.white, // Membuat AppBar transparan
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: IconButton.filledTonal(
            onPressed: () {},
            icon: Obx(
              () => badges.Badge(
                badgeAnimation: badges.BadgeAnimation.slide(),
                badgeContent: Text(
                  c.count.value.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
                position: badges.BadgePosition.topEnd(top: -10, end: -10),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.green,
                ),
                child: const Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: Color(0xFF00C2FF),
                ),
              ),
            ),
          ),
        ),
      ],
      title: Container(
        padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
        child: Image.asset(
          'assets/logo_dikantin.png',
          height: 90, // Sesuaikan dengan tinggi yang Anda inginkan
          width: 90, // Sesuaikan dengan lebar yang Anda inginkan
          fit: BoxFit.cover,
        ),
      ),
    );
    final x = mediaHeight -
        app.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: app,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFEEFBFF), Color(0xFFAAEBFF)],
            ),
          ),
          child: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 120.0,
                  // collapsedHeight: 100,
                  floating: false,
                  pinned: false,
                  flexibleSpace: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      height: x * 0.20,
                      padding: EdgeInsets.fromLTRB(15, 30, 10, 0),
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFFFFFFF), Color(0xFFEEFBFF)],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Saldo Polije Pay ",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: x * 0.1,
                              ),
                              Container(
                                // height: 22,
                                // width: 64,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xFF00C2FF), width: 1.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        "Top Up",
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            color: Color(0xFF00C2FF),
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        child: Icon(
                                      Icons.add_circle_rounded,
                                      size: 15,
                                      color: Color(0xFF00C2FF),
                                    )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: x / 50,
                          ),
                          Container(
                            // padding: EdgeInsets.only(right: x * 0.25),
                            child: Text(
                              "Rp. 1.000.000",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: MyTabBarDelegate(
                    TabBar(
                      controller: c.tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      isScrollable: true,
                      indicator: DotTabIndicator(color: Color(0xFF00C2FF)),
                      tabs: [
                        Tab(
                          child: Text(
                            "Favorit",
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Semua",
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Makanan",
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Minuman",
                          ),
                        ),
                      ],
                      labelStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight
                              .bold, // Font Weight untuk yang terpilih
                        ),
                      ),
                      unselectedLabelStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight
                              .normal, // Font Weight untuk yang tidak terpilih
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
                controller: c.tabController,
                children: [Favorite(), Semua(), Makanan(), Minuman()]),
          ),
        ),
      ),
    );
  }
}

class MyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  MyTabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        decoration: BoxDecoration(
          // color: Colors.blue,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEDFBFF), Color(0xFFE7F8FD)],
          ),
        ),
        child: _tabBar);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class DotTabIndicator extends Decoration {
  final double indicatorRadius;
  final Color color;

  DotTabIndicator({
    this.indicatorRadius = 4,
    this.color = Colors.blue,
  });

  @override
  _DotPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DotPainter(this, onChanged!);
  }
}

class _DotPainter extends BoxPainter {
  final DotTabIndicator decoration;

  _DotPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = Offset(
          offset.dx +
              (configuration.size!.width / 2) -
              decoration.indicatorRadius,
          offset.dy +
              configuration.size!.height -
              decoration.indicatorRadius * 3,
        ) &
        Size(
          decoration.indicatorRadius * 2,
          decoration.indicatorRadius * 2,
        );

    final Paint paint = Paint();
    paint.color = decoration.color;
    paint.style = PaintingStyle.fill;

    canvas.drawCircle(rect.center, decoration.indicatorRadius, paint);
  }
}