import 'dart:async';
// import 'dart:ui' as html;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudarshan_creations/controller/home_controller.dart';
import 'package:sudarshan_creations/models/cartitems_model.dart';
import 'package:sudarshan_creations/models/product_model.dart';
import 'package:sudarshan_creations/models/variants_model.dart';
import 'package:sudarshan_creations/shared/const.dart';
import 'package:sudarshan_creations/shared/firebase.dart';
import 'package:sudarshan_creations/shared/methods.dart';
import 'package:sudarshan_creations/shared/responsive.dart';
import 'package:sudarshan_creations/views/sudarshan_homepage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../shared/router.dart';
import 'widgets/footer.dart';
import 'widgets/product_bag.dart';
import 'widgets/top_appbar.dart';
import 'wrapper.dart';
import 'dart:js' as js;

final _productScafKey = GlobalKey<ScaffoldState>();

class SudarshanProductDetails extends StatefulWidget {
  const SudarshanProductDetails({super.key, this.productId});
  final String? productId;

  @override
  State<SudarshanProductDetails> createState() =>
      _SudarshanProductDetailsState();
}

class _SudarshanProductDetailsState extends State<SudarshanProductDetails> {
  // List<String> qunatitySet = [
  //   'Set of 5 pieces',
  //   'Set of 10 pieces',
  //   'Set of 15 pieces'
  // ];
  // List<String> personalize = ['Personlised', 'Non-Personlised'];
  String? uid;
  int qty = 1;
  final TextEditingController qtyController = TextEditingController();
  // UserModel? user;
  VariantModel? selectedVariant;
  TextEditingController quantityController = TextEditingController();
  List<ProductModel> similarProducts = [];

  //
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? productSream;
  ProductModel? product;
  bool loaded = false;
  bool isFavourites = false;
  //

