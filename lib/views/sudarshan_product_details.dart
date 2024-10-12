import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudarshan_creations/models/product_model.dart';
import 'package:sudarshan_creations/shared/const.dart';
import 'package:sudarshan_creations/shared/firebase.dart';
import 'package:sudarshan_creations/shared/responsive.dart';

import '../shared/router.dart';
import 'widgets/footer.dart';
import 'widgets/product_bag.dart';
import 'widgets/top_appbar.dart';

class SudarshanProductDetails extends StatefulWidget {
  const SudarshanProductDetails({super.key, this.productId});
  final String? productId;
  @override
  State<SudarshanProductDetails> createState() =>
      _SudarshanProductDetailsState();
}

class _SudarshanProductDetailsState extends State<SudarshanProductDetails> {
  List<String> qunatitySet = [
    'Set of 5 pieces',
    'Set of 10 pieces',
    'Set of 15 pieces'
  ];
  List<String> personalize = ['Personlised', 'Non-Personlised'];
  int qty = 1;
  int selectedVariant = 1;
  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<ProductModel>(
      stream: FBFireStore.products.doc(widget.productId).snapshots().map((event) {
        return ProductModel.fromDocSnap(event);
      },),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          //loading
          return Center(child: CircularProgressIndicator(),);
        }
        if(snapshot.hasError){
          debugPrint(snapshot.error.toString());
          return SizedBox(child: Text("Error Fetching Dtaa! Please try again."),);
        }
        if(snapshot.hasData){
          final product = snapshot.data;
          final choosedVariant = product?.variants.firstWhere((element) => element.defaultt,);
          
        return product!=null && choosedVariant!=null? ResponsiveWid(
          mobile: Scaffold(
            backgroundColor: const Color(0xffFEF7F3),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  const TopAppBarWithBgImg(mobile: true),
                  const Divider(
                    color: Color(0xff95170D),
                    height: 0,
                    thickness: .5,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    constraints: BoxConstraints(
                        maxWidth: 1200,
                        // min height = screen height - appbar height - footer height - in b/w sizedbox heights
                        minHeight:
                            MediaQuery.sizeOf(context).height - 135 - 200 - 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ImageBox(
                                variant: [
                                  'assets/bag_img.png',
                                  'assets/bag_img2.png',
                                  'assets/bag_img3.png'
                                ],
                              ),
                              const SizedBox(height: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          product?.name??"",
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
                                          onPressed: () {
                                            //mark favourite
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.heart,
                                            size: 25,
                                            color: Color(0xff961810),
                                          ))
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: '₹50.00',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff4F4F4F),
                                          fontSize: 22,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    const TextSpan(text: '  '),
                                    TextSpan(
                                        text: '₹100.00',
                                        style: GoogleFonts.leagueSpartan(
                                          color: const Color(0xff828282),
                                          fontSize: 18,
                                          decoration: TextDecoration.lineThrough,
                                        )),
                                  ])),
                                  const SizedBox(height: 8),
                                  Text(
                                    'In Stock',
                                    style: GoogleFonts.leagueSpartan(
                                      color: const Color(0xff4F4F4F),
                                      fontSize: 14,
                                      // fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    "Quantity:",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff828282),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 15,
                                    runSpacing: 15,
                                    children: [
                                      ...List.generate(
                                        qunatitySet.length,
                                        (index) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 15),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color(0xffE0E0E0)),
                                            ),
                                            child: Text(
                                              qunatitySet[index],
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xff6C6C6C),
                                                fontSize: 12,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Personlisation:",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff828282),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 15,
                                    runSpacing: 15,
                                    children: [
                                      ...List.generate(
                                        personalize.length,
                                        (index) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 15),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color(0xffE0E0E0)),
                                            ),
                                            child: Text(
                                              personalize[index],
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xff6C6C6C),
                                                fontSize: 12,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Quantity:",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff828282),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    // padding: const EdgeInsets.symmetric(vertical: 7),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xffE0E0E0)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              if (qty == 1) return;
                                              qty--;
                                              setState(() {});
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                CupertinoIcons.minus,
                                                color: Color(0xff828282),
                                                size: 15,
                                              ),
                                            )),
                                        const SizedBox(width: 17),
                                        Text(
                                          qty.toString(),
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xff6C6C6C),
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(width: 17),
                                        InkWell(
                                          onTap: () {
                                            qty++;
                                            setState(() {});
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
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
                                  const SizedBox(height: 25),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              // fixedSize:
                                              //     const Size.fromWidth(double.maxFinite),
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 15),
                                              backgroundColor:
                                                  const Color(0xff535353),
                                              surfaceTintColor:
                                                  const Color(0xff535353),
                                              shadowColor: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              "Add to Cart",
                                              style: GoogleFonts.leagueSpartan(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 15),
                                              // fixedSize:
                                              //     const Size.fromWidth(double.maxFinite),
                                              backgroundColor:
                                                  const Color(0xff95170D),
                                              surfaceTintColor:
                                                  const Color(0xff95170D),
                                              shadowColor: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              "Buy Now",
                                              style: GoogleFonts.leagueSpartan(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Options:",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff828282),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  StaggeredGrid.extent(
                                    maxCrossAxisExtent: 200,
                                    mainAxisSpacing: 15, crossAxisSpacing: 15,
                                    // spacing: 15,
                                    // runSpacing: 15,
                                    // alignment: WrapAlignment.start,
                                    // runAlignment: WrapAlignment.start,
                                    children: [
                                      ...List.generate(
                                        4,
                                        (index) {
                                          List<String> imgList = [
                                            'assets/bag_img.png',
                                            'assets/bag_img2.png',
                                            'assets/bag_img3.png',
                                            'assets/bag_img4.png'
                                          ];
                                          // bool isSelected =
                                          //     index == selectedVariant;
                                          return InkWell(
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              selectedVariant = index;
                                              setState(() {});
                                            },
                                            child: Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                // color: Colors.white54,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                    width: .2,
                                                    color: const Color.fromARGB(
                                                        255, 161, 161, 161)),
                                              ),
                                              child: ListTile(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                minVerticalPadding: 8,
                                                leading: Container(
                                                  height: 100,
                                                  // width: 50,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle),
                                                  child: Image.asset(
                                                    imgList[index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                // minLeadingWidth: 50,
                                                title: const Text(
                                                  "Material lorem ipsum",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                                subtitle: const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "₹200/ pc",
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      "variant description lorem ipsum dolor sit amet, consectetur adipiscing.",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // child: Container(
                                            //   height: 140,
                                            //   width: 100,
                                            //   clipBehavior:
                                            //       Clip.antiAlias,
                                            //   decoration: BoxDecoration(
                                            //       borderRadius:
                                            //           BorderRadius
                                            //               .circular(5)),
                                            //   child: Column(
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment
                                            //             .start,
                                            //     children: [
                                            //       Container(
                                            //         decoration: BoxDecoration(
                                            //             borderRadius:
                                            //                 BorderRadius
                                            //                     .circular(
                                            //                         5)),
                                            //         clipBehavior:
                                            //             Clip.antiAlias,
                                            //         child: Image.asset(
                                            //           imgList[index],
                                            //           fit:
                                            //               BoxFit.fitWidth,
                                            //         ),
                                            //       ),
                                            //       const Text("₹150/pc")
                                            //     ],
                                            //   ),
                                            // ),
                                          );
                                        },
                                      )
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
                                                color: const Color(0xff4F4F4F)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                      color: Color(0xffDADADA), thickness: .6),
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
                                                color: const Color(0xff4F4F4F)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                      color: Color(0xffDADADA), thickness: .6),
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
                                                color: const Color(0xff4F4F4F)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                                4,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: InkWell(
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          context.go("${Routes.product}/id");
        
                                          // Navigator.push(context, MaterialPageRoute(
                                          //   builder: (context) {
                                          //     return const SudarshanProductDetails();
                                          //   },
                                          // ));
                                        },
                                        child: const ProductBagWid()),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        /* StaggeredGrid.extent(
                          maxCrossAxisExtent: 300,
                          mainAxisSpacing: 25,
                          crossAxisSpacing: 25,
                          // // spacing: 10,
                          // runSpacing: 20,
                          // alignment: WrapAlignment.start,
                          // runAlignment: WrapAlignment.start,
                          children: [
                            ...List.generate(
                              4,
                              (index) {
                                return InkWell(
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                     // Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return const SudarshanProductDetails();
                                        },
                                      ));
                                    },
                                    child: const ProductBagWid());
                              },
                            )
                          ],
                        ), */
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                  const SudarshanFooterSection(),
                ],
              ),
            ),
          ),
          desktop: Scaffold(
            backgroundColor: const Color(0xffFEF7F3),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  const TopAppBarWithBgImg(mobile: false),
                  const Divider(color: Color(0xff95170D), height: 0),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                    constraints: BoxConstraints(
                        maxWidth: 1200,
                        // min height = screen height - appbar height - footer height - in b/w sizedbox heights
                        minHeight:
                            MediaQuery.sizeOf(context).height - 80 - 70 - 20),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                                // flex: 2,
                                child: ImageBox(
                              variant: [
                                'assets/bag_img.png',
                                'assets/bag_img2.png',
                                'assets/bag_img3.png'
                              ],
                            )),
                            const SizedBox(width: 50),
                            Expanded(
                              // flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          product?.name??"",
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
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            CupertinoIcons.heart,
                                            size: 25,
                                            color: Color(0xff961810),
                                          ))
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  if(choosedVariant!=null && choosedVariant.priceType == PriceTypeModel.fixedPrice)Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: '₹${choosedVariant.fixedPrice}',
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
                                  const SizedBox(height: 8),
                                  Text(
                                    choosedVariant.available?'In Stock':'Out of Stock',
                                    style: GoogleFonts.leagueSpartan(
                                      color: const Color(0xff4F4F4F),
                                      fontSize: 14,
                                      // fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  // Text(
                                  //   "Quantity:",
                                  //   style: GoogleFonts.poppins(
                                  //     color: const Color(0xff828282),
                                  //     fontSize: 14,
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 10),
                                  // Wrap(
                                  //   spacing: 15,
                                  //   runSpacing: 15,
                                  //   children: [
                                  //     ...List.generate(
                                  //       qunatitySet.length,
                                  //       (index) {
                                  //         return Container(
                                  //           padding: const EdgeInsets.symmetric(
                                  //               vertical: 7, horizontal: 15),
                                  //           decoration: BoxDecoration(
                                  //             border: Border.all(
                                  //                 color: const Color(0xffE0E0E0)),
                                  //           ),
                                  //           child: Text(
                                  //             qunatitySet[index],
                                  //             style: GoogleFonts.poppins(
                                  //               color: const Color(0xff6C6C6C),
                                  //               fontSize: 12,
                                  //             ),
                                  //           ),
                                  //         );
                                  //       },
                                  //     )
                                  //   ],
                                  // ),
                                  // const SizedBox(height: 20),
                                  // Text(
                                  //   "Personlisation:",
                                  //   style: GoogleFonts.poppins(
                                  //     color: const Color(0xff828282),
                                  //     fontSize: 14,
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 10),
                                  // Wrap(
                                  //   spacing: 15,
                                  //   runSpacing: 15,
                                  //   children: [
                                  //     ...List.generate(
                                  //       personalize.length,
                                  //       (index) {
                                  //         return Container(
                                  //           padding: const EdgeInsets.symmetric(
                                  //               vertical: 7, horizontal: 15),
                                  //           decoration: BoxDecoration(
                                  //             border: Border.all(
                                  //                 color: const Color(0xffE0E0E0)),
                                  //           ),
                                  //           child: Text(
                                  //             personalize[index],
                                  //             style: GoogleFonts.poppins(
                                  //               color: const Color(0xff6C6C6C),
                                  //               fontSize: 12,
                                  //             ),
                                  //           ),
                                  //         );
                                  //       },
                                  //     ),
                                  //   ],
                                  // ),
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
                                        product.variants.length-1,
                                        (index) {
                                          final variant = product.variants[index];
                                          return InkWell(
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              selectedVariant = index;
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
                                                    color: const Color.fromARGB(
                                                        255, 161, 161, 161)),
                                              ),
                                              child: ListTile(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                minVerticalPadding: 8,
                                                leading: Container(
                                                  height: 100,
                                                  // width: 50,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle),
                                                  // child: Image.asset(
                                                  //   imgList[index],
                                                  //   fit: BoxFit.cover,
                                                  // ),
                                                ),
                                                // minLeadingWidth: 50,
                                                title: const Text(
                                                  "Material lorem ipsum",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                                subtitle: const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "₹200/ pc",
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      "variant description lorem ipsum dolor sit amet, consectetur adipiscing.",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // child: Container(
                                            //   height: 140,
                                            //   width: 100,
                                            //   clipBehavior:
                                            //       Clip.antiAlias,
                                            //   decoration: BoxDecoration(
                                            //       borderRadius:
                                            //           BorderRadius
                                            //               .circular(5)),
                                            //   child: Column(
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment
                                            //             .start,
                                            //     children: [
                                            //       Container(
                                            //         decoration: BoxDecoration(
                                            //             borderRadius:
                                            //                 BorderRadius
                                            //                     .circular(
                                            //                         5)),
                                            //         clipBehavior:
                                            //             Clip.antiAlias,
                                            //         child: Image.asset(
                                            //           imgList[index],
                                            //           fit:
                                            //               BoxFit.fitWidth,
                                            //         ),
                                            //       ),
                                            //       const Text("₹150/pc")
                                            //     ],
                                            //   ),
                                            // ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Quantity:",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff828282),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    // padding: const EdgeInsets.symmetric(vertical: 7),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xffE0E0E0)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              if (qty == 1) return;
                                              qty--;
                                              setState(() {});
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                CupertinoIcons.minus,
                                                color: Color(0xff828282),
                                                size: 15,
                                              ),
                                            )),
                                        const SizedBox(width: 17),
                                        Text(
                                          qty.toString(),
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xff6C6C6C),
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(width: 17),
                                        InkWell(
                                          onTap: () {
                                            qty++;
                                            setState(() {});
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
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
                                  const SizedBox(height: 25),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 15),
                                                backgroundColor:
                                                    const Color(0xff535353),
                                                surfaceTintColor:
                                                    const Color(0xff535353),
                                                shadowColor: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(6)),
                                              ),
                                              onPressed: () {},
                                              child: Text(
                                                "Add to Cart",
                                                style: GoogleFonts.leagueSpartan(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ))),
                                      const SizedBox(width: 15),
                                      Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 15),
                                                backgroundColor:
                                                    const Color(0xff95170D),
                                                surfaceTintColor:
                                                    const Color(0xff95170D),
                                                shadowColor: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(6)),
                                              ),
                                              onPressed: () {},
                                              child: Text(
                                                "Buy Now",
                                                style: GoogleFonts.leagueSpartan(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ))),
                                    ],
                                  ),
                                  // const SizedBox(height: 20),
                                  // Text(
                                  //   "Options:",
                                  //   style: GoogleFonts.poppins(
                                  //     color: const Color(0xff828282),
                                  //     fontSize: 14,
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 10),
                                  // Wrap(
                                  //   spacing: 12,
                                  //   runSpacing: 15,
                                  //   alignment: WrapAlignment.start,
                                  //   runAlignment: WrapAlignment.start,
                                  //   children: [
                                  //     ...List.generate(
                                  //       4,
                                  //       (index) {
                                  //         List<String> imgList = [
                                  //           'assets/bag_img.png',
                                  //           'assets/bag_img2.png',
                                  //           'assets/bag_img3.png',
                                  //           'assets/bag_img4.png'
                                  //         ];
                                  //         // bool isSelected =
                                  //         //     index == selectedVariant;
                                  //         return InkWell(
                                  //           hoverColor: Colors.transparent,
                                  //           highlightColor: Colors.transparent,
                                  //           splashColor: Colors.transparent,
                                  //           onTap: () {
                                  //             selectedVariant = index;
                                  //             setState(() {});
                                  //           },
                                  //           child: Container(
                                  //             width: 200,
                                  //             decoration: BoxDecoration(
                                  //               // color: Colors.white54,
                                  //               borderRadius:
                                  //                   BorderRadius.circular(4),
                                  //               border: Border.all(
                                  //                   width: .2,
                                  //                   color: const Color.fromARGB(
                                  //                       255, 161, 161, 161)),
                                  //             ),
                                  //             child: ListTile(
                                  //               contentPadding:
                                  //                   const EdgeInsets.symmetric(
                                  //                       horizontal: 8),
                                  //               minVerticalPadding: 8,
                                  //               leading: Container(
                                  //                 height: 100,
                                  //                 // width: 50,
                                  //                 decoration: const BoxDecoration(
                                  //                     shape: BoxShape.circle),
                                  //                 child: Image.asset(
                                  //                   imgList[index],
                                  //                   fit: BoxFit.cover,
                                  //                 ),
                                  //               ),
                                  //               // minLeadingWidth: 50,
                                  //               title: const Text(
                                  //                 "Material lorem ipsum",
                                  //                 maxLines: 1,
                                  //                 overflow: TextOverflow.ellipsis,
                                  //                 style: TextStyle(
                                  //                     fontSize: 13,
                                  //                     fontWeight: FontWeight.w500),
                                  //               ),
                                  //               subtitle: const Column(
                                  //                 crossAxisAlignment:
                                  //                     CrossAxisAlignment.start,
                                  //                 children: [
                                  //                   Text(
                                  //                     "₹200/ pc",
                                  //                     style: TextStyle(
                                  //                         fontSize: 11,
                                  //                         fontWeight:
                                  //                             FontWeight.w500),
                                  //                   ),
                                  //                   Text(
                                  //                     "variant description lorem ipsum dolor sit amet, consectetur adipiscing.",
                                  //                     maxLines: 1,
                                  //                     overflow:
                                  //                         TextOverflow.ellipsis,
                                  //                     style: TextStyle(
                                  //                         fontSize: 10,
                                  //                         fontWeight:
                                  //                             FontWeight.w500),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //           ),
                                  //           // child: Container(
                                  //           //   height: 140,
                                  //           //   width: 100,
                                  //           //   clipBehavior:
                                  //           //       Clip.antiAlias,
                                  //           //   decoration: BoxDecoration(
                                  //           //       borderRadius:
                                  //           //           BorderRadius
                                  //           //               .circular(5)),
                                  //           //   child: Column(
                                  //           //     crossAxisAlignment:
                                  //           //         CrossAxisAlignment
                                  //           //             .start,
                                  //           //     children: [
                                  //           //       Container(
                                  //           //         decoration: BoxDecoration(
                                  //           //             borderRadius:
                                  //           //                 BorderRadius
                                  //           //                     .circular(
                                  //           //                         5)),
                                  //           //         clipBehavior:
                                  //           //             Clip.antiAlias,
                                  //           //         child: Image.asset(
                                  //           //           imgList[index],
                                  //           //           fit:
                                  //           //               BoxFit.fitWidth,
                                  //           //         ),
                                  //           //       ),
                                  //           //       const Text("₹150/pc")
                                  //           //     ],
                                  //           //   ),
                                  //           // ),
                                  //         );
                                  //       },
                                  //     )
                                  //   ],
                                  // ),
                                  const SizedBox(height: 15),
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
                                                color: const Color(0xff4F4F4F)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                      color: Color(0xffDADADA), thickness: .6),
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
                                                color: const Color(0xff4F4F4F)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                      color: Color(0xffDADADA), thickness: .6),
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
                                                color: const Color(0xff4F4F4F)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
                          // // spacing: 10,
                          // runSpacing: 20,
                          // alignment: WrapAlignment.start,
                          // runAlignment: WrapAlignment.start,
                          children: [
                            ...List.generate(
                              4,
                              (index) {
                                return InkWell(
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      context.go("${Routes.product}/id");
        
                                      // Navigator.push(context, MaterialPageRoute(
                                      //   builder: (context) {
                                      //     return const SudarshanProductDetails();
                                      //   },
                                      // ));
                                    },
                                    child: const ProductBagWid());
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
        )
        :Center(child: Text("No Product Found"),);
        }
        return SizedBox();
      }
    );
  }
}

class TopAppBarWithBgImg extends StatelessWidget {
  const TopAppBarWithBgImg({
    super.key,
    required this.mobile,
  });
  final bool mobile;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          Image.asset(
            'assets/top_bg_img.png',
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: TopAppBar(mobile: mobile),
          ),
        ],
      ),
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

class ImageBox extends StatefulWidget {
  const ImageBox({super.key, required this.variant});
  final List<String> variant;
  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  RxInt currentIndex = 0.obs;
  final carouselController = carousel.CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      // width: size.width,
      // height: size.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                          currentIndex.value = index,
                      aspectRatio: 800 / 1200,
                    ),
                    items: widget.variant.map((i) {
                      return InkWell(
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        // onTap: () {
                        //   showDialog(
                        //     barrierDismissible: true,
                        //     context: context,
                        //     builder: (context) => ZoomPopup(
                        //         variant: widget.variant,
                        //         selectedIndex: widget.variant.images.indexOf(i)),
                        //   );
                        // },
                        child: Container(
                          width: size.width,
                          height: size.height,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            i,
                            fit: BoxFit.cover,
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
                        widget.variant.length,
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
                                              color: const Color(0xff95170D),
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
        ],
      ),
    );
  }
}
