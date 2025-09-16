import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudarshan_creations/controller/home_controller.dart';
import 'package:sudarshan_creations/models/main_category.dart';
import 'package:sudarshan_creations/models/product_model.dart';
import 'package:sudarshan_creations/models/sub_category.dart';
import 'package:sudarshan_creations/shared/firebase.dart';
import 'package:sudarshan_creations/shared/methods.dart';
import 'package:sudarshan_creations/shared/responsive.dart';
import 'package:sudarshan_creations/views/sudarshan_account.dart';
import 'package:sudarshan_creations/views/wrapper.dart';
import '../shared/router.dart';
import 'widgets/footer.dart';
import 'widgets/product_bag.dart';
import 'widgets/sub_cat_product_topbar.dart';

final _favouriteScafKey = GlobalKey<ScaffoldState>();

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

  int currentPage = 1; // 1-based for user readability
  // int itemsPerPage = 2;
  int totalItems = 0;
  int totalPages = 0;
  final searchController = TextEditingController();
  bool dataloaded = false;

  // List<List<ProductModel>> paginatedData = [];
  DocumentSnapshot? lastFetchedDoc;
  Timer? debounce;
  // List<ProductModel> allproducts = [];
  // List<ProductModel> favouriteProducts = [];
  SubCategory? selectedSubCat;
  List<SubCategory> allMainSubCats = [];
  MainCategory? selmainCategoryModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataloaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final filteredProducts = (currentPage - 1) < paginatedData.length
    //     ? paginatedData[currentPage - 1]
    //     : [];
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    // selmainCategoryModel = Get.find<HomeCtrl>()
    //     .homeCategories
    //     .firstWhereOrNull((element) => element.docId == widget.maincategoryId);
    // favouriteProducts.sort((a, b) =>
    //     int.tryParse(a.name.split(' ').last)
    //         ?.compareTo(int.tryParse(b.name.split(' ').last) ?? 0) ??
    //     0);
    return true
        ? Wrapper(
            scafkey: _favouriteScafKey,
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: !dataloaded
                  ? SizedBox(
                      height: screenHeight,
                      child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: CircularProgressIndicator())
                          ]),
                    )
                  : Column(
                      children: [
                        // SubCatProductTopBar(
                        //     mainCategoryModel: selmainCategoryModel),
                        const FavouriteTopBar(),

                        const SizedBox(height: 30),
                        /*    SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            spacing: 10,
                            children: [
                              ...List.generate(
                                widget.allActiveMainCat.length,
                                (index) {
                                  bool selected = selmainCategoryModel!.docId ==
                                      widget.allActiveMainCat[index].docId;
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      searchController.clear();
                                      context.go(
                                          "${Routes.category}/${widget.allActiveMainCat[index].docId}");
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 13),
                                      decoration: BoxDecoration(
                                        color: true
                                            ? selected
                                                ? Colors.black
                                                : Colors.white
                                            : selected
                                                ? const Color(0xffFFE6DF)
                                                : Colors.white,
                                        border: Border.all(
                                            color: selected
                                                ? Colors.black
                                                : const Color(0xffBDBDBD)),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            capilatlizeFirstLetter(widget
                                                .allActiveMainCat[index].name),
                                            style: GoogleFonts.mulish(
                                                color: selected
                                                    ? Colors.white
                                                    : const Color(0xff828282),
                                                fontSize: 12,
                                                height: 0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          // if (selected) ...[
                                          //   const SizedBox(width: 5),
                                          //   const Center(
                                          //     child: Icon(
                                          //       CupertinoIcons.xmark,
                                          //       size: 14,
                                          //       color: Color(0xff747474),
                                          //     ),
                                          //   ),
                                          // ]
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                          color: Color.fromARGB(255, 227, 227, 227),
                          thickness: 0.5,
                          height: 0,
                        ),
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            spacing: 10,
                            children: [
                              ...List.generate(
                                allMainSubCats.length,
                                (index) {
                                  bool selected = selectedSubCat?.docId ==
                                      allMainSubCats[index].docId;
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () async {
                                      searchController.clear();
                                      selectedSubCat = selected
                                          ? null
                                          : allMainSubCats[index];
                                      // getProductsData();
                                      await initializePagination();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 13),
                                      decoration: BoxDecoration(
                                        color: true
                                            ? selected
                                                ? Colors.black
                                                : Colors.white
                                            : selected
                                                ? const Color(0xffFFE6DF)
                                                : Colors.white,
                                        border: Border.all(
                                            color: selected
                                                ? Colors.black
                                                : const Color(0xffBDBDBD)),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            capilatlizeFirstLetter(
                                                allMainSubCats[index].name),
                                            style: GoogleFonts.mulish(
                                                color: selected
                                                    ? Colors.white
                                                    : const Color(0xff828282),
                                                fontSize: 12,
                                                height: 0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          // if (selected) ...[
                                          //   const SizedBox(width: 5),
                                          //   const Center(
                                          //     child: Icon(
                                          //       CupertinoIcons.xmark,
                                          //       size: 14,
                                          //       color: Color(0xff747474),
                                          //     ),
                                          //   ),
                                          // ]
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30), */

                        //          padding: const EdgeInsets.symmetric(horizontal: 25),
                        // child: Container(
                        //     padding: const EdgeInsets.symmetric(vertical: 30),
                        //     // color: Colors.black12,
                        //     constraints: BoxConstraints(
                        //       maxWidth: 1200,
                        //       // min height = screen height  - footer height - appbar height
                        //       minHeight: MediaQuery.sizeOf(context).height - 60 - 350,
                        //     ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 1200,
                                // imp: Min height calculation (deviceHeight- footerheight - top section height - extra height of sizedbox between widgets)
                                minHeight: MediaQuery.sizeOf(context).height -
                                    120 -
                                    300 -
                                    70,
                              ),
                              child: isLoggedIn()
                                  ? FavoriteProductDisplay(
                                      // favouriteProducts: favouriteProducts,
                                      screenWidth: screenWidth,
                                    )

                                  //   LOGIN SECTION
                                  : ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxWidth: 500),
                                      child: LoginPage(
                                          // goTo: widget.routeTo,
                                          refresh: () {
                                        setState(() {});
                                      }),
                                    )),
                        ),
                        // if (totalPages > 1) ...[
                        //   const SizedBox(height: 30),
                        //   Padding(
                        //     padding: const EdgeInsets.all(12.0),
                        //     child: DynamicPagination(
                        //       currentPage: currentPage,
                        //       totalPages: totalPages,
                        //       onPageChanged: handlePageChange,
                        //     ),
                        //   ),
                        // ],
                        const SizedBox(height: 50),
                        const SudarshanFooterSection(),
                      ],
                    ),
            ),
          )
        : ResponsiveWid(
            mobile: Wrapper(
              scafkey: _favouriteScafKey,
              // small: true,
              // backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    const SubCatProductTopBar(forCatPage: false),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 1200,
                          // imp: Min height calculation (deviceHeight- footerheight - top section height - extra height of sizedbox between widgets)
                          minHeight: MediaQuery.sizeOf(context).height -
                              200 -
                              300 -
                              70,
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
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff6C6C6C)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff6C6C6C)),
                                      ),
                                    ),
                                    value: selectedType,
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'Enquiry',
                                          child: Text("Enquiry")),
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
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff6C6C6C)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff6C6C6C)),
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 12,
                                                        horizontal: 20),
                                                    width: 300,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          blurRadius: 1,
                                                          spreadRadius: .5,
                                                          color:
                                                              Color(0xffD5D5D5),
                                                          offset: Offset(0, 0),
                                                        )
                                                      ],
                                                      color: const Color(
                                                          0xffFEF7F3),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Price",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: const Color(
                                                                0xff6C6C6C),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 7),
                                                        Text(
                                                          '₹${selectedRange.start.toInt()} - ₹${selectedRange.end.toInt()}',
                                                          style: GoogleFonts.brawler(
                                                              letterSpacing: 1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16,
                                                              color: const Color(
                                                                  0xff111111)),
                                                        ),
                                                        const SizedBox(
                                                            height: 7),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          // mainAxisSize:
                                                          //     MainAxisSize.min,
                                                          children: [
                                                            RangeSlider(
                                                              min: rangeValue
                                                                  .start,
                                                              max: rangeValue
                                                                  .end,
                                                              values:
                                                                  selectedRange,
                                                              divisions: 50,
                                                              activeColor:
                                                                  const Color(
                                                                      0xff95170D),
                                                              inactiveColor:
                                                                  const Color(
                                                                      0xffD9D9D9),
                                                              onChanged:
                                                                  (value) {
                                                                selectedRange =
                                                                    value;
                                                                setStatet2(
                                                                    () {});
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
                                                                    shadowColor:
                                                                        Colors
                                                                            .transparent,
                                                                    overlayColor:
                                                                        Colors
                                                                            .transparent,
                                                                    surfaceTintColor:
                                                                        Colors
                                                                            .transparent,
                                                                    elevation:
                                                                        0),
                                                                onPressed: () {
                                                                  overlayPortalController
                                                                      .hide();
                                                                },
                                                                child: Text(
                                                                  "Go",
                                                                  style: GoogleFonts.poppins(
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
                                        child: const ProductBagWid(
                                            forHome: false));
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
            desktop: Wrapper(
              scafkey: _favouriteScafKey,
              body: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    const SubCatProductTopBar(forCatPage: false),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 1200,
                          // imp: Min height calculation (deviceHeight- footerheight - top section height - extra height of sizedbox between widgets)
                          minHeight: MediaQuery.sizeOf(context).height -
                              60 -
                              350 -
                              100,
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
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff6C6C6C)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff6C6C6C)),
                                        ),
                                      ),
                                      value: selectedType,
                                      items: const [
                                        DropdownMenuItem(
                                            value: 'Enquiry',
                                            child: Text("Enquiry")),
                                        DropdownMenuItem(
                                            value: 'Order',
                                            child: Text("Order")),
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
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff6C6C6C)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff6C6C6C)),
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
                                              controller:
                                                  overlayPortalController,
                                              overlayChildBuilder: (context) {
                                                return Positioned(
                                                  left: 865, // To Change,
                                                  top: 460, // Fix,
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),

                                                    // clipBehavior: Clip.antiAlias,
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 12,
                                                          horizontal: 20),
                                                      width: 300,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            blurRadius: 1,
                                                            spreadRadius: .5,
                                                            color: Color(
                                                                0xffD5D5D5),
                                                            offset:
                                                                Offset(0, 0),
                                                          )
                                                        ],
                                                        color: const Color(
                                                            0xffFEF7F3),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Price",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: const Color(
                                                                  0xff6C6C6C),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 7),
                                                          Text(
                                                            '₹${selectedRange.start.toInt()} - ₹${selectedRange.end.toInt()}',
                                                            style: GoogleFonts.brawler(
                                                                letterSpacing:
                                                                    1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16,
                                                                color: const Color(
                                                                    0xff111111)),
                                                          ),
                                                          const SizedBox(
                                                              height: 7),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            // mainAxisSize:
                                                            //     MainAxisSize.min,
                                                            children: [
                                                              RangeSlider(
                                                                min: rangeValue
                                                                    .start,
                                                                max: rangeValue
                                                                    .end,
                                                                values:
                                                                    selectedRange,
                                                                divisions: 50,
                                                                activeColor:
                                                                    const Color(
                                                                        0xff95170D),
                                                                inactiveColor:
                                                                    const Color(
                                                                        0xffD9D9D9),
                                                                onChanged:
                                                                    (value) {
                                                                  selectedRange =
                                                                      value;
                                                                  setStatet2(
                                                                      () {});
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
                                                                      shadowColor:
                                                                          Colors
                                                                              .transparent,
                                                                      overlayColor:
                                                                          Colors
                                                                              .transparent,
                                                                      surfaceTintColor:
                                                                          Colors
                                                                              .transparent,
                                                                      elevation:
                                                                          0),
                                                                  onPressed:
                                                                      () {
                                                                    overlayPortalController
                                                                        .hide();
                                                                  },
                                                                  child: Text(
                                                                    "Go",
                                                                    style: GoogleFonts.poppins(
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
                                        child: const ProductBagWid(
                                            forHome: false));
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

class FavoriteProductDisplay extends StatefulWidget {
  const FavoriteProductDisplay({
    super.key,
    // required this.favouriteProducts,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  State<FavoriteProductDisplay> createState() => _FavoriteProductDisplayState();
}

class _FavoriteProductDisplayState extends State<FavoriteProductDisplay> {
  List<ProductModel> favouriteProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavouriteProducts();
  }

  List<List<String>> chunkStringList(List<String> items, int chunkSize) {
    List<List<String>> chunks = [];

    for (var i = 0; i < items.length; i += chunkSize) {
      int end = (i + chunkSize < items.length) ? i + chunkSize : items.length;
      chunks.add(items.sublist(i, end));
    }

    return chunks;
  }

  getFavouriteProducts() async {
    try {
      final hCtrl = Get.find<HomeCtrl>();
      favouriteProducts.clear();
      final favouriteDocList = hCtrl.currentUserdata?.favourites ?? [];
      print(favouriteDocList.map((e) => e.split('/').first).toList().length);
      print(favouriteDocList.map((e) => e.split('/').first).toList());
      List<List<String>> batchList = chunkStringList(
          favouriteDocList.map((e) => e.split('/').first).toList(), 30);

      if (favouriteDocList.isNotEmpty) {
        for (var batch in batchList) {
          final resSnap = await FBFireStore.products
              .where(FieldPath.documentId, whereIn: batch)
              .get();
          favouriteProducts.addAll(
              resSnap.docs.map((e) => ProductModel.fromSnap(e)).toList());
        }
      }
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*  Column(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
                  hint: const Text(
                    'Product Type',
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xff6C6C6C)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xff6C6C6C)),
                    ),
                  ),
                  value: selectedType,
                  items: const [
                    DropdownMenuItem(
                        value: 'Enquiry',
                        child: Text("Enquiry")),
                    DropdownMenuItem(
                        value: 'Order',
                        child: Text("Order")),
                  ],
                  onChanged: (value) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
                  hint: const Text(
                    'Price',
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xff6C6C6C)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xff6C6C6C)),
                    ),
                  ),
                  value: selectedPrice,
                  items: const [
                    DropdownMenuItem(
                        value: '50',
                        child: Text("50")),
                    DropdownMenuItem(
                        value: '60',
                        child: Text("60")),
                    DropdownMenuItem(
                        value: '70',
                        child: Text("70")),
                    DropdownMenuItem(
                        value: '80',
                        child: Text("80")),
                  ],
                  onChanged: (value) {
                    selectedPrice = value;
                    setState(() {});
                  },
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
                          RangeValues(
                              selectedSubCat!.minPrice
                                  .toDouble(),
                              selectedSubCat!.maxPrice
                                  .toDouble());
                      RangeValues selectingRange =
                          RangeValues(
                              selectedSubCat!.minPrice
                                  .toDouble(),
                              selectedSubCat!.maxPrice
                                  .toDouble());
                      return StatefulBuilder(builder:
                          (context, setStatet2) {
                        return OverlayPortal(
                          controller:
                              overlayPortalController,
                          overlayChildBuilder:
                              (context) {
                            return Positioned(
                              left: 20, // To Change,
                              top: 590, // Fix,
                              child: Material(
                                borderRadius:
                                    BorderRadius
                                        .circular(10),
    
                                // clipBehavior: Clip.antiAlias,
                                child: Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                          vertical:
                                              12,
                                          horizontal:
                                              20),
                                  width: 300,
                                  clipBehavior:
                                      Clip.antiAlias,
                                  decoration:
                                      BoxDecoration(
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                                10),
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 1,
                                        spreadRadius:
                                            .5,
                                        color: Color(
                                            0xffD5D5D5),
                                        offset:
                                            Offset(
                                                0, 0),
                                      )
                                    ],
                                    color: const Color(
                                        0xffFEF7F3),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text(
                                        "Price",
                                        style: GoogleFonts
                                            .poppins(
                                          color: const Color(
                                              0xff6C6C6C),
                                          fontSize:
                                              16,
                                          fontWeight:
                                              FontWeight
                                                  .w600,
                                        ),
                                      ),
                                      const SizedBox(
                                          height: 7),
                                      Text(
                                        '₹${selectingRange.start.toInt()} - ₹${selectingRange.end.toInt()}',
                                        style: GoogleFonts.brawler(
                                            letterSpacing:
                                                1,
                                            fontWeight:
                                                FontWeight
                                                    .w600,
                                            fontSize:
                                                16,
                                            color: const Color(
                                                0xff111111)),
                                      ),
                                      const SizedBox(
                                          height: 7),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .start,
                                        // mainAxisSize:
                                        //     MainAxisSize.min,
                                        children: [
                                          RangeSlider(
                                            min: rangeValue
                                                .start,
                                            max: rangeValue
                                                .end,
                                            values:
                                                selectingRange,
                                            divisions:
                                                50,
                                            activeColor:
                                                const Color(
                                                    0xff95170D),
                                            inactiveColor:
                                                const Color(
                                                    0xffD9D9D9),
                                            onChanged:
                                                (value) {
                                              selectingRange =
                                                  value;
                                              setStatet2(
                                                  () {});
                                            },
                                          ),
                                          const Spacer(),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  side: const BorderSide(
                                                      color: Color(
                                                          0xff111111)),
                                                  backgroundColor: Colors
                                                      .transparent,
                                                  shadowColor: Colors
                                                      .transparent,
                                                  overlayColor: Colors
                                                      .transparent,
                                                  surfaceTintColor: Colors
                                                      .transparent,
                                                  elevation:
                                                      0),
                                              onPressed:
                                                  () {
                                                selectedRange =
                                                    selectingRange;
                                                setState(
                                                    () {});
                                                overlayPortalController
                                                    .hide();
                                              },
                                              child:
                                                  Text(
                                                "Go",
                                                style: GoogleFonts.poppins(
                                                    color: const Color(0xff111111),
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
                            color: Color(0xff6C6C6C),
                            fontSize: 14),
                      ),
                      icon: const Icon(
                        CupertinoIcons.chevron_down,
                        color: Color(0xff6C6C6C),
                        size: 18,
                      ),
                      decoration:
                          const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Color(0xff6C6C6C)),
                        ),
                        disabledBorder:
                            OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Color(0xff6C6C6C)),
                        ),
                        enabledBorder:
                            OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Color(0xff6C6C6C)),
                        ),
                        focusedBorder:
                            OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Color(0xff6C6C6C)),
                        ),
                      ),
                      items: const [],
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ),
              if (selectedPrice != null ||
                  selectedRange != null ||
                  selectedType != null)
                const SizedBox(height: 20),
              if (selectedPrice != null ||
                  selectedRange != null ||
                  selectedType != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                      onPressed: () {
                        clearFilters();
                      },
                      icon: const Icon(
                          CupertinoIcons.xmark),
                      label: const Text(
                          "Clear filters")),
                )
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
          const SizedBox(height: 30), */

        favouriteProducts.isEmpty
            ? const Center(
                child: Text("No Product to Display"),
              )
            : StaggeredGrid.extent(
                maxCrossAxisExtent: widget.screenWidth < 500 ? 400 : 300,
                mainAxisSpacing: 25,
                crossAxisSpacing: 25,
                // spacing: 25,
                // runSpacing: 25,
                children: [
                  ...List.generate(
                    favouriteProducts.length,
                    (index) {
                      // final image = index % 2 == 0
                      //     ? 'assets/money_envol_image.png'
                      //     : 'assets/gift_sets_image.png';
                      // final text =
                      //     index % 2 == 0 ? "GFT SETS" : "MONEY ENVELOPES";
                      final product = favouriteProducts[index];
                      return InkWell(
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            context.go("${Routes.product}/${product.docId}");
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (context) {
                            //     return const SudarshanProductDetails();
                            //   },
                            // ));
                          },
                          child:
                              ProductBagWid(product: product, forHome: false));
                    },
                  )
                ],
              ),
      ],
    );
  }
}
