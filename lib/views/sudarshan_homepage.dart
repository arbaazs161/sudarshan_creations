import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudarshan_creations/controller/home_controller.dart';
import 'package:sudarshan_creations/shared/methods.dart';
import 'package:sudarshan_creations/shared/responsive.dart';
import 'package:sudarshan_creations/views/wrapper.dart';
import '../shared/router.dart';
import 'widgets/footer.dart';
import 'widgets/product_bag.dart';
import 'widgets/product_card.dart';
import 'widgets/top_appbar.dart';

final _homePageScafKey = GlobalKey<ScaffoldState>();
final _mainCategoriesKey = GlobalKey();

class SudarshanHomePage extends StatefulWidget {
  const SudarshanHomePage({super.key});

  @override
  State<SudarshanHomePage> createState() => _SudarshanHomePageState();
}

class _SudarshanHomePageState extends State<SudarshanHomePage> {
  // List<String> tabBarCatList = [
  //   'GIFT SETS',
  //   'MONEY ENVELOPES',
  //   'GIFT TAGS',
  //   'GIFT BAGS',
  //   'NOTECARDS KIDS',
  //   'GIFT SETS',
  // ];
  ScrollController scrollController = ScrollController();
  bool shopNowClicked = false;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
    // if (widget.widname != null && widget.widname == 'wishlist') {
    //   scrollController.animateTo(550,
    //       duration: Duration(milliseconds: 100), curve: Curves.linear);
    // }
  }

  bool isScrolled = false;
  void onScroll() {
    if (scrollController.position.pixels > 0) {
      setState(() {
        isScrolled = true;
      });
    } else {
      setState(() {
        isScrolled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    scroller();

    return GetBuilder<HomeCtrl>(builder: (ctrl) {
      return ResponsiveWid(
          mobile: Wrapper(
            scafkey: _homePageScafKey,
            // small: true,
            // backgroundColor: const Color(0xffFEF7F3),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  // HERO SECTION
                  SizedBox(
                    height: 800,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Image.asset(
                            'assets/hero_section_mobile.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TopAppBar(mobile: true),
                            ),
                            const SizedBox(height: 15),
                            const Divider(height: 0, color: Color(0xffB58543)),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 22),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ...List.generate(
                                    ctrl.homeCategories.length,
                                    (index) {
                                      final idx =
                                          ctrl.homeCategories[index].docId;
                                      return InkWell(
                                          onHover: (idx) {},
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            context
                                                .go("${Routes.category}/$idx");
                                          },
                                          child: Padding(
                                            padding: index != 0
                                                ? const EdgeInsets.only(
                                                    left: 20.0)
                                                : const EdgeInsets.only(
                                                    left: 0.0),
                                            child: Text(
                                              capilatlizeFirstLetter(ctrl
                                                  .homeCategories[index].name),
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xff303030),
                                                fontSize: 15,
                                              ),
                                            ),
                                          ));
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Divider(height: 0, color: Color(0xffB58543)),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 280,
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Image.asset(
                                        height: 220,
                                        width: 180,
                                        'assets/hero_left_tilt_img.png'),
                                  ),
                                  const Spacer(),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Image.asset(
                                        height: 220,
                                        width: 180,
                                        'assets/hero_right_tilt_image.png'),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              height: 300,
                              child: Column(
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 70),
                                  Text("Luxurious Gifting",
                                      style: GoogleFonts.brawler(
                                        color: const Color(0xff95170D),
                                        fontSize: 35,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Elevate Gifts with Personalised Envelopes",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff303030),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(),
                                  const SizedBox(height: 15),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          fixedSize:
                                              const Size(double.maxFinite, 50),
                                          backgroundColor:
                                              const Color(0xffFBD554),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      onPressed: () {},
                                      child: Text(
                                        "Shop Now",
                                        style: GoogleFonts.brawler(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                ],
                              ),
                            ),

                            /* 
                            const SizedBox(
                              // color: Colors.black12,
                              height: 600,
                              child: SizedBox(
                                  // width: 1024,
                              
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 100.0),
                                      child: SizedBox(
                                          // height: 400,
                                          height: MediaQuery.sizeOf(context).width *
                                              .25,
                                          child: Image.asset(
                                              'assets/hero_left_tilt_img.png')),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 90),
                                        Text("Luxurious Gifting",
                                            style: GoogleFonts.brawler(
                                              color: const Color(0xff95170D),
                                              fontSize: 50,
                                              fontWeight: FontWeight.w700,
                                            )),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Elevate Gifts with Personalised Envelopes",
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xff303030),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 60),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.all(20),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              backgroundColor:
                                                  const Color(0xffFBD554),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              "Shop Now",
                                              style: GoogleFonts.brawler(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black),
                                            ))
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 100.0),
                                      child: SizedBox(
                                          // height: 400,
                                          height: MediaQuery.sizeOf(context).width *
                                              .25,
                                          child: Image.asset(
                                              'assets/hero_right_tilt_image.png')),
                                    ),
                                  ],
                                ),
                              
                                  ),
                            ),
                            */
                            const SizedBox(height: 15)
                            // Positioned(
                            //     child: Row(
                            //   children: [],
                            // )),
                          ],
                        )
                      ],
                    ),
                  ),

                  // HERO SECTION COMPLETED

                  // SHOP BY CATEGORIES
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          "SHOP BY CATEGORIES",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.brawler(
                            color: const Color(0xff242424),
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 50),
                        Center(
                          child: Container(
                            width: 1200,
                            // color: Colors.black12,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: StaggeredGrid.extent(
                              maxCrossAxisExtent: 400,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              children: [
                                ...List.generate(
                                  ctrl.homeCategories.length,
                                  (index) {
                                    final image =
                                        ctrl.homeCategories[index].image;
                                    final text =
                                        ctrl.homeCategories[index].name;
                                    return InkWell(
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          context.go(
                                              "${Routes.category}/${ctrl.homeCategories[index].docId}");
                                          // Navigator.push(context, MaterialPageRoute(
                                          //   builder: (context) {
                                          //     return const SudarshanDisplayAllSubCategories(
                                          //       categoryId: "",
                                          //     );
                                          //   },
                                          // ));
                                        },
                                        child: SubCatCardWid(
                                            image: image,
                                            text:
                                                capilatlizeFirstLetter(text)));
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 70),
                      ],
                    ),
                  ),

                  // SHOP BY CATEGORIES COMPLETED

                  // TOP SELLING
                  Stack(
                    children: [
                      SizedBox(
                        height: 620,
                        width: double.maxFinite,
                        child: Image.asset(
                          'assets/top_seliing_bg.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            Text(
                              "TOP SELLING",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.brawler(
                                color: const Color(0xff242424),
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 60),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Row(
                                // runAlignment: WrapAlignment.center,
                                // runSpacing: 15,
                                // spacing: 17,
                                children: [
                                  ...List.generate(
                                    ctrl.topSellingProducts.length,
                                    (index) {
                                      final product =
                                          ctrl.topSellingProducts[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 25.0),
                                        child: InkWell(
                                            highlightColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            onTap: () {
                                              context.go(
                                                  "${Routes.product}/${product.docId}");

                                              // Navigator.push(context,
                                              //     MaterialPageRoute(
                                              //   builder: (context) {
                                              //     return const SudarshanProductDetails();
                                              //   },
                                              // ));
                                            },
                                            child: ProductBagWid(
                                                product: product,
                                                forHome: true)),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 70),
                          ],
                        ),
                      )
                    ],
                  ),
                  // TOP SELLING COMPLTED

                  // BRAND HIGHLIGHTS

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          "BRAND HIGHLIGHTS",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.brawler(
                            color: const Color(0xff242424),
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Wrap(
                          alignment: WrapAlignment.center,
                          // runAlignment: WrapAlignment.center,
                          runSpacing: 15,
                          children: [
                            // const Spacer(),
                            SizedBox(
                              width: 250,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: Image.asset('assets/medal_img.png'),
                                  ),
                                  const SizedBox(height: 17),
                                  Text(
                                    "Impeccable quality",
                                    style: GoogleFonts.brawler(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Superior Craftsmanship, Unmatched Quality & Unique Designs",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        /* fontWeight: FontWeight.w700, */ fontSize:
                                            13),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 25),
                            SizedBox(
                              width: 250,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: Image.asset('assets/people_img.png'),
                                  ),
                                  const SizedBox(height: 17),
                                  Text(
                                    "Customer satisfaction",
                                    style: GoogleFonts.brawler(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "12000+ Happy & Satisfied Customers Around The Globe",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        /* fontWeight: FontWeight.w700, */ fontSize:
                                            13),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 25),
                            SizedBox(
                              width: 250,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: Image.asset(
                                        'assets/stationary_img.png'),
                                  ),
                                  const SizedBox(height: 17),
                                  Text(
                                    "Customised stationery",
                                    style: GoogleFonts.brawler(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Name Personalisation Perfection Awaits You",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        /* fontWeight: FontWeight.w700, */ fontSize:
                                            13),
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(width: 25),
                            // SizedBox(
                            //   width: 250,
                            //   child: Column(
                            //     children: [
                            //       SizedBox(
                            //         height: 150,
                            //         child: Image.asset(
                            //             'assets/hand_crafted_img.png'),
                            //       ),
                            //       const SizedBox(height: 17),
                            //       Text(
                            //         "Hand crafted",
                            //         style: GoogleFonts.brawler(
                            //             fontWeight: FontWeight.w700,
                            //             fontSize: 18),
                            //       ),
                            //       const SizedBox(height: 8),
                            //       Text(
                            //         "Handcrafted With Love, Exuding Artisanal Excellence",
                            //         textAlign: TextAlign.center,
                            //         style: GoogleFonts.poppins(
                            //             /* fontWeight: FontWeight.w700, */ fontSize:
                            //                 13),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            const SizedBox(width: 25),
                            SizedBox(
                              width: 250,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: Image.asset(
                                        'assets/women_empowerment_img.png'),
                                  ),
                                  const SizedBox(height: 17),
                                  Text(
                                    "Women empowerment",
                                    style: GoogleFonts.brawler(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Empowering Women, Crafting Excellence Together",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        /* fontWeight: FontWeight.w700, */ fontSize:
                                            13),
                                  ),
                                ],
                              ),
                            ),
                            // const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 80),
                        Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                  height: 600,
                                  width: double.maxFinite,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: const Color(0xffFFF0C5),
                                          width: 8)),
                                  child: Image.asset(
                                      'assets/welcome_bg_mobile_withoutbackground.png',
                                      // fit: BoxFit.cover,
                                      fit: BoxFit.cover
                                      // height: double.maxFinite,
                                      // width: double.maxFinite,
                                      )),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28.0, vertical: 20),
                                width: 330,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome to Sudarshan!!!",
                                      style: GoogleFonts.brawler(
                                        color: const Color(0xff95170D),
                                        fontSize: 35,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    // SizedBox(height: 10),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text:
                                              "Discover a world of exquisite stationery and impeccable craftsmanship at ",
                                          style: GoogleFonts.poppins(
                                              height: 2,
                                              color: const Color(0xff030303),
                                              fontSize: 13.5)),
                                      TextSpan(
                                          text: "Sudarshan Cards.",
                                          style: GoogleFonts.poppins(
                                              height: 2,
                                              color: const Color(0xff030303),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13.5)),
                                    ])),

                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text:
                                              'We are your one-stop shop for all your stationery needs, offering a wide range of products including ',
                                          style: GoogleFonts.poppins(
                                              height: 2,
                                              color: const Color(0xff030303),
                                              fontSize: 13.5)),
                                      TextSpan(
                                          text: 'money envelopes',
                                          style: GoogleFonts.poppins(
                                              height: 2,
                                              color: const Color(0xff030303),
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationThickness: 2,
                                              fontSize: 13.5)),
                                      TextSpan(
                                          text:
                                              ', notecards, gift sets, gift bags, wax seals, and ',
                                          style: GoogleFonts.poppins(
                                              height: 2,
                                              color: const Color(0xff030303),
                                              fontSize: 13.5)),
                                      TextSpan(
                                          text: 'pillow boxes.',
                                          style: GoogleFonts.poppins(
                                              height: 2,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationThickness: 2,
                                              color: const Color(0xff030303),
                                              fontSize: 13.5)),
                                    ])),
                                    const SizedBox(height: 150),
                                    /* 
                                  const Text(
                                      "We are your one-stop shop for all your stationery needs, offering a wide range of products including money envelopes, notecards, gift sets, gift bags, wax seals, and pillow boxes."),
                                */
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),

                  // BRAND HIGHLIGHTS COMPLETED

                  // FOOTER START

                  const SudarshanFooterSection(),
                  // FOOTER Completed
                ],
              ),
            ),
          ),

          // ================================================================ DESKTOP START
          desktop: Scaffold(
            body: true
                ? SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        // HERO SECTION
                        Stack(
                          children: [
                            SizedBox(
                              height: 800,
                              width: double.maxFinite,
                              child: Image.asset(
                                'assets/banner1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 250),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 50),
                                    const Text("Luxurious Gifting",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 79,
                                          fontWeight: FontWeight.w700,
                                        )),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Elevate Gifts with Personalised Envelopes",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 60),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                      ),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(20),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            backgroundColor: Colors.transparent,
                                            // border: Border.all(
                                            //     color: Colors.white, width: 2),
                                            side: BorderSide.none,
                                          ),
                                          onPressed: () {
                                            shopNowClicked = true;
                                            setState(() {});
                                          },
                                          child: const Text(
                                            "Shop Now",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                color: Colors.black.withAlpha(50),
                                child: const Column(
                                  children: [
                                    SizedBox(height: 10),
                                    TopAppBarDesk(mobile: false),
                                    SizedBox(height: 20),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 0.5,
                                      height: 0,
                                    ),
                                    SizedBox(height: 20),
                                    NavBar(),
                                  ],
                                )),
                          ],
                        ),

                        // HERO SECTION COMPLETED

                        // SHOP BY CATEGORIES
                        Container(
                          key: _mainCategoriesKey,
                          color: Colors.white,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 30),
                                const Text(
                                  "SHOP BY CATEGORIES",
                                  style: TextStyle(
                                    color: Color(0xffef6644),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 50),
                                Center(
                                  child: Container(
                                    width: 1200,
                                    // color: Colors.black12,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: StaggeredGrid.extent(
                                      maxCrossAxisExtent: 400,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      // axisDirection: AxisDirection.left,
                                      children: [
                                        ...List.generate(
                                          ctrl.homeCategories.length,
                                          (index) {
                                            final image = ctrl
                                                .homeCategories[index].image;
                                            final text =
                                                ctrl.homeCategories[index].name;
                                            return InkWell(
                                                highlightColor:
                                                    Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                splashColor: Colors.transparent,
                                                onTap: () {
                                                  context.go(
                                                      "${Routes.category}/${ctrl.homeCategories[index].docId}",
                                                      extra:
                                                          ctrl.homeCategories[
                                                              index]);
                                                  // Navigator.push(context, MaterialPageRoute(
                                                  //   builder: (context) {
                                                  //     return const SudarshanDisplayAllSubCategories(
                                                  //         categoryId: "");
                                                  //   },
                                                  // ));
                                                },
                                                child: SubCatCardWid(
                                                    image: image,
                                                    text:
                                                        capilatlizeFirstLetter(
                                                            text)));
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 70),
                              ],
                            ),
                          ),
                        ),

                        // SHOP BY CATEGORIES COMPLETED

                        // TOP SELLING
                        Stack(
                          children: [
                            SizedBox(
                              height: 620,
                              width: double.maxFinite,
                              child: false
                                  ? Container(
                                      // color: const Color(0xffb9b9b9),
                                      )
                                  : Image.asset(
                                      'assets/top_seliing_bg-light.png',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 50),
                                  const Column(
                                    children: [
                                      Text(
                                        "TOP SELLING",
                                        style: TextStyle(
                                          color: Color(0xffef6644),
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 60),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Row(
                                      // runAlignment: WrapAlignment.center,
                                      // runSpacing: 15,
                                      // spacing: 17,
                                      children: [
                                        ...List.generate(
                                          ctrl.topSellingProducts.length,
                                          (index) {
                                            final product =
                                                ctrl.topSellingProducts[index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 25.0),
                                              child: InkWell(
                                                  highlightColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  onTap: () {
                                                    context.go(
                                                        "${Routes.product}/${product.docId}");

                                                    // Navigator.push(context,
                                                    //     MaterialPageRoute(
                                                    //   builder: (context) {
                                                    //     return const SudarshanProductDetails();
                                                    //   },
                                                    // ));
                                                  },
                                                  child: ProductBagWid(
                                                      product: product,
                                                      forHome: true)),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  // const SizedBox(height: 70),
                                ],
                              ),
                            )
                          ],
                        ),
                        // TOP SELLING COMPLTED

                        // BRAND HIGHLIGHTS

                        Container(
                          // color: const Color(0xffFEF7F3),
                          // color: const Color(0xffb9b9b9),
                          color: Colors.white,

                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50),
                                const Text(
                                  "BRAND HIGHLIGHTS",
                                  style: TextStyle(
                                    color: Color(0xffef6644),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  // runAlignment: WrapAlignment.center,
                                  runSpacing: 15,
                                  children: [
                                    // const Spacer(),
                                    SizedBox(
                                      width: 250,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 150,
                                            child:
                                                Image.asset('assets/icon1.png'),
                                          ),
                                          const SizedBox(height: 17),
                                          const Text(
                                            "Impeccable quality",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            "Superior Craftsmanship, Unmatched Quality & Unique Designs",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                /* fontWeight: FontWeight.w700, */ fontSize:
                                                    13),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 25),
                                    SizedBox(
                                      width: 250,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 150,
                                            child:
                                                Image.asset('assets/icon2.png'),
                                          ),
                                          const SizedBox(height: 17),
                                          const Text(
                                            "Customer satisfaction",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            "12000+ Happy & Satisfied Customers Around The Globe",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                /* fontWeight: FontWeight.w700, */ fontSize:
                                                    13),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 25),
                                    SizedBox(
                                      width: 250,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 150,
                                            child:
                                                Image.asset('assets/icon3.png'),
                                          ),
                                          const SizedBox(height: 17),
                                          const Text(
                                            "Customised stationery",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            "Name Personalisation Perfection Awaits You",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                /* fontWeight: FontWeight.w700, */ fontSize:
                                                    13),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // const SizedBox(width: 25),
                                    // SizedBox(
                                    //   width: 250,
                                    //   child: Column(
                                    //     children: [
                                    //       SizedBox(
                                    //         height: 150,
                                    //         child:
                                    //             Image.asset('assets/icon4.png'),
                                    //       ),
                                    //       const SizedBox(height: 17),
                                    //       const Text(
                                    //         "Hand crafted",
                                    //         style: TextStyle(
                                    //             fontWeight: FontWeight.w700,
                                    //             fontSize: 18),
                                    //       ),
                                    //       const SizedBox(height: 8),
                                    //       const Text(
                                    //         "Handcrafted With Love, Exuding Artisanal Excellence",
                                    //         textAlign: TextAlign.center,
                                    //         style: TextStyle(
                                    //             /* fontWeight: FontWeight.w700, */ fontSize:
                                    //                 13),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    const SizedBox(width: 25),
                                    SizedBox(
                                      width: 250,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 150,
                                            child:
                                                Image.asset('assets/icon5.png'),
                                          ),
                                          const SizedBox(height: 17),
                                          const Text(
                                            "Women empowerment",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            "Empowering Women, Crafting Excellence Together",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                /* fontWeight: FontWeight.w700, */ fontSize:
                                                    13),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // const Spacer(),
                                  ],
                                ),
                                const SizedBox(height: 80),
                                Center(
                                  child: SizedBox(
                                    width: 1024,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                            'assets/welcome_bg-modified.png'),
                                        const Align(
                                          alignment: Alignment(-.55, 0),
                                          child: SizedBox(
                                            width: 650,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Welcome to Sudarshan!!!",
                                                  style: TextStyle(
                                                    color: Color(0xff95170D),
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                // SizedBox(height: 10),
                                                Text.rich(TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                          "Discover a world of exquisite stationery and impeccable craftsmanship at ",
                                                      style: TextStyle(
                                                          height: 2.2,
                                                          color:
                                                              Color(0xff030303),
                                                          fontSize: 13.5)),
                                                  TextSpan(
                                                      text: "Sudarshan Cards.",
                                                      style: TextStyle(
                                                          height: 2.2,
                                                          color:
                                                              Color(0xff030303),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 13.5)),
                                                ])),

                                                Text.rich(TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                          'We are your one-stop shop for all your stationery needs, offering a wide range of products including ',
                                                      style: TextStyle(
                                                          height: 2.2,
                                                          color:
                                                              Color(0xff030303),
                                                          fontSize: 13.5)),
                                                  TextSpan(
                                                      text: 'money envelopes',
                                                      style: TextStyle(
                                                          height: 2.2,
                                                          color:
                                                              Color(0xff030303),
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationThickness:
                                                              2,
                                                          fontSize: 13.5)),
                                                  TextSpan(
                                                      text:
                                                          ', notecards, gift sets, gift bags, wax seals, and ',
                                                      style: TextStyle(
                                                          height: 2.2,
                                                          color:
                                                              Color(0xff030303),
                                                          fontSize: 13.5)),
                                                  TextSpan(
                                                      text: 'pillow boxes.',
                                                      style: TextStyle(
                                                          height: 2.2,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationThickness:
                                                              2,
                                                          color:
                                                              Color(0xff030303),
                                                          fontSize: 13.5)),
                                                ])),
                                                /* 
                                        const Text(
                                            "We are your one-stop shop for all your stationery needs, offering a wide range of products including money envelopes, notecards, gift sets, gift bags, wax seals, and pillow boxes."),
                                      */
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 80),
                              ],
                            ),
                          ),
                        ),

                        // BRAND HIGHLIGHTS COMPLETED

                        // FOOTER START

                        const SudarshanFooterSection(),
                        // FOOTER Completed
                      ],
                    ),
                  )
                : NestedScrollView(
                    physics: const NeverScrollableScrollPhysics(),

                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return <Widget>[
                        // Top spacer + TopAppBarDesk + bottom spacer (same as top)
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16), // equal spacing
                            child: Center(
                              child: TopAppBarDesk(mobile: false),
                            ),
                          ),
                        ),

                        // SliverAppBar pinned with NavBar
                        SliverAppBar(
                          pinned: true,
                          floating: false,
                          snap: false,
                          toolbarHeight: 0,
                          backgroundColor: Colors.black45,
                          forceElevated: innerBoxIsScrolled,
                          automaticallyImplyLeading: false,
                          bottom: const PreferredSize(
                            preferredSize: Size.fromHeight(kIsWeb ? 80 : 60),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16), // same spacing
                              child: Center(
                                child: NavBar(),
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    // headerSliverBuilder: (context, innerBoxIsScrolled) {
                    //   return <Widget>[
                    //     SliverAppBar(
                    //         // forceMaterialTransparency: true,
                    //         title: const TopAppBarDesk(mobile: false),
                    //         pinned: true,
                    //         automaticallyImplyLeading: false,
                    //         actions: const [SizedBox()],
                    //         snap: true,
                    //         toolbarHeight: 60,
                    //         floating: true,
                    //         titleSpacing: 30,
                    //         backgroundColor: Colors.black45,
                    //         forceElevated: innerBoxIsScrolled,
                    //         expandedHeight: (kIsWeb ? 80 : 60) + 32,
                    //         bottom: const NavBar())
                    //   ];
                    // },
                    body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          // HERO SECTION
                          Stack(
                            children: [
                              SizedBox(
                                height: 800,
                                width: double.maxFinite,
                                child: Image.asset(
                                  'assets/banner1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 250),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 50),
                                      const Text("Luxurious Gifting",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 79,
                                            fontWeight: FontWeight.w700,
                                          )),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Elevate Gifts with Personalised Envelopes",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 60),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.all(20),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              backgroundColor:
                                                  Colors.transparent,
                                              // border: Border.all(
                                              //     color: Colors.white, width: 2),
                                              side: BorderSide.none,
                                            ),
                                            onPressed: () {},
                                            child: const Text(
                                              "Shop Now",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // HERO SECTION COMPLETED

                          // SHOP BY CATEGORIES
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 30),
                                  const Text(
                                    "SHOP BY CATEGORIES",
                                    style: TextStyle(
                                      color: Color(0xffef6644),
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                  Center(
                                    child: Container(
                                      width: 1200,
                                      // color: Colors.black12,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: StaggeredGrid.extent(
                                        maxCrossAxisExtent: 400,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20,
                                        children: [
                                          ...List.generate(
                                            ctrl.homeCategories.length,
                                            (index) {
                                              final image = ctrl
                                                  .homeCategories[index].image;
                                              final text = ctrl
                                                  .homeCategories[index].name;
                                              return InkWell(
                                                  highlightColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  splashColor:
                                                      Colors.transparent,
                                                  onTap: () {
                                                    context.go(
                                                        "${Routes.category}/${ctrl.homeCategories[index].docId}",
                                                        extra:
                                                            ctrl.homeCategories[
                                                                index]);
                                                    // Navigator.push(context, MaterialPageRoute(
                                                    //   builder: (context) {
                                                    //     return const SudarshanDisplayAllSubCategories(
                                                    //         categoryId: "");
                                                    //   },
                                                    // ));
                                                  },
                                                  child: SubCatCardWid(
                                                      image: image,
                                                      text:
                                                          capilatlizeFirstLetter(
                                                              text)));
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 70),
                                ],
                              ),
                            ),
                          ),

                          // SHOP BY CATEGORIES COMPLETED

                          // TOP SELLING
                          Stack(
                            children: [
                              SizedBox(
                                height: 620,
                                width: double.maxFinite,
                                child: false
                                    ? Container(
                                        // color: const Color(0xffb9b9b9),
                                        )
                                    : Image.asset(
                                        'assets/top_seliing_bg-light.png',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 50),
                                    const Column(
                                      children: [
                                        Text(
                                          "TOP SELLING",
                                          style: TextStyle(
                                            color: Color(0xffef6644),
                                            fontSize: 30,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 60),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      padding:
                                          const EdgeInsets.only(left: 25.0),
                                      child: Row(
                                        // runAlignment: WrapAlignment.center,
                                        // runSpacing: 15,
                                        // spacing: 17,
                                        children: [
                                          ...List.generate(
                                            ctrl.topSellingProducts.length,
                                            (index) {
                                              final product = ctrl
                                                  .topSellingProducts[index];
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 25.0),
                                                child: InkWell(
                                                    highlightColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      context.go(
                                                          "${Routes.product}/${product.docId}");

                                                      // Navigator.push(context,
                                                      //     MaterialPageRoute(
                                                      //   builder: (context) {
                                                      //     return const SudarshanProductDetails();
                                                      //   },
                                                      // ));
                                                    },
                                                    child: ProductBagWid(
                                                        product: product,
                                                        forHome: true)),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    // const SizedBox(height: 70),
                                  ],
                                ),
                              )
                            ],
                          ),
                          // TOP SELLING COMPLTED

                          // BRAND HIGHLIGHTS

                          Container(
                            // color: const Color(0xffFEF7F3),
                            // color: const Color(0xffb9b9b9),
                            color: Colors.white,

                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 50),
                                  const Text(
                                    "BRAND HIGHLIGHTS",
                                    style: TextStyle(
                                      color: Color(0xffef6644),
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    // runAlignment: WrapAlignment.center,
                                    runSpacing: 15,
                                    children: [
                                      // const Spacer(),
                                      SizedBox(
                                        width: 250,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 150,
                                              child: Image.asset(
                                                  'assets/icon1.png'),
                                            ),
                                            const SizedBox(height: 17),
                                            const Text(
                                              "Impeccable quality",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              "Superior Craftsmanship, Unmatched Quality & Unique Designs",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  /* fontWeight: FontWeight.w700, */ fontSize:
                                                      13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 25),
                                      SizedBox(
                                        width: 250,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 150,
                                              child: Image.asset(
                                                  'assets/icon2.png'),
                                            ),
                                            const SizedBox(height: 17),
                                            const Text(
                                              "Customer satisfaction",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              "12000+ Happy & Satisfied Customers Around The Globe",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  /* fontWeight: FontWeight.w700, */ fontSize:
                                                      13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 25),
                                      SizedBox(
                                        width: 250,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 150,
                                              child: Image.asset(
                                                  'assets/icon3.png'),
                                            ),
                                            const SizedBox(height: 17),
                                            const Text(
                                              "Customised stationery",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              "Name Personalisation Perfection Awaits You",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  /* fontWeight: FontWeight.w700, */ fontSize:
                                                      13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 25),
                                      SizedBox(
                                        width: 250,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 150,
                                              child: Image.asset(
                                                  'assets/icon4.png'),
                                            ),
                                            const SizedBox(height: 17),
                                            const Text(
                                              "Hand crafted",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              "Handcrafted With Love, Exuding Artisanal Excellence",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  /* fontWeight: FontWeight.w700, */ fontSize:
                                                      13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 25),
                                      SizedBox(
                                        width: 250,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 150,
                                              child: Image.asset(
                                                  'assets/icon5.png'),
                                            ),
                                            const SizedBox(height: 17),
                                            const Text(
                                              "Women empowerment",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              "Empowering Women, Crafting Excellence Together",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  /* fontWeight: FontWeight.w700, */ fontSize:
                                                      13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // const Spacer(),
                                    ],
                                  ),
                                  const SizedBox(height: 80),
                                  Center(
                                    child: SizedBox(
                                      width: 1024,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                              'assets/welcome_bg-modified.png'),
                                          const Align(
                                            alignment: Alignment(-.55, 0),
                                            child: SizedBox(
                                              width: 650,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Welcome to Sudarshan!!!",
                                                    style: TextStyle(
                                                      color: Color(0xff95170D),
                                                      fontSize: 35,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  // SizedBox(height: 10),
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            "Discover a world of exquisite stationery and impeccable craftsmanship at ",
                                                        style: TextStyle(
                                                            height: 2.2,
                                                            color: Color(
                                                                0xff030303),
                                                            fontSize: 13.5)),
                                                    TextSpan(
                                                        text:
                                                            "Sudarshan Cards.",
                                                        style: TextStyle(
                                                            height: 2.2,
                                                            color: Color(
                                                                0xff030303),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 13.5)),
                                                  ])),

                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            'We are your one-stop shop for all your stationery needs, offering a wide range of products including ',
                                                        style: TextStyle(
                                                            height: 2.2,
                                                            color: Color(
                                                                0xff030303),
                                                            fontSize: 13.5)),
                                                    TextSpan(
                                                        text: 'money envelopes',
                                                        style: TextStyle(
                                                            height: 2.2,
                                                            color: Color(
                                                                0xff030303),
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            decorationThickness:
                                                                2,
                                                            fontSize: 13.5)),
                                                    TextSpan(
                                                        text:
                                                            ', notecards, gift sets, gift bags, wax seals, and ',
                                                        style: TextStyle(
                                                            height: 2.2,
                                                            color: Color(
                                                                0xff030303),
                                                            fontSize: 13.5)),
                                                    TextSpan(
                                                        text: 'pillow boxes.',
                                                        style: TextStyle(
                                                            height: 2.2,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            decorationThickness:
                                                                2,
                                                            color: Color(
                                                                0xff030303),
                                                            fontSize: 13.5)),
                                                  ])),
                                                  /* 
                                        const Text(
                                            "We are your one-stop shop for all your stationery needs, offering a wide range of products including money envelopes, notecards, gift sets, gift bags, wax seals, and pillow boxes."),
                                      */
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 80),
                                ],
                              ),
                            ),
                          ),

                          // BRAND HIGHLIGHTS COMPLETED

                          // FOOTER START

                          const SudarshanFooterSection(),
                          // FOOTER Completed
                        ],
                      ),
                    ),
                  ),
          ));
    });
  }

  void scroller() {
    return WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      homeScroll(shopNowClicked);
    });
  }
}

