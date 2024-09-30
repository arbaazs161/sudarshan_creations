import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudarshan_creations/shared/responsive.dart';

class SudarshanFooterSection extends StatelessWidget {
  const SudarshanFooterSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWid(
      mobile: Container(
        height: 200,
        padding: const EdgeInsets.symmetric(vertical: 30),
        color: const Color(0xffFEF2D0),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Privacy Policy",
                    style: GoogleFonts.brawler(
                      color: const Color(0xff303030),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const VerticalDivider(color: Color(0xff303030)),
                  Text(
                    "Terms of Use",
                    style: GoogleFonts.brawler(
                      color: const Color(0xff303030),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.facebook)),
                const SizedBox(width: 10),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.crop_square_outlined))
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Copyright © Sudarshan Cards.",
              style: GoogleFonts.brawler(
                color: const Color(0xff303030),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "All rights reserved.",
              style: GoogleFonts.brawler(
                color: const Color(0xff303030),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      desktop: Container(
        height: 60,
        color: const Color(0xffFEF2D0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Row(
            children: [
              Text(
                "Copyright © Sudarshan Cards. All rights reserved.",
                style: GoogleFonts.brawler(
                  color: const Color(0xff303030),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Text(
                      "Privacy Policy",
                      style: GoogleFonts.brawler(
                        color: const Color(0xff303030),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const VerticalDivider(color: Color(0xff303030)),
                    Text(
                      "Terms of Use",
                      style: GoogleFonts.brawler(
                        color: const Color(0xff303030),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              Row(
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.facebook)),
                  const SizedBox(width: 10),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.crop_square_outlined))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
