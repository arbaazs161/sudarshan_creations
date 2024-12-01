import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudarshan_creations/controller/home_controller.dart';
import 'package:sudarshan_creations/models/cartitems_model.dart';
import 'package:sudarshan_creations/models/product_model.dart';
import 'package:sudarshan_creations/shared/const.dart';

class CartCardWid extends StatefulWidget {
  const CartCardWid(
      {super.key,
      this.forHome = false,
      required this.cartModel,
      required this.isCart});
  final bool forHome;
  final CartModel cartModel;
  final bool isCart;

  @override
  State<CartCardWid> createState() => _CartCardWidState();
}

class _CartCardWidState extends State<CartCardWid> {
  TextEditingController qtyCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final selectedVariant = widget.cartModel?.product?.variants
        .firstWhereOrNull((element) => element.id == widget.cartModel?.vId);
    final product = widget.cartModel?.product;
    double productTax = double.parse((((widget.cartModel.product!.tax / 100) *
                selectedVariant!.fixedPrice!.toDouble()) *
            widget.cartModel.qty.toDouble())
        .toStringAsFixed(2));
    double productTotal = widget.cartModel.qty.toDouble() *
            selectedVariant!.fixedPrice!.toDouble() +
        productTax;
    if (qtyCtrl.text != widget.cartModel?.qty.toString())
      qtyCtrl.text = widget.cartModel?.qty.toString() ?? "1";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 100,
              clipBehavior: widget.forHome ? Clip.none : Clip.antiAlias,
              padding: widget.forHome ? const EdgeInsets.all(8) : null,
              decoration: BoxDecoration(
                  color: widget.forHome ? Colors.white : null,
                  borderRadius: BorderRadius.circular(10)),
              child: selectedVariant != null
                  ? CachedNetworkImage(
                      imageUrl: selectedVariant.images.first,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/bag_img.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 300,
              child: Align(
                alignment: Alignment.centerLeft, // Align everything to the left
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Align items to the start of the column
                  children: [
                    Text(
                      widget.cartModel?.product != null
                          ? product!.name
                          : "The Rainbow Unicorn - Gift Bags",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.brawler(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color.fromRGBO(79, 79, 79, 1),
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (widget.isCart)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Quantity",
                            style: GoogleFonts.brawler(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          InkWell(
                            onTap: () {
                              Get.find<HomeCtrl>().updateQty(
                                widget.cartModel.productId,
                                selectedVariant!.id,
                                false,
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(
                                CupertinoIcons.minus,
                                color: Color(0xff828282),
                                size: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: TextFormField(
                              controller: qtyCtrl,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: GoogleFonts.poppins(
                                color: const Color(0xff6C6C6C),
                                fontSize: 12,
                              ),
                              onTapOutside: (value) {
                                if (qtyCtrl.text.isEmpty)
                                  qtyCtrl.text =
                                      widget.cartModel?.qty.toString() ?? "1";
                              },
                              onChanged: (value) {
                                if (value.trim().isNotEmpty) {
                                  final item = Get.find<HomeCtrl>()
                                      .cartItems
                                      .firstWhereOrNull(
                                        (element) =>
                                            element.productId ==
                                                widget.cartModel.productId &&
                                            element.vId == selectedVariant!.id,
                                      );
                                  if (item != null) {
                                    item.qty = int.tryParse(value) ?? 1;
                                  }
                                  Get.find<HomeCtrl>().updateDBCart();
                                }
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.find<HomeCtrl>().updateQty(
                                widget.cartModel.productId,
                                selectedVariant!.id,
                                true,
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(
                                CupertinoIcons.add,
                                color: Color(0xff828282),
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (!widget.isCart)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Quantity",
                            style: GoogleFonts.brawler(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 50,
                            child: Text(
                              widget.cartModel?.qty.toString() ?? "1",
                              //textAlign: TextAlign.center,
                              style: GoogleFonts.brawler(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8),
                    Text(
                      product != null &&
                              selectedVariant != null &&
                              selectedVariant.priceType ==
                                  PriceTypeModel.fixedPrice
                          ? "₹ ${selectedVariant.fixedPrice}"
                          : "${selectedVariant?.priceRange[0]}",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.brawler(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         InkWell(
          //             onTap: () {
          //               Get.find<HomeCtrl>().updateQty(
          //                 widget.cartModel.productId, selectedVariant!.id, false);
          //               // qty--;
          //               // qtyController.text = qty.toString();
          //               //setState(() {});
          //             },
          //             child: const Padding(
          //               padding: EdgeInsets.all(16.0),
          //               child: Icon(
          //                 CupertinoIcons.minus,
          //                 color: Color(0xff828282),
          //                 size: 15,
          //               ),
          //             )),
          //         // const SizedBox(width: 10),
          //         SizedBox(
          //           width: 50,
          //           child: TextFormField(
          //             controller: qtyCtrl,
          //             textAlign: TextAlign.center,
          //             keyboardType: TextInputType.number,
          //             decoration: const InputDecoration(
          //               border: InputBorder.none,
          //               contentPadding: EdgeInsets.zero,
          //             ),
          //             style: GoogleFonts.poppins(
          //               color: const Color(0xff6C6C6C),
          //               fontSize: 12,
          //             ),
          //             onTapOutside:(value){
          //               if(qtyCtrl.text.isEmpty)qtyCtrl.text = widget.cartModel?.qty.toString()??"1";
          //             },
          //             onChanged: (value) {
          //               if (value.trim().isNotEmpty) {
          //                 final item = Get.find<HomeCtrl>().cartItems.firstWhereOrNull(
          //                     (element) =>
          //                         element.productId == widget.cartModel.productId &&
          //                         element.vId == selectedVariant!.id);
          //                 if (item != null) {
          //                   item.qty = int.tryParse(value) ?? 1;
          //                 }
          //                 Get.find<HomeCtrl>().updateDBCart();
          //               }
          //               // setState(() {
          //               //   qty = int.tryParse(value) ?? qty;z
          //               // });
          //             },
          //           ),
          //         ),
          //         // const SizedBox(width: 10),
          //         InkWell(
          //           onTap: () {
          //             Get.find<HomeCtrl>().updateQty(
          //                 widget.cartModel.productId, selectedVariant!.id, true);
          //             // qty++;
          //             // qtyController.text = qty.toString();
          //             // setState(() {});
          //           },
          //           child: const Padding(
          //             padding: EdgeInsets.all(16.0),
          //             child: Icon(
          //               CupertinoIcons.add,
          //               color: Color(0xff828282),
          //               size: 15,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),

          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text("Tax: ₹${productTax}"),
                const SizedBox(width: 8),
                Tooltip(
                  message: "Tax Rate: ${widget.cartModel.product!.tax}%",
                  child: Icon(Icons.info_outline, size: 16, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text("Total: ₹${productTotal}"),
          ]),

          SizedBox(
            width: 20,
          ),
          if (widget.isCart)
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.delete,
                  size: 25,
                  color: Color(0xff961810),
                )),
        ],
      ),
    );
  }

// @override
//   void initState() {
//     super.initState();
// qtyCtrl.text = widget.cartModel?.qty.toString()??"1";
//   }
}