homeScroll(bool? widName) {
  try {
    if (widName == null) return;
    switch (widName) {
      case true:
        if (_mainCategoriesKey.currentContext == null ||
            !(_mainCategoriesKey.currentState?.mounted ?? true)) {
          return;
        }
        Scrollable.ensureVisible(_mainCategoriesKey.currentContext!,
            duration: const Duration(milliseconds: 1000));
        break;
      // case "gallery":
      //   if (_gallery.currentContext == null ||
      //       !(_gallery.currentState?.mounted ?? true)) {
      //     return;
      //   }
      //   Scrollable.ensureVisible(_gallery.currentContext!,
      //       duration: const Duration(milliseconds: 1000));
      //   break;

      default:
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeCtrl>(builder: (
      ctrl,
    ) {
      return Padding(
        padding: const EdgeInsets.symmetric(),
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          width: 1200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              ctrl.homeCategories.length,
              (index) {
                final mainCategory = ctrl.homeCategories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      context.go("${Routes.category}/${mainCategory.docId}");
                    },
                    child: Container(
                      // width: 150,
                      child: Text(
                        capilatlizeFirstLetter(mainCategory.name),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            // Left 3 categories
          ),
        ),
      );
    });
  }

  Size get preferredSize => const Size.fromHeight(kIsWeb ? 80 : 60);
}