  setProductStream() async {
    try {
      productSream?.cancel();
      productSream = FBFireStore.products
          .doc(widget.productId)
          .snapshots()
          .listen((event) async {
        if (!event.exists) return;
        product = ProductModel.fromDocSnap(event);
        selectedVariant = selectedVariant ??
            product?.variants.firstWhere(
              (element) => element.defaultt,
            );

        await getRelatedProducts();
        // await getUser();
        loaded = true;
        setState(() {});
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    setProductStream();
    // qtyController.text = qty.toString();
  }

  getRelatedProducts() async {
    if (loaded) return;
    similarProducts.clear();
    final tempProd = await FBFireStore.products.doc(widget.productId).get();
    ProductModel tProd = ProductModel.fromDocSnap(tempProd);
    final productSnap = await FBFireStore.products
        .where('subCatDocId', isEqualTo: tProd.subCatDocId)
        .limit(4)
        .get();
    similarProducts.addAll(
      productSnap.docs
          .where((e) =>
              e.id !=
              product
                  ?.docId) // Filter out products where docId matches productId
          .map((e) => ProductModel.fromSnap(e))
          .toList(),
    );
  }

  showContactDialog(
      BuildContext context, VariantModel variant, ProductModel product) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Inquiry'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String phone = phoneController.text;
                String email = emailController.text;
                String description = descriptionController.text;

                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // checkFavourites();
    if (!loaded) return const Center(child: CircularProgressIndicator());

    //getRelatedProducts();
    // checkFavourites();
    //variantModel? selectedVariantMinPrice;
    // final selectedVariant = selectedVariant ??
    //     product?.variants.firstWhere(
    //       (element) => element.defaultt,
    //     );

    // if (selectedVariant?.priceType == PriceTypeModel.priceRange) {
    //   selectedVariant?.priceRange.sort(
    //     (a, b) => a.price.compareTo(b.price),
    //   );
    //   //selectedVariantMinPrice = selectedVariant?.priceRange[0].price;
    // }
    // List<CartModel>? existingCart = user?.cartItems;

    // int existingItemIndex =
    //     existingCart?.indexWhere((item) => item.id == selectedVariant?.id) ?? -1;

    // if (existingItemIndex != -1) {
    //   qty = existingCart?[existingItemIndex].qty ?? 1;
    // }

    //print(filteredProducts.length);

    return product != null && selectedVariant != null && loaded
        ? GetBuilder<HomeCtrl>(builder: (hctrl) {
            qty = hctrl.cartItems
                    .firstWhereOrNull((element) =>
                        element.productId == widget.productId &&
                        element.vId == selectedVariant!.id)
                    ?.qty ??
                1;
            qtyController.text = qty.toString();

            return ResponsiveWid(
              mobile: Wrapper(
                scafkey: _productScafKey,
                // backgroundColor: const Color(0xffFEF7F3),
                body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      // const TopAppBarWithBgImg(mobile: true),
                      // const Divider(
                      //   color: Color(0xff95170D),
                      //   height: 0,
                      //   thickness: .5,
                      // ),
                      Container(
                          // color: Colors.black.withAlpha(100),
                          // color: const Color(0xff151b27),
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
                                color: Colors.grey,
                                thickness: 0.5,
                                height: 0,
                              ),
                              // SizedBox(height: 20),
                              // NavBar(),
                            ],
                          )),
                      // const SizedBox(height: 10),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        constraints: BoxConstraints(
                            maxWidth: 1200,
                            // min height = screen height - appbar height - footer height - in b/w sizedbox heights
                            minHeight: MediaQuery.sizeOf(context).height -
                                135 -
                                200 -
                                10),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ImageBoxMobile(
                                    variant: selectedVariant!,

                                    // variantImages: selectedVariant!.images,
                                  ),
                                  const SizedBox(height: 30),
                                  _productDetails(hctrl, context)
                                  /*    
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                product?.name ?? "",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.brawler(
                                                    height: 0,
                                                    color: const Color(0xff4F4F4F),
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            IconButton(
                                                onPressed: () async {
                                                  //mark favourite
                                                },
                                                icon: const Icon(
                                                  CupertinoIcons.heart,
                                                  size: 25,
                                                  color: Color(0xff961810),
                                                ))
                                          ],
                                        ),
                                        if (selectedVariant.priceType !=
                                            PriceTypeModel.inquiry)
                                          const SizedBox(height: 20),
                                        if (selectedVariant.priceType ==
                                            PriceTypeModel.fixedPrice)
                                          Text.rich(TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    '₹${selectedVariant.fixedPrice}',
                                                style: GoogleFonts.poppins(
                                                  color: const Color(0xff4F4F4F),
                                                  fontSize: 22,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                            // const TextSpan(text: '  '),
                                            // TextSpan(
                                            //     text: '₹100.00',
                                            //     style: GoogleFonts.leagueSpartan(
                                            //       color: const Color(0xff828282),
                                            //       fontSize: 18,
                                            //       decoration: TextDecoration.lineThrough,
                                            //     )),
                                          ])),
                                        if (selectedVariant.priceType ==
                                            PriceTypeModel.priceRange)
                                          Text.rich(TextSpan(children: [
                                            TextSpan(
                                                text: 'Starting at ',
                                                style: GoogleFonts.poppins(
                                                  color: const Color(0xff4F4F4F),
                                                  fontSize: 18,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                            TextSpan(
                                                text:
                                                    '₹${selectedVariant.priceRange[0].price}',
                                                style: GoogleFonts.poppins(
                                                  color: const Color(0xff4F4F4F),
                                                  fontSize: 22,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ])),
                                        if (selectedVariant.priceType !=
                                            PriceTypeModel.inquiry)
                                          const SizedBox(height: 8),
                                        if (selectedVariant.priceType ==
                                            PriceTypeModel.priceRange)
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: const Color(
                                                    0xfff9ece0), //Choose appropriate color here
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: Tooltip(
                                              message: "Show Price Ranges",
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'For a minimum quantity ${selectedVariant.priceRange[0].startQty}',
                                                    style:
                                                        GoogleFonts.leagueSpartan(
                                                      height: 0,
                                                      color:
                                                          const Color(0xff828282),
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const Icon(
                                                    CupertinoIcons.chevron_right,
                                                    size: 15,
                                                    color: Color(0xff828282),
                                                  )
                                                  // IconButton(
                                                  //   onPressed: () {
                                                  //     // Show ranges table
                                                  //   },
                                                  //   icon: const Icon(
                                                  //     CupertinoIcons.info,
                                                  //     size: 18,
                                                  //     color:
                                                  //         Color(0xff828282),
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        if (selectedVariant.priceType !=
                                            PriceTypeModel.inquiry)
                                          const SizedBox(height: 8),
                                        if (selectedVariant.priceType !=
                                            PriceTypeModel.inquiry)
                                          Text(
                                            selectedVariant.available
                                                ? 'In Stock'
                                                : 'Out of Stock',
                                            style: GoogleFonts.leagueSpartan(
                                              color: const Color(0xff4F4F4F),
                                              fontSize: 14,
                                              // fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        const SizedBox(height: 30),
                                        Text(
                                          "Options:",
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xff828282),
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Wrap(
                                          spacing: 12,
                                          runSpacing: 15,
                                          alignment: WrapAlignment.start,
                                          runAlignment: WrapAlignment.start,
                                          children: [
                                            ...List.generate(
                                              product!.variants.length,
                                              (index) {
                                                final variant =
                                                    product!.variants[index];
                                                print(
                                                    "Filtered ${similarProducts.length}");
                                                String formattedString;
                                                formattedString = [
                                                  variant.material?.isNotEmpty ==
                                                          true
                                                      ? variant.material
                                                      : null,
                                                  variant.color?.isNotEmpty == true
                                                      ? variant.color
                                                      : null,
                                                  variant.size?.isNotEmpty == true
                                                      ? variant.size
                                                      : null
                                                ]
                                                    .where((element) =>
                                                        element != null)
                                                    .join('/');
                                                return InkWell(
                                                  hoverColor: Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  splashColor: Colors.transparent,
                                                  onTap: () {
                                                    selectedVariant = variant;
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      // color: Colors.white54,
                                                      borderRadius:
                                                          BorderRadius.circular(4),
                                                      border: Border.all(
                                                          width: .2,
                                                          color:
                                                              const Color.fromARGB(
                                                                  255,
                                                                  161,
                                                                  161,
                                                                  161)),
                                                    ),
                                                    child: ListTile(
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 8),
                                                      minVerticalPadding: 8,
                                                      leading: Container(
                                                        height: 100,
                                                        // width: 50,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: Image.network(
                                                          variant.images.first,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
            
                                                      // minLeadingWidth: 50,
                                                      title: Text(
                                                        formattedString,
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500),
                                                      ),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          if (variant.priceType !=
                                                              PriceTypeModel
                                                                  .inquiry)
                                                            Text(
                                                              "₹${variant.fixedPrice}", //Assume that pricerange variant also has a fixed price.
                                                              style: const TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        ExpansionTile(
                                          // backgroundColor: Colors.transparent,
                                          // collapsedBackgroundColor: Colors.transparent,
                                          tilePadding: EdgeInsets.zero,
                                          title: Text(
                                            'Description',
                                            style: GoogleFonts.poppins(
                                                color: const Color(0xff4F4F4F),
                                                fontSize: 15),
                                          ),
                                          iconColor: const Color(0xff4F4F4F),
                                          shape: const RoundedRectangleBorder(
                                              side: BorderSide.none),
                                          childrenPadding: EdgeInsets.zero,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Divider(
                                                    color: Color(0xffDADADA),
                                                    thickness: .6),
                                                const SizedBox(height: 7),
                                                Text(
                                                  product!.description,
                                                  /*  "Quisque sed nulla gravida leo volutpat aliquam nec quis eros. Donec sed eros venenatis, rhoncus mauris ac, viverra ipsum. Sed suscipit est in dui molestie dapibus. Pellentesque id nunc sem. Nulla enim sem, pretium eget eleifend vel, tempus a risus. Vestibulum et sem id est posuere pellentesque. Quisque non neque odio. Curabitur molestie nibh suscipit, euismod turpis at, tempus mauris. Aenean consequat ipsum vel orci fermentum volutpat. Vestibulum blandit nibh sed magna egestas, sed aliquam justo tincidunt. Fusce tincidunt, elit ut porta ullamcorper, ipsum enim rutrum dolor, non venenatis odio neque in quam. Morbi nunc quam, viverra vitae ex id, venenatis sagittis quam. Interdum et malesuada fames ac ante ipsum primis in faucibus. Cras hendrerit fringilla magna quis feugiat. Nulla molestie mauris at eros porta, ac aliquet enim viverra. Mauris ac nulla lorem.",
                                                   */
                                                  style: GoogleFonts.poppins(
                                                      height: 1.7,
                                                      fontSize: 12,
                                                      color:
                                                          const Color(0xff4F4F4F)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                            color: Color(0xffDADADA),
                                            thickness: .6),
                                        ExpansionTile(
                                          tilePadding: EdgeInsets.zero,
                                          title: Text(
                                            'Details',
                                            style: GoogleFonts.poppins(
                                                color: const Color(0xff4F4F4F),
                                                fontSize: 15),
                                          ),
                                          iconColor: const Color(0xff4F4F4F),
                                          shape: const RoundedRectangleBorder(
                                              side: BorderSide.none),
                                          childrenPadding: EdgeInsets.zero,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Divider(
                                                    color: Color(0xffDADADA),
                                                    thickness: .6),
                                                const SizedBox(height: 7),
                                                Text(
                                                  selectedVariant.description,
                                                  /* 
                                                  "Quisque sed nulla gravida leo volutpat aliquam nec quis eros. Donec sed eros venenatis, rhoncus mauris ac, viverra ipsum. Sed suscipit est in dui molestie dapibus. Pellentesque id nunc sem. Nulla enim sem, pretium eget eleifend vel, tempus a risus. Vestibulum et sem id est posuere pellentesque. Quisque non neque odio. Curabitur molestie nibh suscipit, euismod turpis at, tempus mauris. Aenean consequat ipsum vel orci fermentum volutpat. Vestibulum blandit nibh sed magna egestas, sed aliquam justo tincidunt. Fusce tincidunt, elit ut porta ullamcorper, ipsum enim rutrum dolor, non venenatis odio neque in quam. Morbi nunc quam, viverra vitae ex id, venenatis sagittis quam. Interdum et malesuada fames ac ante ipsum primis in faucibus. Cras hendrerit fringilla magna quis feugiat. Nulla molestie mauris at eros porta, ac aliquet enim viverra. Mauris ac nulla lorem.",
                                                  */
                                                  style: GoogleFonts.poppins(
                                                      height: 1.7,
                                                      fontSize: 12,
                                                      color:
                                                          const Color(0xff4F4F4F)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                            color: Color(0xffDADADA),
                                            thickness: .6),
                                        /*
                                        ExpansionTile(
                                          tilePadding: EdgeInsets.zero,
                                          title: Text(
                                            'Customization',
                                            style: GoogleFonts.poppins(
                                                color: const Color(0xff4F4F4F),
                                                fontSize: 15),
                                          ),
                                          iconColor: const Color(0xff4F4F4F),
                                          shape: const RoundedRectangleBorder(
                                              side: BorderSide.none),
                                          childrenPadding: EdgeInsets.zero,
                                          children: [
                                            Column(
                                              children: [
                                                const Divider(
                                                    color: Color(0xffDADADA),
                                                    thickness: .6),
                                                const SizedBox(height: 7),
                                                Text(
                                                  "Quisque sed nulla gravida leo volutpat aliquam nec quis eros. Donec sed eros venenatis, rhoncus mauris ac, viverra ipsum. Sed suscipit est in dui molestie dapibus. Pellentesque id nunc sem. Nulla enim sem, pretium eget eleifend vel, tempus a risus. Vestibulum et sem id est posuere pellentesque. Quisque non neque odio. Curabitur molestie nibh suscipit, euismod turpis at, tempus mauris. Aenean consequat ipsum vel orci fermentum volutpat. Vestibulum blandit nibh sed magna egestas, sed aliquam justo tincidunt. Fusce tincidunt, elit ut porta ullamcorper, ipsum enim rutrum dolor, non venenatis odio neque in quam. Morbi nunc quam, viverra vitae ex id, venenatis sagittis quam. Interdum et malesuada fames ac ante ipsum primis in faucibus. Cras hendrerit fringilla magna quis feugiat. Nulla molestie mauris at eros porta, ac aliquet enim viverra. Mauris ac nulla lorem.",
                                                  style: GoogleFonts.poppins(
                                                      height: 1.7,
                                                      fontSize: 12,
                                                      color:
                                                          const Color(0xff4F4F4F)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ), */
                                      ],
                                    ),
                                   
                                    */

                                  /* const SizedBox(width: 30),
                                  // Spacer(),
                                  SizedBox(
                                    width: 150,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          List<String> imgList = [
                                            'assets/bag_img.png',
                                            'assets/bag_img2.png',
                                            'assets/bag_img3.png',
                                            'assets/bag_img4.png'
                                          ];
                                          bool isSelected = index == selectedVariant;
                                          return Stack(
                                            children: [
                                              InkWell(
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                splashColor: Colors.transparent,
                                                onTap: () {
                                                  selectedVariant = index;
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  height: 140,
                                                  width: 100,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(5)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(5)),
                                                        clipBehavior: Clip.antiAlias,
                                                        child: Image.asset(
                                                          imgList[index],
                                                          fit: BoxFit.fitWidth,
                                                        ),
                                                      ),
                                                      const Text("₹150/pc")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              if (isSelected)
                                                Container(
                                                  height: 140,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white54,
                                                      borderRadius:
                                                          BorderRadius.circular(4)),
                                                  child: const Center(
                                                      child: Icon(
                                                    CupertinoIcons.checkmark_alt_circle,
                                                    size: 30,
                                                    color: Color(0xff95170D),
                                                  )),
                                                ),
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(height: 15);
                                        },
                                        itemCount: 4),
                                  ), */
                                ],
                              ),
                            ),
                            const SizedBox(height: 50),
                            Text(
                              "SIMILAR PRODUCTS",
                              style: GoogleFonts.brawler(
                                  fontSize: 28, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 30),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  ...List.generate(
                                    similarProducts.length,
                                    (index) {
                                      final suggestionProduct =
                                          similarProducts[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 25.0),
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 264),
                                          child: InkWell(
                                            highlightColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              context.go(
                                                  "${Routes.product}/${suggestionProduct.docId}");
                                            },
                                            child: ProductBagWid(
                                                product: suggestionProduct,
                                                forHome: false),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                      const SudarshanFooterSection(),
                    ],
                  ),
                ),
              ),
              desktop: Wrapper(
                scafkey: _productScafKey,
                // backgroundColor: const Color(0xffFEF7F3),
                body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      // const TopAppBarWithBgImg(mobile: false),
                      // const Divider(color: Color(0xff95170D), height: 0),
                      Container(
                        // color: Colors.black.withAlpha(100),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/banner1.png'),
                              fit: BoxFit.cover),
                          color: Color(0xff151b27),
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
                            // SizedBox(height: 20),
                            // NavBar(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 25),
                        constraints: BoxConstraints(
                            maxWidth: 1200,
                            // min height = screen height - appbar height - footer height - in b/w sizedbox heights
                            minHeight: MediaQuery.sizeOf(context).height -
                                80 -
                                70 -
                                20),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  // flex: 2,
                                  child: ImageBox(
                                    variant: selectedVariant!,
                                    variantImages: selectedVariant!.images,
                                  ),
                                ),
                                const SizedBox(width: 50),
                                Expanded(
                                  // flex: 2,
                                  child: _productDetails(hctrl, context),
                                ),
                              ],
                            ),
                            const SizedBox(height: 50),
                            Text(
                              "SIMILAR PRODUCTS",
                              style: GoogleFonts.brawler(
                                  fontSize: 35, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 35),
                            StaggeredGrid.extent(
                              maxCrossAxisExtent: 300,
                              mainAxisSpacing: 25,
                              crossAxisSpacing: 25,
                              children: [
                                if (loaded)
                                  ...List.generate(
                                    similarProducts.length,
                                    (index) {
                                      final suggestionProduct =
                                          similarProducts[index];
                                      return InkWell(
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            context.go(
                                                "${Routes.product}/${suggestionProduct.docId}");
                                          },
                                          child: ProductBagWid(
                                              product: suggestionProduct,
                                              forHome: false));
                                    },
                                  )
                              ],
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                      const SudarshanFooterSection(),
                    ],
                  ),
                ),
              ),
            );
          })
        : const Center(
            child: Text("No Product Found"),
          );
  }

  Column _productDetails(HomeCtrl hctrl, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                product?.name ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.brawler(
                    height: 0,
                    color: const Color(0xff4F4F4F),
                    fontSize: 35,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 5),
            hctrl.isFavourite(widget.productId!, selectedVariant!.id)
                ? IconButton(
                    onPressed: () async {
                      isLoggedIn()
                          ? await FBFireStore.users
                              .doc(FBAuth.auth.currentUser?.uid)
                              .update({
                              'favourites': FieldValue.arrayRemove([
                                '${widget.productId}/${selectedVariant!.id}'
                              ]),
                            })
                          : context.go(Routes.favourites);
                      // checkFavourites();
                      // setState(() {});
                    },
                    icon: const Icon(
                      CupertinoIcons.heart_fill,
                      size: 25,
                      color: Color(0xff961810),
                    ))
                : IconButton(
                    onPressed: () async {
                      isLoggedIn()
                          ? await FBFireStore.users
                              .doc(FBAuth.auth.currentUser?.uid)
                              .update({
                              'favourites': FieldValue.arrayUnion([
                                '${widget.productId}/${selectedVariant!.id}'
                              ]),
                            })
                          : context.go(Routes.favourites,
                              extra: appRouter
                                  .routeInformationProvider.value.uri.path);
                      // checkFavourites();
                      // setState(() {});
                    },
                    icon: const Icon(
                      CupertinoIcons.heart,
                      size: 25,
                      color: Color(0xff961810),
                    ))
          ],
        ),
        /* if (selectedVariant!.priceType != PriceTypeModel.inquiry)
          const SizedBox(height: 20),
        if (selectedVariant!.priceType == PriceTypeModel.fixedPrice)
          Text.rich(TextSpan(children: [
            TextSpan(
                text: '₹${selectedVariant!.fixedPrice}',
                style: GoogleFonts.poppins(
                  color: const Color(0xff4F4F4F),
                  fontSize: 22,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                )),
          ])),
        if (selectedVariant!.priceType == PriceTypeModel.priceRange)
          Text.rich(TextSpan(children: [
            TextSpan(
                text: 'Starting at ',
                style: GoogleFonts.poppins(
                  color: const Color(0xff4F4F4F),
                  fontSize: 18,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                )),
            TextSpan(
                text: '₹${selectedVariant!.priceRange[0].price}',
                style: GoogleFonts.poppins(
                  color: const Color(0xff4F4F4F),
                  fontSize: 22,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                )),
          ])),
        if (selectedVariant!.priceType != PriceTypeModel.inquiry)
          const SizedBox(height: 8),
        if (selectedVariant!.priceType == PriceTypeModel.priceRange)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: const Color(0xfff9ece0), //Choose appropriate color here
                borderRadius: BorderRadius.circular(7)),
            child: Tooltip(
              message: "Show Price Ranges",
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'For a minimum quantity ${selectedVariant!.priceRange[0].startQty}',
                    style: GoogleFonts.leagueSpartan(
                      height: 0,
                      color: const Color(0xff828282),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    CupertinoIcons.chevron_right,
                    size: 15,
                    color: Color(0xff828282),
                  )
                  // IconButton(
                  //   onPressed: () {
                  //     // Show ranges table
                  //   },
                  //   icon: const Icon(
                  //     CupertinoIcons.info,
                  //     size: 18,
                  //     color:
                  //         Color(0xff828282),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        if (selectedVariant!.priceType != PriceTypeModel.inquiry)
          const SizedBox(height: 8),
        if (selectedVariant!.priceType != PriceTypeModel.inquiry)
          Text(
            selectedVariant!.available ? 'In Stock' : 'Out of Stock',
            style: GoogleFonts.leagueSpartan(
              color: const Color(0xff4F4F4F),
              fontSize: 14,
              // fontWeight: FontWeight.w600,
            ),
          ), */
        const SizedBox(height: 30),
        Text(
          "Options:",
          style: GoogleFonts.poppins(
            color: const Color(0xff828282),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 15,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: [
            ...List.generate(
              product!.variants.length,
              (index) {
                final variant = product!.variants[index];
                String formattedString;
                formattedString = [
                  variant.material?.isNotEmpty == true
                      ? variant.material
                      : null,
                  variant.color?.isNotEmpty == true ? variant.color : null,
                  variant.size?.isNotEmpty == true ? variant.size : null
                ].where((element) => element != null).join('/');
                return InkWell(
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    selectedVariant = variant;
                    setState(() {});
                  },
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        // color: Colors.white54,
                        borderRadius: BorderRadius.circular(4),
                        border: selectedVariant!.id == variant.id
                            ? Border.all(
                                width: 2, color: const Color(0xff95170D))
                            : Border.all(
                                width: .2,
                                color:
                                    const Color.fromARGB(255, 161, 161, 161))),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      minVerticalPadding: 8,
                      leading: Container(
                        height: 100,
                        // width: 50,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.network(
                          variant.images.first,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // minLeadingWidth: 50,
                      title: Text(
                        formattedString,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (variant.priceType != PriceTypeModel.inquiry)
                            Text(
                              "₹${variant.fixedPrice}", //Assume that pricerange variant also has a fixed price.
                              style: const TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w500),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
        const SizedBox(height: 20),
        /*  if (selectedVariant!.priceType != PriceTypeModel.inquiry)
          if (hctrl.isInCart(widget.productId!, selectedVariant!.id))
            Text(
              "Quantity:",
              style: GoogleFonts.poppins(
                color: const Color(0xff828282),
                fontSize: 14,
              ),
            ),
        if (selectedVariant!.priceType != PriceTypeModel.inquiry)
          const SizedBox(height: 10),
        if (selectedVariant!.priceType != PriceTypeModel.inquiry)
          if (hctrl.isInCart(widget.productId!, selectedVariant!.id))
            Container(
              height: 47,
              // padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffE0E0E0)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                      onTap: () {
                        if (qty == 1) return;
                        hctrl.updateQty(
                            widget.productId!, selectedVariant!.id, false);
                        // qty--;
                        // qtyController.text = qty.toString();

                        //setState(() {});
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(
                          CupertinoIcons.minus,
                          color: Color(0xff828282),
                          size: 15,
                        ),
                      )),
                  // const SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      controller: qtyController,
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
                      onChanged: (value) {
                        if (value.trim().isNotEmpty) {
                          final item = hctrl.cartItems.firstWhereOrNull(
                              (element) =>
                                  element.productId == widget.productId &&
                                  element.vId == selectedVariant!.id);
                          if (item != null) {
                            item.qty = int.tryParse(value) ?? 1;
                          }
                          hctrl.updateDBCart();
                        }
                        // setState(() {
                        //   qty = int.tryParse(value) ?? qty;z
                        // });
                      },
                    ),
                  ),
                  // const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      hctrl.updateQty(
                          widget.productId!, selectedVariant!.id, true);
                      // qty++;
                      // qtyController.text = qty.toString();
                      // setState(() {});
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
            ),
        if (selectedVariant!.priceType != PriceTypeModel.inquiry)
          const SizedBox(height: 25),
        if (selectedVariant!.priceType != PriceTypeModel.inquiry)
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: const Color(0xff535353),
                        surfaceTintColor: const Color(0xff535353),
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      onPressed: () async {
                        if (isLoggedIn()) {
                          hctrl.isInCart(widget.productId!, selectedVariant!.id)
                              ? hctrl.removeFromCart(
                                  widget.productId!, selectedVariant!.id)
                              : hctrl.addToCart(CartModel(
                                  id: getRandomId(6),
                                  productId: widget.productId!,
                                  vId: selectedVariant!.id,
                                  qty: qty));
                          setState(() {});
                        }
                        if (!isLoggedIn()) {
                          context.go(Routes.favourites,
                              extra: appRouter
                                  .routeInformationProvider.value.uri.path);
                        }
                      },
                      child: Text(
                        hctrl.isInCart(widget.productId!, selectedVariant!.id)
                            ? "Remove from cart"
                            : "Add to cart",
                        style: GoogleFonts.leagueSpartan(
                            color: Colors.white, fontSize: 15),
                      ))),
              const SizedBox(width: 15),
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: const Color(0xff95170D),
                        surfaceTintColor: const Color(0xff95170D),
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Buy Now",
                        style: GoogleFonts.leagueSpartan(
                            color: Colors.white, fontSize: 15),
                      ))),
            ],
          ),
        */
        // if (selectedVariant!.priceType == PriceTypeModel.inquiry)
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color(0xff95170D),
                  surfaceTintColor: const Color(0xff95170D),
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                onPressed: () {
                  // showContactDialog(context, selectedVariant!, product!);

                  try {
                    final url =
                        "$chatLink?text=${Uri.encodeComponent(Uri.base.toString())}";

                    js.context.callMethod("open", [url, "_blank"]);
                    // html.window.open(url, "_self");
                    // launchUrl(Uri.parse('$chatLink?text=${Uri.base}\n'));
                    // launchUrl(
                    //   Uri.parse(
                    //       '$chatLink?text=${Uri.encodeComponent(Uri.base.toString())}\n'),
                    //   webOnlyWindowName: '_blank', // optional
                    // );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      "${e.toString()}: Failed to open chat. Please try again later.",
                    )));
                  }
                },
                child: Text(
                  "Send Inquiry",
                  style: GoogleFonts.leagueSpartan(
                      color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ExpansionTile(
          // backgroundColor: Colors.transparent,
          // collapsedBackgroundColor: Colors.transparent,
          tilePadding: EdgeInsets.zero,
          title: Text(
            'Description',
            style: GoogleFonts.poppins(
                color: const Color(0xff4F4F4F), fontSize: 15),
          ),
          iconColor: const Color(0xff4F4F4F),
          shape: const RoundedRectangleBorder(side: BorderSide.none),
          childrenPadding: EdgeInsets.zero,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: Color(0xffDADADA), thickness: .6),
                const SizedBox(height: 7),
                Text(
                  product!.description,
                  //"Quisque sed nulla gravida leo volutpat aliquam nec quis eros. Donec sed eros venenatis, rhoncus mauris ac, viverra ipsum. Sed suscipit est in dui molestie dapibus. Pellentesque id nunc sem. Nulla enim sem, pretium eget eleifend vel, tempus a risus. Vestibulum et sem id est posuere pellentesque. Quisque non neque odio. Curabitur molestie nibh suscipit, euismod turpis at, tempus mauris. Aenean consequat ipsum vel orci fermentum volutpat. Vestibulum blandit nibh sed magna egestas, sed aliquam justo tincidunt. Fusce tincidunt, elit ut porta ullamcorper, ipsum enim rutrum dolor, non venenatis odio neque in quam. Morbi nunc quam, viverra vitae ex id, venenatis sagittis quam. Interdum et malesuada fames ac ante ipsum primis in faucibus. Cras hendrerit fringilla magna quis feugiat. Nulla molestie mauris at eros porta, ac aliquet enim viverra. Mauris ac nulla lorem.",
                  style: GoogleFonts.poppins(
                      height: 1.7,
                      fontSize: 12,
                      color: const Color(0xff4F4F4F)),
                ),
              ],
            ),
          ],
        ),
        const Divider(color: Color(0xffDADADA), thickness: .6),
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Text(
            'Details',
            style: GoogleFonts.poppins(
                color: const Color(0xff4F4F4F), fontSize: 15),
          ),
          iconColor: const Color(0xff4F4F4F),
          shape: const RoundedRectangleBorder(side: BorderSide.none),
          childrenPadding: EdgeInsets.zero,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: Color(0xffDADADA), thickness: .6),
                const SizedBox(height: 7),
                Text(
                  selectedVariant!.description,
                  style: GoogleFonts.poppins(
                      height: 1.7,
                      fontSize: 12,
                      color: const Color(0xff4F4F4F)),
                ),
              ],
            ),
          ],
        ),
        const Divider(color: Color(0xffDADADA), thickness: .6),
      ],
    );
  }
}

