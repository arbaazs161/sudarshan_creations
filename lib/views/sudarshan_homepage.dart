import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudarshan_creations/shared/responsive.dart';
import '../shared/router.dart';
import 'sudarshan_product_details.dart';
import 'sudarshan_subcategories.dart';
import 'widgets/footer.dart';
import 'widgets/product_bag.dart';
import 'widgets/product_card.dart';
import 'widgets/top_appbar.dart';

class SudarshanHomePage extends StatefulWidget {
  const SudarshanHomePage({super.key});

  @override
  State<SudarshanHomePage> createState() => _SudarshanHomePageState();
}

class _SudarshanHomePageState extends State<SudarshanHomePage> {
  List<String> tabBarCatList = [
    'GIFT SETS',
    'MONEY ENVELOPES',
    'GIFT TAGS',
    'GIFT BAGS',
    'NOTECARDS KIDS',
    'GIFT SETS',
  ];
  @override
  Widget build(BuildContext context) {
    return ResponsiveWid(
      mobile: Scaffold(
        backgroundColor: const Color(0xffFEF7F3),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ...List.generate(
                                tabBarCatList.length,
                                (index) {
                                  return Padding(
                                    padding: index != 0
                                        ? const EdgeInsets.only(left: 20.0)
                                        : const EdgeInsets.only(left: 0.0),
                                    child: Text(
                                      tabBarCatList[index],
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xff303030),
                                        fontSize: 15,
                                      ),
                                    ),
                                  );
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                      backgroundColor: const Color(0xffFBD554),
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
                              6,
                              (index) {
                                final image = index % 2 == 0
                                    ? 'assets/money_envol_image.png'
                                    : 'assets/gift_sets_image.png';
                                final text = index % 2 == 0
                                    ? "GIFT SETS"
                                    : "MONEY ENVELOPES";
                                return InkWell(
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      context.go("${Routes.category}/id");
                                      // Navigator.push(context, MaterialPageRoute(
                                      //   builder: (context) {
                                      //     return const SudarshanDisplayAllSubCategories(
                                      //       categoryId: "",
                                      //     );
                                      //   },
                                      // ));
                                    },
                                    child: SubCatCardWid(
                                        image: image, text: text));
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
                                4,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: InkWell(
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        onTap: () {
                                          context.go("${Routes.product}/id");

                                          // Navigator.push(context,
                                          //     MaterialPageRoute(
                                          //   builder: (context) {
                                          //     return const SudarshanProductDetails();
                                          //   },
                                          // ));
                                        },
                                        child:
                                            const ProductBagWid(forHome: true)),
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
                                    fontWeight: FontWeight.w700, fontSize: 18),
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
                                    fontWeight: FontWeight.w700, fontSize: 18),
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
                                child: Image.asset('assets/stationary_img.png'),
                              ),
                              const SizedBox(height: 17),
                              Text(
                                "Customised stationery",
                                style: GoogleFonts.brawler(
                                    fontWeight: FontWeight.w700, fontSize: 18),
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
                        const SizedBox(width: 25),
                        SizedBox(
                          width: 250,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150,
                                child:
                                    Image.asset('assets/hand_crafted_img.png'),
                              ),
                              const SizedBox(height: 17),
                              Text(
                                "Hand crafted",
                                style: GoogleFonts.brawler(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Handcrafted With Love, Exuding Artisanal Excellence",
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
                                    'assets/women_empowerment_img.png'),
                              ),
                              const SizedBox(height: 17),
                              Text(
                                "Women empowerment",
                                style: GoogleFonts.brawler(
                                    fontWeight: FontWeight.w700, fontSize: 18),
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
                                          decoration: TextDecoration.underline,
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
                                          decoration: TextDecoration.underline,
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
        backgroundColor: const Color(0xffFEF7F3),
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
                      'assets/Hero_section_bg.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Container(
                  //   height: 800,
                  //   width: double.maxFinite,
                  //   color: Colors.white60,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 25),
                    child: Column(
                      children: [
                        const TopAppBar(mobile: false),
                        const SizedBox(height: 15),
                        const Divider(height: 0, color: Color(0xffB58543)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ...List.generate(
                                tabBarCatList.length,
                                (index) {
                                  return Text(
                                    tabBarCatList[index],
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff303030),
                                      fontSize: 15,
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        const Divider(height: 0, color: Color(0xffB58543)),
                        const SizedBox(height: 15),
                        SizedBox(
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
                        // Positioned(
                        //     child: Row(
                        //   children: [],
                        // )),
                      ],
                    ),
                  )
                ],
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
                              6,
                              (index) {
                                final image = index % 2 == 0
                                    ? 'assets/money_envol_image.png'
                                    : 'assets/gift_sets_image.png';
                                final text = index % 2 == 0
                                    ? "GIFT SETS"
                                    : "MONEY ENVELOPES";
                                return InkWell(
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      context.go("${Routes.category}/id");

                                      // Navigator.push(context, MaterialPageRoute(
                                      //   builder: (context) {
                                      //     return const SudarshanDisplayAllSubCategories(
                                      //         categoryId: "");
                                      //   },
                                      // ));
                                    },
                                    child: SubCatCardWid(
                                        image: image, text: text));
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
                                4,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: InkWell(
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        onTap: () {
                                          context.go("${Routes.product}/id");

                                          // Navigator.push(context,
                                          //     MaterialPageRoute(
                                          //   builder: (context) {
                                          //     return const SudarshanProductDetails();
                                          //   },
                                          // ));
                                        },
                                        child:
                                            const ProductBagWid(forHome: true)),
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
                                    fontWeight: FontWeight.w700, fontSize: 18),
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
                                    fontWeight: FontWeight.w700, fontSize: 18),
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
                                child: Image.asset('assets/stationary_img.png'),
                              ),
                              const SizedBox(height: 17),
                              Text(
                                "Customised stationery",
                                style: GoogleFonts.brawler(
                                    fontWeight: FontWeight.w700, fontSize: 18),
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
                        const SizedBox(width: 25),
                        SizedBox(
                          width: 250,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150,
                                child:
                                    Image.asset('assets/hand_crafted_img.png'),
                              ),
                              const SizedBox(height: 17),
                              Text(
                                "Hand crafted",
                                style: GoogleFonts.brawler(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Handcrafted With Love, Exuding Artisanal Excellence",
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
                                    'assets/women_empowerment_img.png'),
                              ),
                              const SizedBox(height: 17),
                              Text(
                                "Women empowerment",
                                style: GoogleFonts.brawler(
                                    fontWeight: FontWeight.w700, fontSize: 18),
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
                      child: SizedBox(
                        width: 1024,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset('assets/welcome_bg.png'),
                            Align(
                              alignment: const Alignment(-.55, 0),
                              child: SizedBox(
                                width: 650,
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
                                    const SizedBox(height: 10),
                                    // SizedBox(height: 10),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text:
                                              "Discover a world of exquisite stationery and impeccable craftsmanship at ",
                                          style: GoogleFonts.poppins(
                                              height: 2.2,
                                              color: const Color(0xff030303),
                                              fontSize: 13.5)),
                                      TextSpan(
                                          text: "Sudarshan Cards.",
                                          style: GoogleFonts.poppins(
                                              height: 2.2,
                                              color: const Color(0xff030303),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13.5)),
                                    ])),

                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text:
                                              'We are your one-stop shop for all your stationery needs, offering a wide range of products including ',
                                          style: GoogleFonts.poppins(
                                              height: 2.2,
                                              color: const Color(0xff030303),
                                              fontSize: 13.5)),
                                      TextSpan(
                                          text: 'money envelopes',
                                          style: GoogleFonts.poppins(
                                              height: 2.2,
                                              color: const Color(0xff030303),
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationThickness: 2,
                                              fontSize: 13.5)),
                                      TextSpan(
                                          text:
                                              ', notecards, gift sets, gift bags, wax seals, and ',
                                          style: GoogleFonts.poppins(
                                              height: 2.2,
                                              color: const Color(0xff030303),
                                              fontSize: 13.5)),
                                      TextSpan(
                                          text: 'pillow boxes.',
                                          style: GoogleFonts.poppins(
                                              height: 2.2,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationThickness: 2,
                                              color: const Color(0xff030303),
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

              // BRAND HIGHLIGHTS COMPLETED

              // FOOTER START

              const SudarshanFooterSection(),
              // FOOTER Completed
            ],
          ),
        ),
      ),
    );
  }
}
