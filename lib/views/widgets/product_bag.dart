import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudarshan_creations/models/product_model.dart';
import 'package:sudarshan_creations/shared/const.dart';

class ProductBagWid extends StatelessWidget {
  const ProductBagWid({
    super.key,
    this.forHome = false,
    this.product,
  });
  final bool forHome;
  final ProductModel? product;
  @override
  Widget build(BuildContext context) {
    final defaultVariant =
        product?.variants.firstWhereOrNull((element) => element.defaultt);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 330,
          width: 256,
          // clipBehavior: forHome ? Clip.none : Clip.antiAlias,
          // padding: forHome ? const EdgeInsets.all(8) : null,
          // decoration: BoxDecoration(
          //   color: forHome ? Colors.white : null,
          //   // borderRadius: BorderRadius.circular(10)
          // ),
          child: defaultVariant != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      color: Colors.white,
                    ),
                    CachedNetworkImage(
                      imageUrl: defaultVariant.images.first,
                      fit: BoxFit.cover,
                    ),
                  ],
                )
              : Image.asset(
                  'assets/bag_img.png',
                  fit: BoxFit.cover,
                ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product != null
                    ? product!.name
                    : "The Rainbow Unicorn - Gift Bags",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              const SizedBox(height: 8),
              Text(
                product != null && defaultVariant != null
                    ? defaultVariant.priceType == PriceTypeModel.inquiry
                        ? "Inquiry"
                        : "From Rs. ${product?.minPrice}"
                    : "From Rs. 1,600",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
