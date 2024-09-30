import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubCatCardWid extends StatelessWidget {
  const SubCatCardWid({
    super.key,
    required this.image,
    required this.text,
  });

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: GoogleFonts.poppins(
            color: const Color(0xff303030),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
