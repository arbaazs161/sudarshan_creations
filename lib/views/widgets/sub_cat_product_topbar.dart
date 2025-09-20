import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudarshan_creations/shared/methods.dart';
import 'package:sudarshan_creations/shared/responsive.dart';
import 'package:sudarshan_creations/views/sudarshan_homepage.dart';
import '../../models/main_category.dart';
import '../../models/sub_category.dart';
import 'top_appbar.dart';

class SubCatProductTopBar extends StatelessWidget {
  const SubCatProductTopBar({
    super.key,
    this.forCatPage = true,
    this.mainCategoryModel,
    this.subCategoryModel,
  });
  final bool forCatPage;
  final MainCategory? mainCategoryModel;
  final SubCategory? subCategoryModel;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWid(
      mobile: Container(
        // color: const Color.fromARGB(255, 254, 243, 232),
        // height: 300,
        child: Stack(
          children: [
            // SizedBox(
            //   height: 400,
            //   width: double.maxFinite,
            //   child: Image.asset(
            //     // 'assets/top_bg_img.png',
            //     'assets/banner1.png',

            //     fit: BoxFit.cover,
            //   ),
            // ),
            true
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(50),
                      image: const DecorationImage(
                          image: AssetImage('assets/banner1.png'),
                          fit: BoxFit.cover),
                    ),
                    child: const Column(
                      children: [
                        SizedBox(height: 10),
                        TopAppBarMobile(),
                        SizedBox(height: 20),
                        Divider(
                          height: 0,
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        // Divider(
                        //   color: Colors.grey,
                        //   thickness: 0.5,
                        //   height: 0,
                        // ),
                        // const SizedBox(height: 20),
                        // const NavBar(mobile: true),
                        // const SizedBox(height: 20),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        //   child: ConstrainedBox(
                        //     constraints: const BoxConstraints(maxWidth: 1200),
                        //     child: Row(
                        //       children: [
                        //         Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               forCatPage ? "CATEGORY" : "SUB-CATEGORY",
                        //               style: const TextStyle(
                        //                 fontSize: 12,
                        //                 color: Colors.white38,
                        //                 fontWeight: FontWeight.w800,
                        //               ),
                        //             ),
                        //             Text(
                        //               forCatPage
                        //                   ? capilatlizeFirstLetter(
                        //                       mainCategoryModel?.name ??
                        //                           "Category Name")
                        //                   : capilatlizeFirstLetter(
                        //                       subCategoryModel?.name ??
                        //                           "Sub-Category Name"),
                        //               style: const TextStyle(
                        //                 // color: const Color(0xff95170D),
                        //                 color: Colors.white,
                        //                 fontSize: 27,
                        //                 fontWeight: FontWeight.w700,
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const Spacer(),
                        /*    SingleChildScrollView(
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
                                  const Divider(height: 0, color: Color(0xffB58543)), */
                        // const SizedBox(height: 15),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                        child: TopAppBar(mobile: true),
                      ),
                      const Divider(color: Color(0xffB58543)),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    forCatPage ? "CATEGORY" : "SUB-CATEGORY",
                                    style: GoogleFonts.brawler(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    forCatPage
                                        ? capilatlizeFirstLetter(
                                            mainCategoryModel?.name ??
                                                "Category Name")
                                        : capilatlizeFirstLetter(
                                            subCategoryModel?.name ??
                                                "Sub-Category Name"),
                                    style: GoogleFonts.brawler(
                                      color: const Color(0xff95170D),
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
          ],
        ),
      ),
      desktop: SizedBox(
        // height: 150,
        child: true
            ? Stack(
                children: [
                  // SizedBox(
                  //   // height: 400,
                  //   width: double.maxFinite,
                  //   child: Image.asset(
                  //     'assets/top_bg_img.png',
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  // SizedBox(
                  //   // height: 00,
                  //   width: double.maxFinite,
                  //   child: Image.asset(
                  //     'assets/banner1.png',
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(50),
                      image: const DecorationImage(
                          image: AssetImage('assets/banner1.png'),
                          fit: BoxFit.cover),
                    ),
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
                        /*  const SizedBox(height: 20),
                        // Divider(
                        //   color: Colors.grey,
                        //   thickness: 0.5,
                        //   height: 0,
                        // ),
                        // SizedBox(height: 20),
                        const NavBar(),
                        const SizedBox(height: 40),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    forCatPage ? "CATEGORY" : "SUB-CATEGORY",
                                    style: GoogleFonts.brawler(
                                      fontSize: 15,
                                      color: Colors.white38,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    forCatPage
                                        ? capilatlizeFirstLetter(
                                            mainCategoryModel?.name ??
                                                "Category Name")
                                        : capilatlizeFirstLetter(
                                            subCategoryModel?.name ??
                                                "Sub-Category Name"),
                                    style: GoogleFonts.brawler(
                                      // color: const Color(0xff95170D),
                                      color: Colors.white,
                                      fontSize: 45,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Spacer(), */
                      ],
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  SizedBox(
                    // height: 400,
                    width: double.maxFinite,
                    child: Image.asset(
                      'assets/top_bg_img.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 25),
                    child: Column(
                      children: [
                        const TopAppBar(mobile: false),
                        const Divider(color: Color(0xffB58543)),
                        const Spacer(),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    forCatPage ? "CATEGORY" : "SUB-CATEGORY",
                                    style: GoogleFonts.brawler(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    forCatPage
                                        ? capilatlizeFirstLetter(
                                            mainCategoryModel?.name ??
                                                "Category Name")
                                        : capilatlizeFirstLetter(
                                            subCategoryModel?.name ??
                                                "Sub-Category Name"),
                                    style: GoogleFonts.brawler(
                                      color: const Color(0xff95170D),
                                      fontSize: 45,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class FavouriteTopBar extends StatelessWidget {
  const FavouriteTopBar({
    super.key,
    // this.forCatPage = true,
    // this.mainCategoryModel,
    // this.subCategoryModel,
  });
  // final bool forCatPage;
  // final MainCategory? mainCategoryModel;
  // final SubCategory? subCategoryModel;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWid(
      mobile: Container(
        color: const Color.fromARGB(255, 254, 243, 232),
        height: 300,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              width: double.maxFinite,
              child: Image.asset(
                'assets/banner1.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black.withAlpha(50),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const TopAppBarMobile(),
                  const SizedBox(height: 20),
                  const Divider(
                    height: 0,
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  // const Divider(
                  //   color: Colors.grey,
                  //   thickness: 0.5,
                  //   height: 0,
                  // ),
                  const SizedBox(height: 20),
                  const NavBar(mobile: true),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: const Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   forCatPage ? "CATEGORY" : "SUB-CATEGORY",
                              //   style: GoogleFonts.brawler(
                              //     fontSize: 12,
                              //     fontWeight: FontWeight.w800,
                              //   ),
                              // ),
                              Text(
                                'Favourite',
                                // forCatPage
                                //     ? capilatlizeFirstLetter(
                                //         mainCategoryModel?.name ??
                                //             "Category Name")
                                //     : capilatlizeFirstLetter(
                                //         subCategoryModel?.name ??
                                //             "Sub-Category Name"),
                                style: TextStyle(
                                  // color: const Color(0xff95170D),
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
      desktop: SizedBox(
          height: 350,
          child: Stack(
            children: [
              // SizedBox(
              //   // height: 400,
              //   width: double.maxFinite,
              //   child: Image.asset(
              //     'assets/top_bg_img.png',
              //     fit: BoxFit.cover,
              //   ),
              // ),
              SizedBox(
                // height: 00,
                width: double.maxFinite,
                child: Image.asset(
                  'assets/banner1.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: Colors.black.withAlpha(50),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const TopAppBarDesk(mobile: false),
                    const SizedBox(height: 20),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      height: 0,
                    ),
                    const SizedBox(height: 20),
                    // Divider(
                    //   color: Colors.grey,
                    //   thickness: 0.5,
                    //   height: 0,
                    // ),
                    // SizedBox(height: 20),
                    const NavBar(),
                    const SizedBox(height: 40),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   forCatPage ? "CATEGORY" : "SUB-CATEGORY",
                              //   style: GoogleFonts.brawler(
                              //     fontSize: 15,
                              //     color: Colors.white38,
                              //     fontWeight: FontWeight.w800,
                              //   ),
                              // ),
                              Text(
                                'Favourite',
                                // forCatPage
                                //     ? capilatlizeFirstLetter(
                                //         mainCategoryModel?.name ??
                                //             "Category Name")
                                //     : capilatlizeFirstLetter(
                                //         subCategoryModel?.name ??
                                //             "Sub-Category Name"),
                                style: GoogleFonts.brawler(
                                  // color: const Color(0xff95170D),
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          )
          /*        : Stack(
                children: [
                  SizedBox(
                    // height: 400,
                    width: double.maxFinite,
                    child: Image.asset(
                      'assets/top_bg_img.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 25),
                    child: Column(
                      children: [
                        const TopAppBar(mobile: false),
                        const Divider(color: Color(0xffB58543)),
                        const Spacer(),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    forCatPage ? "CATEGORY" : "SUB-CATEGORY",
                                    style: GoogleFonts.brawler(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    forCatPage
                                        ? capilatlizeFirstLetter(
                                            mainCategoryModel?.name ??
                                                "Category Name")
                                        : capilatlizeFirstLetter(
                                            subCategoryModel?.name ??
                                                "Sub-Category Name"),
                                    style: GoogleFonts.brawler(
                                      color: const Color(0xff95170D),
                                      fontSize: 45,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
      */
          ),
    );
  }
}

class PageHeaderTopBar extends StatelessWidget {
  const PageHeaderTopBar(
      {super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return ResponsiveWid(
      mobile: Container(
        color: const Color.fromARGB(255, 254, 243, 232),
        height: 300,
        child: Stack(
          children: [
            SizedBox(
              // height: 350,
              width: double.maxFinite,
              height: double.maxFinite,
              child: Image.asset(
                'assets/top_bg_img.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              child: Column(
                children: [
                  // const SizedBox(height: 35),
                  const TopAppBar(mobile: true),
                  const Divider(color: Color(0xffB58543)),
                  const Spacer(),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Row(
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.brawler(
                            color: const Color(0xff95170D),
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
      desktop: SizedBox(
        height: 350,
        child: true
            ? Stack(
                children: [
                  // SizedBox(
                  //   // height: 400,
                  //   width: double.maxFinite,
                  //   child: Image.asset(
                  //     'assets/top_bg_img.png',
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  SizedBox(
                    // height: 00,
                    width: double.maxFinite,
                    child: Image.asset(
                      'assets/banner1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    color: Colors.black.withAlpha(50),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const TopAppBarDesk(mobile: false),
                        const SizedBox(height: 20),
                        const Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                          height: 0,
                        ),
                        const SizedBox(height: 20),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Column(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //       forCatPage
                                  //           ? "CATEGORY"
                                  //           : "SUB-CATEGORY",
                                  //       style: GoogleFonts.brawler(
                                  //         fontSize: 15,
                                  //         color: Colors.white38,
                                  //         fontWeight: FontWeight.w800,
                                  //       ),
                                  //     ),
                                  //     Text(
                                  //       forCatPage
                                  //           ? capilatlizeFirstLetter(
                                  //               mainCategoryModel?.name ??
                                  //                   "Category Name")
                                  //           : capilatlizeFirstLetter(
                                  //               subCategoryModel?.name ??
                                  //                   "Sub-Category Name"),
                                  //       style: GoogleFonts.brawler(
                                  //         // color: const Color(0xff95170D),
                                  //         color: Colors.white,
                                  //         fontSize: 45,
                                  //         fontWeight: FontWeight.w700,
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                  Text(
                                    title,
                                    style: GoogleFonts.brawler(
                                      // color: const Color(0xff95170D),
                                      color: Colors.white,
                                      fontSize: 45,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  // const SizedBox(height: 10),
                                  Text(
                                    subtitle,
                                    style: GoogleFonts.brawler(
                                      fontSize: 15,
                                      color: Colors.white38,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  SizedBox(
                    // height: 400,
                    width: double.maxFinite,
                    child: Image.asset(
                      'assets/top_bg_img.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 25),
                    child: Column(
                      children: [
                        const TopAppBar(mobile: false),
                        const Divider(color: Color(0xffB58543)),
                        const Spacer(),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: Row(
                            children: [
                              Text(
                                title,
                                style: GoogleFonts.brawler(
                                  color: const Color(0xff95170D),
                                  fontSize: 45,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
