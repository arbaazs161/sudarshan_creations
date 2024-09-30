import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductBagWid extends StatelessWidget {
  const ProductBagWid({
    super.key,
    this.forHome = false,
  });
  final bool forHome;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          clipBehavior: forHome ? Clip.none : Clip.antiAlias,
          padding: forHome ? const EdgeInsets.all(8) : null,
          decoration: BoxDecoration(
              color: forHome ? Colors.white : null,
              borderRadius: BorderRadius.circular(10)),
          child: Image.asset(
            'assets/bag_img.png',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 200,
          child: Column(
            children: [
              Text(
                "The Rainbow Unicorn - Gift Bags",
                textAlign: TextAlign.center,
                style: GoogleFonts.brawler(
                    fontWeight: FontWeight.w500, fontSize: 15),
              ),
              const SizedBox(height: 8),
              Text(
                "From Rs. 1,600",
                textAlign: TextAlign.center,
                style: GoogleFonts.brawler(
                    fontWeight: FontWeight.w600, fontSize: 15.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