// class TopAppBaarWithBgImgMobile extends StatelessWidget {
//   const TopAppBaarWithBgImgMobile({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100,
//       child: Stack(
//         children: [
//           Image.asset(
//             'assets/top_bg_img.png',
//             width: double.maxFinite,
//             height: double.maxFinite,
//             fit: BoxFit.cover,
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//             child: TopAppBarMobile(),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ImageBoxMobile extends StatefulWidget {
  const ImageBoxMobile({
    super.key,
    required this.variant,
    this.vertical = true,
  });

  final VariantModel variant;
  final bool vertical;

  @override
  State<ImageBoxMobile> createState() => _ImageBoxMobileState();
}

class _ImageBoxMobileState extends State<ImageBoxMobile> {
  // late String? selectedImg;
  @override
  void initState() {
    super.initState();
    // selectedImg =
    //     widget.variant.images.isEmpty ? null : widget.variant.images.first;
  }

  // resetImageIf() {
  //   if (widget.variant.images.contains(selectedImg)) return;
  //   selectedImg =
  //       widget.variant.images.isEmpty ? null : widget.variant.images.first;
  // }
  RxInt currentIndex = 0.obs;
  CarouselSliderController carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: size.height * .84),
          child: Row(
            children: [
              Expanded(
                child: CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    autoPlay: false,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) =>
                        currentIndex.value = index,
                    aspectRatio: imageAspectRatio,
                    scrollPhysics: widget.variant.images.length == 1
                        ? const NeverScrollableScrollPhysics()
                        : const BouncingScrollPhysics(),
                  ),
                  items: widget.variant.images.map((i) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) => ZoomPopup(
                              variant: widget.variant,
                              selectedIndex: widget.variant.images.indexOf(i)),
                        );
                      },
                      child: FadeInImage.memoryNetwork(
                        width: size.width,
                        height: size.height,
                        fit: BoxFit.cover,
                        placeholder: kTransparentImage,
                        image: i,
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.memory(kTransparentImage),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 1,
          left: 1,
          right: 1,
          // alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 20),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(
                      widget.variant.images.length,
                      (index) => InkWell(
                            onTap: () =>
                                carouselController.animateToPage(index),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.circle,
                                color: currentIndex.value == index
                                    ? Colors.red
                                    : Colors.grey,
                                size: currentIndex.value == index ? 14 : 12,
                              ),
                            ),
                          )),
                )),
          ),
        ),
        /*   Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => ZoomPopup(
                    variant: widget.variant, selectedIndex: currentIndex.value),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.add,
                    size: 30,
                    color: Colors.red,
                  ),
                  Text(
                    "CLICK\nTO ZOOM",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ),
      */
      ],
    );
    /*  return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.variant.images.length,
      itemBuilder: (context, index) {
        return AspectRatio(
          aspectRatio: imageAspectRatio,
          child: FadeInImage.memoryNetwork(
            width: size.width,
            height: size.height,
            placeholder: kTransparentImage,
            image: widget.variant.images[index],
            imageErrorBuilder: (context, error, stackTrace) =>
                Image.memory(kTransparentImage),
          ),
        );
      },
    ); */
    // resetImageIf();
    /*   return widget.vertical
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _thumbnails(),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _imageBox(context),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _imageBox(context),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _thumbnails(),
                ),
              ),
            ],
          ); */
  }

  /*  Widget _imageBox(BuildContext context) {
    return selectedImg == null
        ? Image.memory(kTransparentImage)
        : Stack(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.zoomIn,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) => ZoomPopup(
                          variant: widget.variant, selected: selectedImg!),
                    );
                  },
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: selectedImg!,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.memory(kTransparentImage),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.add,
                        size: 32,
                      ),
                      Text(
                        "CLICK\nTO ZOOM",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
  }

  List<Widget> _thumbnails() {
    return [
      ...List.generate(
          widget.variant.images.length,
          (index) => Container(
                decoration: BoxDecoration(
                    border: selectedImg == widget.variant.images[index]
                        ? Border.all(width: 2)
                        : null),
                child: InkWell(
                  onTap: () => setState(
                      () => selectedImg = widget.variant.images[index]),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.variant.images[index],
                    height: 160,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.memory(kTransparentImage),
                  ),
                ),
              ))
    ];
  }
 */
}

