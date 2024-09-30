import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudarshan_creations/shared/responsive.dart';

import 'top_appbar.dart';

class SubCatProductTopBar extends StatelessWidget {
  const SubCatProductTopBar({
    super.key,
    this.forSubCat = true,
  });
  final bool forSubCat;
  @override
  Widget build(BuildContext context) {
    return ResponsiveWid(
      mobile: SizedBox(
        height: 350,
        child: Stack(
          children: [
            SizedBox(
              height: 350,
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
                  const SizedBox(height: 35),
                  const TopAppBarMobile(),
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
                              forSubCat
                                  ? "SUB CATEGORY"
                                  : "SUB CATEGORY / GIFT BAGS",
                              style: GoogleFonts.brawler(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              forSubCat ? "Gift Bags" : "Bluebird Harmony",
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
                  const TopAppBarDesktop(),
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
                              forSubCat
                                  ? "SUB CATEGORY"
                                  : "SUB CATEGORY / GIFT BAGS",
                              style: GoogleFonts.brawler(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              forSubCat ? "Gift Bags" : "Bluebird Harmony",
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
    return SizedBox(
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
            padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25),
            child: Column(
              children: [
                const TopAppBarDesktop(),
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
    );
  }
}
