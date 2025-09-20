import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sudarshan_creations/models/product_model.dart';
import 'package:sudarshan_creations/shared/const.dart';

class ProductBagWid extends StatelessWidget {
  const ProductBagWid({
    super.key,
    this.forHome = false,
    this.product,
    this.height = 330,
  });
  final bool forHome;
  final ProductModel? product;
  final double height;
  @override
  Widget build(BuildContext context) {
    final defaultVariant =
        product?.variants.firstWhereOrNull((element) => element.defaultt);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height,

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300)),
          // width: 256,
          // clipBehavior: forHome ? Clip.none : Clip.antiAlias,
          // padding: forHome ? const EdgeInsets.all(8) : null,
          // decoration: BoxDecoration(
          //   color: forHome ? Colors.white : null,
          //   // borderRadius: BorderRadius.circular(10)
          // ),
          child: defaultVariant != null
              ? Stack(
                  // fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 251, 251, 251),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: defaultVariant.images.first,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return const Icon(CupertinoIcons.camera);
                        },
                        placeholder: (context, url) {
                          return Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.black54, size: 20),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : const Center(child: Icon(CupertinoIcons.camera)),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product != null
                    ? product!.name
                    : "The Rainbow Unicorn - Gift Bags",
                // textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              // const SizedBox(height: 8),
              // Text(
              //   product != null && defaultVariant != null
              //       ? defaultVariant.priceType == PriceTypeModel.inquiry
              //           ? "Inquiry"
              //           : "Rs. ${product?.minPrice}"
              //       : "From Rs. 1,600",
              //   textAlign: TextAlign.center,
              //   style: const TextStyle(
              //       fontWeight: FontWeight.w600, fontSize: 15.5),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
