import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudarshan_creations/shared/responsive.dart';
import '../shared/router.dart';
import 'sudarshan_product_details.dart';
import 'widgets/footer.dart';
import 'widgets/product_bag.dart';
import 'widgets/sub_cat_product_topbar.dart';

class SudarshanDisplayFavourites extends StatefulWidget {
  const SudarshanDisplayFavourites({super.key});

  @override
  State<SudarshanDisplayFavourites> createState() =>
      _SudarshanDisplayFavouritesState();
}

class _SudarshanDisplayFavouritesState
    extends State<SudarshanDisplayFavourites> {
  String? selectedType;
  String? selectedPrice;
  final overlayPortalController = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWid(
      mobile: Scaffold(
        backgroundColor: const Color(0xffFEF7F3),
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              const SubCatProductTopBar(forSubCat: false),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 1200,
                    // imp: Min height calculation (deviceHeight- footerheight - top section height - extra height of sizedbox between widgets)
                    minHeight:
                        MediaQuery.sizeOf(context).height - 200 - 350 - 75,
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              hint: const Text(
                                'Product Type',
                                style: TextStyle(
                                    color: Color(0xff6C6C6C), fontSize: 14),
                              ),
                              icon: const Icon(
                                CupertinoIcons.chevron_down,
                                color: Color(0xff6C6C6C),
                                size: 18,
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff6C6C6C)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff6C6C6C)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff6C6C6C)),
                                ),
                              ),
                              value: selectedType,
                              items: const [
                                DropdownMenuItem(
                                    value: 'Enquiry', child: Text("Enquiry")),
                                DropdownMenuItem(
                                    value: 'Order', child: Text("Order")),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              hint: const Text(
                                'Price',
                                style: TextStyle(
                                    color: Color(0xff6C6C6C), fontSize: 14),
                              ),
                              icon: const Icon(
                                CupertinoIcons.chevron_down,
                                color: Color(0xff6C6C6C),
                                size: 18,
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff6C6C6C)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff6C6C6C)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff6C6C6C)),
                                ),
                              ),
                              value: selectedPrice,
                              items: const [
                                DropdownMenuItem(
                                    value: '50', child: Text("50")),
                                DropdownMenuItem(
                                    value: '60', child: Text("60")),
                                DropdownMenuItem(
                                    value: '70', child: Text("70")),
                                DropdownMenuItem(
                                    value: '80', child: Text("80")),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              overlayPortalController.show();
                              showDialog(
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  RangeValues rangeValue =
                                      const RangeValues(100, 2500);
                                  RangeValues selectedRange =
                                      const RangeValues(100, 2500);
                                  return StatefulBuilder(
                                      builder: (context, setStatet2) {
                                    return OverlayPortal(
                                      controller: overlayPortalController,
                                      overlayChildBuilder: (context) {
                                        return Positioned(
                                          left: 20, // To Change,
                                          top: 590, // Fix,
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(10),

                                            // clipBehavior: Clip.antiAlias,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 20),
                                              width: 300,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 1,
                                                    spreadRadius: .5,
                                                    color: Color(0xffD5D5D5),
                                                    offset: Offset(0, 0),
                                                  )
                                                ],
                                                color: const Color(0xffFEF7F3),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Price",
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xff6C6C6C),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 7),
                                                  Text(
                                                    '₹${selectedRange.start.toInt()} - ₹${selectedRange.end.toInt()}',
                                                    style: GoogleFonts.brawler(
                                                        letterSpacing: 1,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color: const Color(
                                                            0xff111111)),
                                                  ),
                                                  const SizedBox(height: 7),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    // mainAxisSize:
                                                    //     MainAxisSize.min,
                                                    children: [
                                                      RangeSlider(
                                                        min: rangeValue.start,
                                                        max: rangeValue.end,
                                                        values: selectedRange,
                                                        divisions: 50,
                                                        activeColor:
                                                            const Color(
                                                                0xff95170D),
                                                        inactiveColor:
                                                            const Color(
                                                                0xffD9D9D9),
                                                        onChanged: (value) {
                                                          selectedRange = value;
                                                          setStatet2(() {});
                                                        },
                                                      ),
                                                      const Spacer(),
                                                      ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              side: const BorderSide(
                                                                  color: Color(
                                                                      0xff111111)),
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              shadowColor: Colors
                                                                  .transparent,
                                                              overlayColor: Colors
                                                                  .transparent,
                                                              surfaceTintColor:
                                                                  Colors
                                                                      .transparent,
                                                              elevation: 0),
                                                          onPressed: () {
                                                            overlayPortalController
                                                                .hide();
                                                          },
                                                          child: Text(
                                                            "Go",
                                                            style: GoogleFonts.poppins(
                                                                color: const Color(
                                                                    0xff111111),
                                                                fontSize: 13.5),
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  });
                                },
                              );
                            },
                            child: IgnorePointer(
                              ignoring: true,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  hint: const Text(
                                    'Price Range',
                                    style: TextStyle(
                                        color: Color(0xff6C6C6C), fontSize: 14),
                                  ),
                                  icon: const Icon(
                                    CupertinoIcons.chevron_down,
                                    color: Color(0xff6C6C6C),
                                    size: 18,
                                  ),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff6C6C6C)),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff6C6C6C)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff6C6C6C)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff6C6C6C)),
                                    ),
                                  ),
                                  items: const [],
                                  onChanged: (value) {},
                                ),
                              ),
                            ),
                          ),
                          /*  SizedBox(height: 20),
                          TextFormField(
                            cursorColor:
                                const Color.fromARGB(255, 153, 149, 149),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                CupertinoIcons.search,
                                size: 18,
                                color: Color(0xff6C6C6C),
                              ),
                              hintText: ' Search',
                              hintStyle: TextStyle(
                                  color: Color(0xff6C6C6C), fontSize: 14),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff6C6C6C)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff6C6C6C)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff6C6C6C)),
                              ),
                            ),
                          ), */
                        ],
                      ),
                      const SizedBox(height: 30),
                      StaggeredGrid.extent(
                        maxCrossAxisExtent: 300,
                        mainAxisSpacing: 25,
                        crossAxisSpacing: 25,
                        // spacing: 25,
                        // runSpacing: 25,
                        children: [
                          ...List.generate(
                            6,
                            (index) {
                              // final image = index % 2 == 0
                              //     ? 'assets/money_envol_image.png'
                              //     : 'assets/gift_sets_image.png';
                              // final text =
                              //     index % 2 == 0 ? "GFT SETS" : "MONEY ENVELOPES";
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
                                  child: const ProductBagWid(forHome: false));
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
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
              const SubCatProductTopBar(forSubCat: false),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 1200,
                    // imp: Min height calculation (deviceHeight- footerheight - top section height - extra height of sizedbox between widgets)
                    minHeight:
                        MediaQuery.sizeOf(context).height - 60 - 350 - 100,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                hint: const Text(
                                  'Product Type',
                                  style: TextStyle(
                                      color: Color(0xff6C6C6C), fontSize: 14),
                                ),
                                icon: const Icon(
                                  CupertinoIcons.chevron_down,
                                  color: Color(0xff6C6C6C),
                                  size: 18,
                                ),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff6C6C6C)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff6C6C6C)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff6C6C6C)),
                                  ),
                                ),
                                value: selectedType,
                                items: const [
                                  DropdownMenuItem(
                                      value: 'Enquiry', child: Text("Enquiry")),
                                  DropdownMenuItem(
                                      value: 'Order', child: Text("Order")),
                                ],
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                hint: const Text(
                                  'Price',
                                  style: TextStyle(
                                      color: Color(0xff6C6C6C), fontSize: 14),
                                ),
                                icon: const Icon(
                                  CupertinoIcons.chevron_down,
                                  color: Color(0xff6C6C6C),
                                  size: 18,
                                ),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff6C6C6C)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff6C6C6C)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff6C6C6C)),
                                  ),
                                ),
                                value: selectedPrice,
                                items: const [
                                  DropdownMenuItem(
                                      value: '50', child: Text("50")),
                                  DropdownMenuItem(
                                      value: '60', child: Text("60")),
                                  DropdownMenuItem(
                                      value: '70', child: Text("70")),
                                  DropdownMenuItem(
                                      value: '80', child: Text("80")),
                                ],
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                overlayPortalController.show();
                                showDialog(
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    RangeValues rangeValue =
                                        const RangeValues(100, 2500);
                                    RangeValues selectedRange =
                                        const RangeValues(100, 2500);
                                    return StatefulBuilder(
                                        builder: (context, setStatet2) {
                                      return OverlayPortal(
                                        controller: overlayPortalController,
                                        overlayChildBuilder: (context) {
                                          return Positioned(
                                            left: 865, // To Change,
                                            top: 460, // Fix,
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(10),

                                              // clipBehavior: Clip.antiAlias,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 20),
                                                width: 300,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 1,
                                                      spreadRadius: .5,
                                                      color: Color(0xffD5D5D5),
                                                      offset: Offset(0, 0),
                                                    )
                                                  ],
                                                  color:
                                                      const Color(0xffFEF7F3),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Price",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xff6C6C6C),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 7),
                                                    Text(
                                                      '₹${selectedRange.start.toInt()} - ₹${selectedRange.end.toInt()}',
                                                      style: GoogleFonts.brawler(
                                                          letterSpacing: 1,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                          color: const Color(
                                                              0xff111111)),
                                                    ),
                                                    const SizedBox(height: 7),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      // mainAxisSize:
                                                      //     MainAxisSize.min,
                                                      children: [
                                                        RangeSlider(
                                                          min: rangeValue.start,
                                                          max: rangeValue.end,
                                                          values: selectedRange,
                                                          divisions: 50,
                                                          activeColor:
                                                              const Color(
                                                                  0xff95170D),
                                                          inactiveColor:
                                                              const Color(
                                                                  0xffD9D9D9),
                                                          onChanged: (value) {
                                                            selectedRange =
                                                                value;
                                                            setStatet2(() {});
                                                          },
                                                        ),
                                                        const Spacer(),
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                side: const BorderSide(
                                                                    color: Color(
                                                                        0xff111111)),
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                shadowColor: Colors
                                                                    .transparent,
                                                                overlayColor: Colors
                                                                    .transparent,
                                                                surfaceTintColor:
                                                                    Colors
                                                                        .transparent,
                                                                elevation: 0),
                                                            onPressed: () {
                                                              overlayPortalController
                                                                  .hide();
                                                            },
                                                            child: Text(
                                                              "Go",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      color: const Color(
                                                                          0xff111111),
                                                                      fontSize:
                                                                          13.5),
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    });
                                  },
                                );
                              },
                              child: IgnorePointer(
                                ignoring: true,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField(
                                    hint: const Text(
                                      'Price Range',
                                      style: TextStyle(
                                          color: Color(0xff6C6C6C),
                                          fontSize: 14),
                                    ),
                                    icon: const Icon(
                                      CupertinoIcons.chevron_down,
                                      color: Color(0xff6C6C6C),
                                      size: 18,
                                    ),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff6C6C6C)),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff6C6C6C)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff6C6C6C)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff6C6C6C)),
                                      ),
                                    ),
                                    items: const [],
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                              child: TextFormField(
                            cursorColor:
                                const Color.fromARGB(255, 153, 149, 149),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                CupertinoIcons.search,
                                size: 18,
                                color: Color(0xff6C6C6C),
                              ),
                              hintText: ' Search',
                              hintStyle: TextStyle(
                                  color: Color(0xff6C6C6C), fontSize: 14),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff6C6C6C)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff6C6C6C)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff6C6C6C)),
                              ),
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(height: 50),
                      StaggeredGrid.extent(
                        maxCrossAxisExtent: 300,
                        mainAxisSpacing: 25,
                        crossAxisSpacing: 25,
                        // spacing: 25,
                        // runSpacing: 25,
                        children: [
                          ...List.generate(
                            6,
                            (index) {
                              // final image = index % 2 == 0
                              //     ? 'assets/money_envol_image.png'
                              //     : 'assets/gift_sets_image.png';
                              // final text =
                              //     index % 2 == 0 ? "GFT SETS" : "MONEY ENVELOPES";
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
                                  child: const ProductBagWid(forHome: false));
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const SudarshanFooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}
