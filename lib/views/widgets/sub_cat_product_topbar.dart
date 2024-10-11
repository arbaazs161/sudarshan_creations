import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudarshan_creations/shared/methods.dart';
import 'package:sudarshan_creations/shared/responsive.dart';
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
        color: const Color.fromARGB(255, 254, 243, 232),
        height: 300,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              width: double.maxFinite,
              child: Image.asset(
                'assets/top_bg_img.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
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
        height: 350,
        child: Stack(
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
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25),
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

class PageHeaderTopBar extends StatelessWidget {
  const PageHeaderTopBar({super.key, required this.title});
  final String title;
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
        child: Stack(
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
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25),
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
