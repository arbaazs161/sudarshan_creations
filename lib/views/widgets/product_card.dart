import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(15)
              ),
          child: CachedNetworkImage(
            imageUrl: image,
            width: double.maxFinite,
            errorWidget: (context, url, error) {
              return const Icon(CupertinoIcons.camera);
            },
            placeholder: (context, url) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.black54, size: 20),
              );
            },
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xff303030),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