class ImageBox extends StatefulWidget {
  const ImageBox(
      {super.key, required this.variantImages, required this.variant});

  final List<String> variantImages;
  final VariantModel variant;

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  int currentIndex = 0;
  final carouselController = carousel.CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          spacing: 10,
          children: [
            ...List.generate(
              widget.variantImages.length,
              (index) {
                return InkWell(
                  onTap: () {
                    carouselController.animateToPage(index);
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  child: Container(
                    height: 150,
                    width: 100,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1.5,
                            color: currentIndex == index
                                ? const Color(0xff95170D)
                                : Colors.transparent)),
                    child: CachedNetworkImage(
                      imageUrl: widget.variantImages[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            )
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Container(
            // width: size.width,
            // height: size.height,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300)),
            child: Stack(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: size.height * .84),
                  child: Row(
                    children: [
                      Expanded(
                        child: carousel.CarouselSlider(
                          carouselController: carouselController,
                          options: carousel.CarouselOptions(
                            autoPlay: false,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) =>
                                currentIndex = index,
                            aspectRatio: 800 / 1200,
                            enableInfiniteScroll:
                                widget.variantImages.length > 1,
                            scrollPhysics: widget.variantImages.length == 1
                                ? const NeverScrollableScrollPhysics()
                                : const NeverScrollableScrollPhysics(),
                          ),
                          items: widget.variantImages.map((i) {
                            return InkWell(
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (context) => ZoomPopup(
                                      variant: widget.variant,
                                      selectedIndex:
                                          widget.variant.images.indexOf(i)),
                                );
                              },
                              child: Container(
                                width: size.width,
                                height: size.height,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl: i,
                                  fit: BoxFit.contain,
                                  // fit: BoxFit.fill,
                                ),
                              ),
                              // child: FadeInImage.memoryNetwork(
                              //   width: size.width,
                              //   height: size.height,
                              //   fit: BoxFit.cover,
                              //   placeholder: kTransparentImage,
                              //   image: i,
                              //   imageErrorBuilder: (context, error, stackTrace) =>
                              //       Image.memory(kTransparentImage),
                              // ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                /*  Positioned(
                  bottom: 1,
                  left: 1,
                  right: 1,
                  // alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 20),
                    child: Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(
                              widget.variantImages.length,
                              (index) => InkWell(
                                    onTap: () =>
                                        carouselController.animateToPage(index),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: currentIndex.value == index
                                                ? Border.all(
                                                    color:
                                                        const Color(0xff95170D),
                                                    width: 2.5)
                                                : null),
                                        child: const Icon(
                                          Icons.circle,
                                          color: Color(0xffEEEEEE),
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                  )),
                        )),
                  ),
                ),
               */
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ZoomPopup extends StatefulWidget {
  const ZoomPopup(
      {super.key, required this.variant, required this.selectedIndex});
  final VariantModel variant;
  final int selectedIndex;

  @override
  State<ZoomPopup> createState() => _ZoomPopupState();
}

class _ZoomPopupState extends State<ZoomPopup> {
  PageController? pageCtrl;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageCtrl = PageController(initialPage: widget.selectedIndex);
    currentIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Stack(
        children: [
          PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageCtrl,
            scrollDirection: Axis.horizontal,
            onPageChanged: (value) => setState(() {
              currentIndex = value;
            }),
            itemCount: widget.variant.images.length,
            itemBuilder: (BuildContext context, int index) {
              return _Viewer(img: widget.variant.images[index]);
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentIndex != 0
                    ? IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.transparent,
                        ),
                        onPressed: () => pageCtrl?.previousPage(
                            duration: const Duration(microseconds: 300),
                            curve: Curves.linear),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 26,
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox(),
                currentIndex != widget.variant.images.length - 1
                    ? IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.transparent,
                        ),
                        onPressed: () => pageCtrl?.nextPage(
                            duration: const Duration(microseconds: 300),
                            curve: Curves.linear),
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 26,
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              onPressed: () => context.pop(),
              icon: const Icon(
                CupertinoIcons.xmark,
                size: 28,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Viewer extends StatefulWidget {
  const _Viewer({required this.img});

  final String img;

  @override
  State<_Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<_Viewer> {
  TapDownDetails _doubleTapDetails = TapDownDetails();
  final viewTransformationController = TransformationController();

  @override
  void initState() {
    super.initState();
    // const zoomFactor = 2.0;
    // const xTranslate = 250.0;
    // const yTranslate = 300.0;
    // viewTransformationController.value.setEntry(0, 0, zoomFactor);
    // viewTransformationController.value.setEntry(1, 1, zoomFactor);
    // viewTransformationController.value.setEntry(2, 2, zoomFactor);
    // viewTransformationController.value.setEntry(0, 3, -xTranslate);
    // viewTransformationController.value.setEntry(1, 3, -yTranslate);
  }

  @override
  Widget build(BuildContext context) {
    /* Zoom commented below line */
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) {
    //     final size = MediaQuery.sizeOf(context);
    //     viewTransformationController.value = Matrix4.identity()
    //       ..translate(-size.width * .5, -size.height * .5)
    //       ..scale(2.0);
    //   },
    // );
    return InteractiveViewer(
      transformationController: viewTransformationController,
      child: InkWell(
        onTapDown: (d) => _doubleTapDetails = d,
        onTap: () {
          if (viewTransformationController.value != Matrix4.identity()) {
            viewTransformationController.value = Matrix4.identity();
          } else {
            final position = _doubleTapDetails.localPosition;
            viewTransformationController.value = Matrix4.identity()
              ..translate(-position.dx, -position.dy)
              ..scale(2.0);
          }
        },
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: widget.img,
          fit: BoxFit.contain,
          imageErrorBuilder: (context, error, stackTrace) =>
              Image.memory(kTransparentImage),
        ),
      ),
    );
  }
}
