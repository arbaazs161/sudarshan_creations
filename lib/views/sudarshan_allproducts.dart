import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudarshan_creations/controller/home_controller.dart';
import 'package:sudarshan_creations/shared/const.dart';
import 'package:sudarshan_creations/shared/methods.dart';
import 'package:sudarshan_creations/shared/responsive.dart';
import 'package:sudarshan_creations/shared/router.dart';
import 'package:sudarshan_creations/views/widgets/pagination_button.dart';
import 'package:sudarshan_creations/views/wrapper.dart';
import '../models/main_category.dart';
import '../models/product_model.dart';
import '../models/sub_category.dart';
import '../shared/firebase.dart';
import 'widgets/footer.dart';
import 'widgets/product_bag.dart';
import 'widgets/sub_cat_product_topbar.dart';

final _allProductsScafKey = GlobalKey<ScaffoldState>();

class SudarshanDisplayAllProducts extends StatefulWidget {
  const SudarshanDisplayAllProducts(
      {super.key, required this.maincategoryId, this.autofocus = false});
  final String maincategoryId;
  final bool autofocus;
  @override
  State<SudarshanDisplayAllProducts> createState() =>
      _SudarshanDisplayAllProductsState();
}

class _SudarshanDisplayAllProductsState
    extends State<SudarshanDisplayAllProducts> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeCtrl>(
      builder: (hCtrl) {
        return SudarshanDisplayAllProducts2(
          key: ValueKey(DateTime.now()),
          autofocus: widget.autofocus,
          maincategoryId: widget.maincategoryId,
          allActiveMainCat: hCtrl.homeCategories,
        );
      },
    );
  }
}

class SudarshanDisplayAllProducts2 extends StatefulWidget {
  const SudarshanDisplayAllProducts2(
      {super.key,
      required this.maincategoryId,
      required this.allActiveMainCat,
      required this.autofocus});
  final String maincategoryId;
  final List<MainCategory> allActiveMainCat;
  final bool autofocus;

  @override
  State<SudarshanDisplayAllProducts2> createState() =>
      _SudarshanDisplayAllProducts2State();
}

class _SudarshanDisplayAllProducts2State
    extends State<SudarshanDisplayAllProducts2> {
  int currentPage = 1; // 1-based for user readability
  // int itemsPerPage = 2;
  int totalItems = 0;
  int totalPages = 0;
  final searchController = TextEditingController();
  bool dataloaded = false;

  List<List<ProductModel>> paginatedData = [];
  DocumentSnapshot? lastFetchedDoc;
  Timer? debounce;
  // List<ProductModel> allproducts = [];
  // List<ProductModel> filteredProducts = [];
  SubCategory? selectedSubCat;
  List<SubCategory> allMainSubCats = [];
  MainCategory? selmainCategoryModel;
  bool pageloaded = false;

  @override
  void initState() {
    super.initState();
    selmainCategoryModel ??= widget.allActiveMainCat
        .firstWhereOrNull((element) => element.docId == widget.maincategoryId);

    getAllSubCategories();
    // getProductsData();
    initializePagination();
  }

  getAllSubCategories() async {
    final subCatsnap = await FBFireStore.subCategories
        .where('mainCatId', isEqualTo: widget.maincategoryId)
        .where('isActive', isEqualTo: true)
        .get();

    allMainSubCats.clear();
    allMainSubCats
        .addAll(subCatsnap.docs.map((e) => SubCategory.fromSnap(e)).toList());
  }

  // getProductsData() async {
  //   if (selmainCategoryModel == null) return;
  //   final basesnap = selectedSubCat == null
  //       ? FBFireStore.products
  //           .where('mainCatDocId', isEqualTo: selmainCategoryModel!.docId)
  //       : FBFireStore.products
  //           .where('mainCatDocId', isEqualTo: selmainCategoryModel!.docId)
  //           .where('subCatDocId', isEqualTo: selectedSubCat!.docId);
  //   final productSnap = await basesnap.get();
  //   allproducts.clear();
  //   allproducts.addAll(productSnap.docs.map((e) => ProductModel.fromSnap(e)));
  //   filteredProducts.clear();
  //   filteredProducts.addAll(allproducts);

  //   loaded = true;
  //   setState(() {});
  // }

  // NORMAL DATA
  Future<void> initializePagination() async {
    try {
      lastFetchedDoc = null;
      paginatedData.clear();
      if (selmainCategoryModel == null) return;
      currentPage = 1;
      final basesnap = selectedSubCat == null
          ? FBFireStore.products
              .where('mainCatDocId', isEqualTo: selmainCategoryModel!.docId)
              .where('available', isEqualTo: true)
          : FBFireStore.products
              .where('mainCatDocId', isEqualTo: selmainCategoryModel!.docId)
              .where('subCatDocId', isEqualTo: selectedSubCat!.docId)
              .where('available', isEqualTo: true);
      final productCountSnap = await basesnap.count().get();
      totalItems = productCountSnap.count ?? 0;
      totalPages = (totalItems / perPageUsers).ceil();
      await fetchPage(1); // fetch first page (1-based)
      dataloaded = true;
      pageloaded = true;
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // SEARCHED DATA
  getSearchData(String str) async {
    dataloaded = false;
    setState(() {});
    if (selmainCategoryModel == null) return;

    final basesnap = selectedSubCat == null
        ? FBFireStore.products
            .where('available', isEqualTo: true)
            .where('mainCatDocId', isEqualTo: selmainCategoryModel!.docId)
        : FBFireStore.products
            .where('available', isEqualTo: true)
            .where('mainCatDocId', isEqualTo: selmainCategoryModel!.docId)
            .where('subCatDocId', isEqualTo: selectedSubCat!.docId);
    final userCountSnap = await basesnap
        .where('lowerName', isGreaterThanOrEqualTo: str)
        .where('lowerName', isLessThanOrEqualTo: "$str\uf7ff")
        .count()
        .get();
    totalItems = userCountSnap.count ?? 0;
    totalPages = (totalItems / perPageUsers).ceil();
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 200), () async {
      await fetchPage(1, forSearch: true);
      setState(() {});
    }); // fetch first page (1-based)
    dataloaded = true;
    setState(() {});
  }

  Future<void> fetchPage(int pageIndex, {bool forSearch = false}) async {
    try {
      if (selmainCategoryModel == null) return;

      int pageZeroIndex = pageIndex - 1;
      final str = searchController.text.toLowerCase().trim();
      if (pageZeroIndex < paginatedData.length &&
          paginatedData[pageZeroIndex].isNotEmpty) {
        return;
      }
      final basesnap = selectedSubCat == null
          ? FBFireStore.products
              .where('available', isEqualTo: true)
              .where('mainCatDocId', isEqualTo: selmainCategoryModel!.docId)
          : FBFireStore.products
              .where('available', isEqualTo: true)
              .where('mainCatDocId', isEqualTo: selmainCategoryModel!.docId)
              .where('subCatDocId', isEqualTo: selectedSubCat!.docId);
      Query query = forSearch
          ? basesnap
              .where('lowerName', isGreaterThanOrEqualTo: str)
              .where('lowerName', isLessThanOrEqualTo: "$str\uf7ff")
              .orderBy('lowerName')
              .limit(perPageUsers)
          : basesnap.orderBy('lowerName').limit(perPageUsers);

      if (lastFetchedDoc != null) {
        query = query.startAfterDocument(lastFetchedDoc!);
      }

      final snap = await query.get();
      if (snap.docs.isNotEmpty) {
        final users = snap.docs
            .map((doc) => ProductModel.fromSnap(
                doc as QueryDocumentSnapshot<Map<String, dynamic>>))
            // .where((e) => e != null)
            .cast<ProductModel>()
            .toList();
        lastFetchedDoc = snap.docs.last;

        while (paginatedData.length <= pageZeroIndex) {
          paginatedData.add([]);
        }
        paginatedData[pageZeroIndex] = users;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void handlePageChange(int newPage) async {
    dataloaded = false;
    setState(() {});
    await fetchPage(newPage,
        forSearch: searchController.text.trim().isNotEmpty);
    setState(() {
      dataloaded = true;
      currentPage = newPage;
    });
  }

  String? selectedType;
  String? selectedPrice;
  RangeValues? selectedRange;

  final overlayPortalController = OverlayPortalController();

  clearFilters() {
    selectedPrice = null;
    selectedRange = null;
    selectedType = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = (currentPage - 1) < paginatedData.length
        ? paginatedData[currentPage - 1]
        : [];
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    // selmainCategoryModel = Get.find<HomeCtrl>()
    //     .homeCategories
    //     .firstWhereOrNull((element) => element.docId == widget.maincategoryId);
    filteredProducts.sort((a, b) =>
        int.tryParse(a.name.split(' ').last)
            ?.compareTo(int.tryParse(b.name.split(' ').last) ?? 0) ??
        0);

    return true
        ? true
            ? Wrapper(
                scafkey: _allProductsScafKey,
                body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: !pageloaded
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
                            SubCatProductTopBar(
                                mainCategoryModel: selmainCategoryModel),
                            const SizedBox(height: 30),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              constraints: const BoxConstraints(
                                maxWidth: 800,
                                // maxHeight: 45,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      onChanged: (value) async {
                                        // getSearchedData(value);
                                        if (debounce?.isActive ?? false) {
                                          debounce?.cancel();
                                        }
                                        debounce = Timer(
                                            const Duration(milliseconds: 500),
                                            () async {
                                          paginatedData.clear();
                                          lastFetchedDoc = null;
                                          if (value.trim().isNotEmpty) {
                                            await getSearchData(
                                                value.toLowerCase().trim());
                                          } else {
                                            initializePagination();
                                          }
                                        });
                                      },
                                      autofocus: widget.autofocus,
                                      controller: searchController,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 6, 6, 6),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 15),
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: const Text(
                                              "Search",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                        hintText: ' Search products...',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.5,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            // color: Colors.grey,
                                            // width: .8,
                                            color: Color.fromARGB(
                                                255, 226, 224, 224),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            // color: Colors.grey,
                                            // width: .8,
                                            color: Color.fromARGB(
                                                255, 226, 224, 224),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            // color: Colors.black,
                                            // width: .8,
                                            color: Color.fromARGB(
                                                255, 226, 224, 224),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            SingleChildScrollView(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                spacing: 10,
                                children: [
                                  ...List.generate(
                                    widget.allActiveMainCat.length,
                                    (index) {
                                      bool selected = selmainCategoryModel!
                                              .docId ==
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
                                              vertical: 11, horizontal: 13.5),
                                          decoration: BoxDecoration(
                                            boxShadow: selected
                                                ? [
                                                    const BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 235, 235, 235),
                                                      blurRadius: 5,
                                                      spreadRadius: 0,
                                                      offset: Offset(0, 0),
                                                    ),
                                                  ]
                                                : null,
                                            color: true
                                                ? selected
                                                    ? Colors.black
                                                    : Colors.white
                                                : selected
                                                    ? const Color(0xffFFE6DF)
                                                    : Colors.white,
                                            border: Border.all(
                                                width: 1.2,
                                                color: selected
                                                    ? Colors.black
                                                    : const Color.fromARGB(
                                                        255, 226, 224, 224)
                                                //  const Color(0xffBDBDBD)
                                                ),
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                                    .allActiveMainCat[index]
                                                    .name),
                                                style: GoogleFonts.mulish(
                                                    color: selected
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 13.5,
                                                    height: 0,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
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
                                              vertical: 7, horizontal: 15),
                                          decoration: BoxDecoration(
                                            color: true
                                                ? const Color.fromARGB(
                                                    255, 245, 245, 245)
                                                : selected
                                                    ? const Color(0xffFFE6DF)
                                                    : Colors.white,
                                            boxShadow: selected
                                                ? [
                                                    const BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 221, 221, 221),
                                                      blurRadius: 3,
                                                      spreadRadius: 0,
                                                      offset: Offset(0, 2),
                                                    ),
                                                  ]
                                                : null,
                                            border: selected
                                                ? Border.all(
                                                    width: .3,
                                                    color:
                                                        const Color(0xffBDBDBD))
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                                style: TextStyle(
                                                    color: selected
                                                        ? const Color(
                                                            0xff0a0a0a)
                                                        : const Color(
                                                            0xff737373),
                                                    fontSize: 12.5,
                                                    letterSpacing: .4,
                                                    wordSpacing: 1,
                                                    height: 0,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                            const SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 1200,
                                  // imp: Min height calculation (deviceHeight- footerheight - top section height - extra height of sizedbox between widgets)
                                  minHeight:
                                      MediaQuery.sizeOf(context).height - 440,
                                ),
                                child: Column(
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
                                    !dataloaded
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : filteredProducts.isEmpty
                                            ? const Center(
                                                child: Text(
                                                    "No Product to Display"),
                                              )
                                            : StaggeredGrid.extent(
                                                maxCrossAxisExtent:
                                                    screenWidth < 500
                                                        ? 264
                                                        : 300,
                                                mainAxisSpacing: 25,
                                                crossAxisSpacing: 25,

                                                // alignment:
                                                //     WrapAlignment.start,
                                                // runAlignment:
                                                //     WrapAlignment.start,
                                                // spacing: 25,
                                                // runSpacing: 25,
                                                // spacing: 25,
                                                // runSpacing: 25,
                                                children: [
                                                  ...List.generate(
                                                    filteredProducts.length,
                                                    (index) {
                                                      // final image = index % 2 == 0
                                                      //     ? 'assets/money_envol_image.png'
                                                      //     : 'assets/gift_sets_image.png';
                                                      // final text =
                                                      //     index % 2 == 0 ? "GFT SETS" : "MONEY ENVELOPES";
                                                      final product =
                                                          filteredProducts[
                                                              index];
                                                      return Container(
                                                        // constraints:
                                                        //     const BoxConstraints(
                                                        //   maxWidth: 264,
                                                        // ),
                                                        child: InkWell(
                                                          highlightColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          splashColor: Colors
                                                              .transparent,
                                                          onTap: () {
                                                            context.go(
                                                                "${Routes.product}/${product.docId}");
                                                            // Navigator.push(context, MaterialPageRoute(
                                                            //   builder: (context) {
                                                            //     return const SudarshanProductDetails();
                                                            //   },
                                                            // ));
                                                          },
                                                          child: ProductBagWid(
                                                              height:
                                                                  screenWidth <
                                                                          500
                                                                      ? 250
                                                                      : 330,
                                                              product: product,
                                                              forHome: false),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                  ],
                                ),
                              ),
                            ),
                            if (totalPages > 1) ...[
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: DynamicPagination(
                                  currentPage: currentPage,
                                  totalPages: totalPages,
                                  onPageChanged: handlePageChange,
                                ),
                              ),
                            ],
                            const SizedBox(height: 50),
                            const SudarshanFooterSection(),
                          ],
                        ),
                ),
              )
            : ResponsiveWid(
                mobile: Wrapper(
                  scafkey: _allProductsScafKey,
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
                              SubCatProductTopBar(
                                  mainCategoryModel: selmainCategoryModel),
                              const SizedBox(height: 50),
                              SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    ...List.generate(
                                      widget.allActiveMainCat.length,
                                      (index) {
                                        bool selected =
                                            selmainCategoryModel!.docId ==
                                                widget.allActiveMainCat[index]
                                                    .docId;
                                        return InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: selected
                                                  ? const Color(0xffFFE6DF)
                                                  : Colors.white,
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffBDBDBD)),
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                                      .allActiveMainCat[index]
                                                      .name),
                                                  style: GoogleFonts.mulish(
                                                      color: const Color(
                                                          0xff828282),
                                                      fontSize: 12,
                                                      height: 0,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                              const SizedBox(height: 50),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 1200,
                                      // imp: Min height calculation (deviceHeight- footerheight - top section height - extra height of sizedbox between widgets)
                                      minHeight:
                                          MediaQuery.sizeOf(context).height -
                                              200 -
                                              300 -
                                              70,
                                    ),
                                    child: Column(
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
                                        StaggeredGrid.extent(
                                          maxCrossAxisExtent:
                                              screenWidth < 500 ? 400 : 300,
                                          mainAxisSpacing: 25,
                                          crossAxisSpacing: 25,
                                          // spacing: 25,
                                          // runSpacing: 25,
                                          children: [
                                            ...List.generate(
                                              filteredProducts.length,
                                              (index) {
                                                // final image = index % 2 == 0
                                                //     ? 'assets/money_envol_image.png'
                                                //     : 'assets/gift_sets_image.png';
                                                // final text =
                                                //     index % 2 == 0 ? "GFT SETS" : "MONEY ENVELOPES";
                                                final product =
                                                    filteredProducts[index];
                                                return InkWell(
                                                    highlightColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    splashColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      context.go(
                                                          "${Routes.product}/${product.docId}");
                                                      // Navigator.push(context, MaterialPageRoute(
                                                      //   builder: (context) {
                                                      //     return const SudarshanProductDetails();
                                                      //   },
                                                      // ));
                                                    },
                                                    child: ProductBagWid(
                                                        product: product,
                                                        forHome: false));
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                              const SizedBox(height: 50),
                              const SudarshanFooterSection(),
                            ],
                          ),
                  ),
                ),
                desktop: Wrapper(
                  scafkey: _allProductsScafKey,
                  body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: !dataloaded
                          ? SizedBox(
                              height: screenHeight,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                SubCatProductTopBar(
                                    mainCategoryModel: selmainCategoryModel),
                                const SizedBox(height: 50),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 1200,
                                      // imp: Min height calculation (deviceHeight- footerheight - top section height - extra height of sizedbox between widgets)
                                      minHeight:
                                          MediaQuery.sizeOf(context).height -
                                              60 -
                                              350 -
                                              100,
                                    ),
                                    child: filteredProducts.isNotEmpty
                                        ? Column(
                                            children: [
                                              /*       Row(
                                            children: [
                                              Expanded(
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField(
                                                    hint: const Text(
                                                      'Product Type',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff6C6C6C),
                                                          fontSize: 14),
                                                    ),
                                                    icon: const Icon(
                                                      CupertinoIcons
                                                          .chevron_down,
                                                      color: Color(0xff6C6C6C),
                                                      size: 18,
                                                    ),
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff6C6C6C)),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff6C6C6C)),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff6C6C6C)),
                                                      ),
                                                    ),
                                                    value: selectedType,
                                                    items: const [
                                                      DropdownMenuItem(
                                                          value: 'Enquiry',
                                                          child:
                                                              Text("Enquiry")),
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
                                              ),
                                              const SizedBox(width: 20),
                                              Expanded(
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField(
                                                    hint: const Text(
                                                      'Price',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff6C6C6C),
                                                          fontSize: 14),
                                                    ),
                                                    icon: const Icon(
                                                      CupertinoIcons
                                                          .chevron_down,
                                                      color: Color(0xff6C6C6C),
                                                      size: 18,
                                                    ),
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff6C6C6C)),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff6C6C6C)),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff6C6C6C)),
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
                                              ),
                                              const SizedBox(width: 20),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    overlayPortalController
                                                        .show();
                                                    showDialog(
                                                      barrierColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (context) {
                                                        RangeValues rangeValue =
                                                            RangeValues(
                                                                selectedSubCat!
                                                                    .minPrice
                                                                    .toDouble(),
                                                                selectedSubCat!
                                                                    .maxPrice
                                                                    .toDouble());
                                                        RangeValues
                                                            selectingRange =
                                                            RangeValues(
                                                                selectedSubCat!
                                                                    .minPrice
                                                                    .toDouble(),
                                                                selectedSubCat!
                                                                    .maxPrice
                                                                    .toDouble());
                                                        return StatefulBuilder(
                                                            builder: (context,
                                                                setStatet2) {
                                                          return OverlayPortal(
                                                            controller:
                                                                overlayPortalController,
                                                            overlayChildBuilder:
                                                                (context) {
                                                              return Positioned(
                                                                left:
                                                                    865, // To Change,
                                                                top:
                                                                    460, // Fix,
                                                                child: Material(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),

                                                                  // clipBehavior: Clip.antiAlias,
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
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
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      boxShadow: const [
                                                                        BoxShadow(
                                                                          blurRadius:
                                                                              1,
                                                                          spreadRadius:
                                                                              .5,
                                                                          color:
                                                                              Color(0xffD5D5D5),
                                                                          offset: Offset(
                                                                              0,
                                                                              0),
                                                                        )
                                                                      ],
                                                                      color: const Color(
                                                                          0xffFEF7F3),
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "Price",
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            color:
                                                                                const Color(0xff6C6C6C),
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                7),
                                                                        Text(
                                                                          '₹${selectingRange.start.toInt()} - ₹${selectingRange.end.toInt()}',
                                                                          style: GoogleFonts.brawler(
                                                                              letterSpacing: 1,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 16,
                                                                              color: const Color(0xff111111)),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                7),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          // mainAxisSize:
                                                                          //     MainAxisSize.min,
                                                                          children: [
                                                                            RangeSlider(
                                                                              min: rangeValue.start,
                                                                              max: rangeValue.end,
                                                                              values: selectingRange,
                                                                              divisions: 50,
                                                                              activeColor: const Color(0xff95170D),
                                                                              inactiveColor: const Color(0xffD9D9D9),
                                                                              onChanged: (value) {
                                                                                selectingRange = value;
                                                                                setStatet2(() {});
                                                                              },
                                                                            ),
                                                                            const Spacer(),
                                                                            ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(side: const BorderSide(color: Color(0xff111111)), backgroundColor: Colors.transparent, shadowColor: Colors.transparent, overlayColor: Colors.transparent, surfaceTintColor: Colors.transparent, elevation: 0),
                                                                                onPressed: () {
                                                                                  selectedRange = selectingRange;
                                                                                  setState(() {});
                                                                                  overlayPortalController.hide();
                                                                                },
                                                                                child: Text(
                                                                                  "Go",
                                                                                  style: GoogleFonts.poppins(color: const Color(0xff111111), fontSize: 13.5),
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
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child:
                                                          DropdownButtonFormField(
                                                        hint: const Text(
                                                          'Price Range',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff6C6C6C),
                                                              fontSize: 14),
                                                        ),
                                                        icon: const Icon(
                                                          CupertinoIcons
                                                              .chevron_down,
                                                          color:
                                                              Color(0xff6C6C6C),
                                                          size: 18,
                                                        ),
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xff6C6C6C)),
                                                          ),
                                                          disabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xff6C6C6C)),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xff6C6C6C)),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xff6C6C6C)),
                                                          ),
                                                        ),
                                                        items: const [],
                                                        onChanged: (value) {},
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (selectedPrice != null ||
                                                  selectedRange != null ||
                                                  selectedType != null)
                                                const SizedBox(width: 20),
                                              if (selectedPrice != null ||
                                                  selectedRange != null ||
                                                  selectedType != null)
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: OutlinedButton.icon(
                                                      onPressed: () {
                                                        clearFilters();
                                                      },
                                                      icon: const Icon(
                                                          CupertinoIcons.xmark),
                                                      label: const Text(
                                                          "Clear filters")),
                                                ),
                                              const Spacer(),
                                              Expanded(
                                                  child: TextFormField(
                                                cursorColor:
                                                    const Color.fromARGB(
                                                        255, 153, 149, 149),
                                                decoration:
                                                    const InputDecoration(
                                                  prefixIcon: Icon(
                                                    CupertinoIcons.search,
                                                    size: 18,
                                                    color: Color(0xff6C6C6C),
                                                  ),
                                                  hintText: ' Search',
                                                  hintStyle: TextStyle(
                                                      color: Color(0xff6C6C6C),
                                                      fontSize: 14),
                                                  border: OutlineInputBorder(
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
                                              )),
                                            ],
                                          ),
                                          const SizedBox(height: 50), */
                                              StaggeredGrid.extent(
                                                maxCrossAxisExtent: 300,
                                                mainAxisSpacing: 25,
                                                crossAxisSpacing: 25,
                                                // spacing: 25,
                                                // runSpacing: 25,
                                                children: [
                                                  ...List.generate(
                                                    filteredProducts.length,
                                                    (index) {
                                                      final product =
                                                          filteredProducts[
                                                              index];
                                                      // final image = index % 2 == 0
                                                      //     ? 'assets/money_envol_image.png'
                                                      //     : 'assets/gift_sets_image.png';
                                                      // final text =
                                                      //     index % 2 == 0 ? "GFT SETS" : "MONEY ENVELOPES";
                                                      return InkWell(
                                                          highlightColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          splashColor: Colors
                                                              .transparent,
                                                          onTap: () {
                                                            context.go(
                                                                "${Routes.product}/${product.docId}");

                                                            // Navigator.push(context, MaterialPageRoute(
                                                            //   builder: (context) {
                                                            //     return const SudarshanProductDetails();
                                                            //   },
                                                            // ));
                                                          },
                                                          child: ProductBagWid(
                                                              product: product,
                                                              forHome: false));
                                                    },
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                        : const Center(
                                            child:
                                                Text('No products available')),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                const SudarshanFooterSection(),
                              ],
                            )),
                ),
              )
        : ResponsiveWid(
            mobile: Wrapper(
              scafkey: _allProductsScafKey,
              // small: true,
              // backgroundColor: Colors.white,
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
                          SubCatProductTopBar(
                              forCatPage: false,
                              subCategoryModel: selectedSubCat),
                          const SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 1200,
                                // imp: Min height calculation (deviceHeight- footerheight - top section height - extra height of sizedbox between widgets)
                                minHeight: MediaQuery.sizeOf(context).height -
                                    200 -
                                    300 -
                                    70,
                              ),
                              child: selectedSubCat != null
                                  ? Column(
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
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(
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
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(
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
                                                  barrierColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    RangeValues rangeValue =
                                                        RangeValues(
                                                            selectedSubCat!
                                                                .minPrice
                                                                .toDouble(),
                                                            selectedSubCat!
                                                                .maxPrice
                                                                .toDouble());
                                                    RangeValues selectingRange =
                                                        RangeValues(
                                                            selectedSubCat!
                                                                .minPrice
                                                                .toDouble(),
                                                            selectedSubCat!
                                                                .maxPrice
                                                                .toDouble());
                                                    return StatefulBuilder(
                                                        builder: (context,
                                                            setStatet2) {
                                                      return OverlayPortal(
                                                        controller:
                                                            overlayPortalController,
                                                        overlayChildBuilder:
                                                            (context) {
                                                          return Positioned(
                                                            left:
                                                                20, // To Change,
                                                            top: 590, // Fix,
                                                            child: Material(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),

                                                              // clipBehavior: Clip.antiAlias,
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        12,
                                                                    horizontal:
                                                                        20),
                                                                width: 300,
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  boxShadow: const [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          1,
                                                                      spreadRadius:
                                                                          .5,
                                                                      color: Color(
                                                                          0xffD5D5D5),
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              0),
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
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            7),
                                                                    Text(
                                                                      '₹${selectingRange.start.toInt()} - ₹${selectingRange.end.toInt()}',
                                                                      style: GoogleFonts.brawler(
                                                                          letterSpacing:
                                                                              1,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              const Color(0xff111111)),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            7),
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
                                                                              const Color(0xff95170D),
                                                                          inactiveColor:
                                                                              const Color(0xffD9D9D9),
                                                                          onChanged:
                                                                              (value) {
                                                                            selectingRange =
                                                                                value;
                                                                            setStatet2(() {});
                                                                          },
                                                                        ),
                                                                        const Spacer(),
                                                                        ElevatedButton(
                                                                            style: ElevatedButton.styleFrom(
                                                                                side: const BorderSide(color: Color(0xff111111)),
                                                                                backgroundColor: Colors.transparent,
                                                                                shadowColor: Colors.transparent,
                                                                                overlayColor: Colors.transparent,
                                                                                surfaceTintColor: Colors.transparent,
                                                                                elevation: 0),
                                                                            onPressed: () {
                                                                              selectedRange = selectingRange;
                                                                              setState(() {});
                                                                              overlayPortalController.hide();
                                                                            },
                                                                            child: Text(
                                                                              "Go",
                                                                              style: GoogleFonts.poppins(color: const Color(0xff111111), fontSize: 13.5),
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
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField(
                                                    hint: const Text(
                                                      'Price Range',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff6C6C6C),
                                                          fontSize: 14),
                                                    ),
                                                    icon: const Icon(
                                                      CupertinoIcons
                                                          .chevron_down,
                                                      color: Color(0xff6C6C6C),
                                                      size: 18,
                                                    ),
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff6C6C6C)),
                                                      ),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff6C6C6C)),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff6C6C6C)),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff6C6C6C)),
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
                                                alignment:
                                                    Alignment.centerRight,
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
                                        const SizedBox(height: 30),
                                        StaggeredGrid.extent(
                                          maxCrossAxisExtent:
                                              screenWidth < 500 ? 400 : 300,
                                          mainAxisSpacing: 25,
                                          crossAxisSpacing: 25,
                                          // spacing: 25,
                                          // runSpacing: 25,
                                          children: [
                                            ...List.generate(
                                              filteredProducts.length,
                                              (index) {
                                                // final image = index % 2 == 0
                                                //     ? 'assets/money_envol_image.png'
                                                //     : 'assets/gift_sets_image.png';
                                                // final text =
                                                //     index % 2 == 0 ? "GFT SETS" : "MONEY ENVELOPES";
                                                final product =
                                                    filteredProducts[index];
                                                return InkWell(
                                                    highlightColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    splashColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      context.go(
                                                          "${Routes.product}/${product.docId}");
                                                      // Navigator.push(context, MaterialPageRoute(
                                                      //   builder: (context) {
                                                      //     return const SudarshanProductDetails();
                                                      //   },
                                                      // ));
                                                    },
                                                    child: ProductBagWid(
                                                        product: product,
                                                        forHome: false));
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  : const Center(
                                      child: Text('Sub-Category unavailable')),
                            ),
                          ),
                          const SizedBox(height: 50),
                          const SudarshanFooterSection(),
                        ],
                      ),
              ),
            ),
            desktop: Wrapper(
              scafkey: _allProductsScafKey,
              // small: false,
              body: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: !dataloaded
                    ? SizedBox(
                        height: screenHeight,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        ),
                      )
                    : selectedSubCat != null
                        ? Column(
                            children: [
                              SubCatProductTopBar(
                                  forCatPage: false,
                                  subCategoryModel: selectedSubCat),
                              const SizedBox(height: 50),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 1200,
                                    // imp: Min height calculation (deviceHeight- footerheight - top section height - extra height of sizedbox between widgets)
                                    minHeight:
                                        MediaQuery.sizeOf(context).height -
                                            60 -
                                            350 -
                                            100,
                                  ),
                                  child: filteredProducts.isNotEmpty
                                      ? Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child:
                                                        DropdownButtonFormField(
                                                      hint: const Text(
                                                        'Product Type',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff6C6C6C),
                                                            fontSize: 14),
                                                      ),
                                                      icon: const Icon(
                                                        CupertinoIcons
                                                            .chevron_down,
                                                        color:
                                                            Color(0xff6C6C6C),
                                                        size: 18,
                                                      ),
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xff6C6C6C)),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xff6C6C6C)),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xff6C6C6C)),
                                                        ),
                                                      ),
                                                      value: selectedType,
                                                      items: const [
                                                        DropdownMenuItem(
                                                            value: 'Enquiry',
                                                            child: Text(
                                                                "Enquiry")),
                                                        DropdownMenuItem(
                                                            value: 'Order',
                                                            child:
                                                                Text("Order")),
                                                      ],
                                                      onChanged: (value) {
                                                        selectedType = value;
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                Expanded(
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child:
                                                        DropdownButtonFormField(
                                                      hint: const Text(
                                                        'Price',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff6C6C6C),
                                                            fontSize: 14),
                                                      ),
                                                      icon: const Icon(
                                                        CupertinoIcons
                                                            .chevron_down,
                                                        color:
                                                            Color(0xff6C6C6C),
                                                        size: 18,
                                                      ),
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xff6C6C6C)),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xff6C6C6C)),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xff6C6C6C)),
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
                                                ),
                                                const SizedBox(width: 20),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      overlayPortalController
                                                          .show();
                                                      showDialog(
                                                        barrierColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (context) {
                                                          RangeValues
                                                              rangeValue =
                                                              RangeValues(
                                                                  selectedSubCat!
                                                                      .minPrice
                                                                      .toDouble(),
                                                                  selectedSubCat!
                                                                      .maxPrice
                                                                      .toDouble());
                                                          RangeValues
                                                              selectingRange =
                                                              RangeValues(
                                                                  selectedSubCat!
                                                                      .minPrice
                                                                      .toDouble(),
                                                                  selectedSubCat!
                                                                      .maxPrice
                                                                      .toDouble());
                                                          return StatefulBuilder(
                                                              builder: (context,
                                                                  setStatet2) {
                                                            return OverlayPortal(
                                                              controller:
                                                                  overlayPortalController,
                                                              overlayChildBuilder:
                                                                  (context) {
                                                                return Positioned(
                                                                  left:
                                                                      865, // To Change,
                                                                  top:
                                                                      460, // Fix,
                                                                  child:
                                                                      Material(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),

                                                                    // clipBehavior: Clip.antiAlias,
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              12,
                                                                          horizontal:
                                                                              20),
                                                                      width:
                                                                          300,
                                                                      clipBehavior:
                                                                          Clip.antiAlias,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                            blurRadius:
                                                                                1,
                                                                            spreadRadius:
                                                                                .5,
                                                                            color:
                                                                                Color(0xffD5D5D5),
                                                                            offset:
                                                                                Offset(0, 0),
                                                                          )
                                                                        ],
                                                                        color: const Color(
                                                                            0xffFEF7F3),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "Price",
                                                                            style:
                                                                                GoogleFonts.poppins(
                                                                              color: const Color(0xff6C6C6C),
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 7),
                                                                          Text(
                                                                            '₹${selectingRange.start.toInt()} - ₹${selectingRange.end.toInt()}',
                                                                            style: GoogleFonts.brawler(
                                                                                letterSpacing: 1,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 16,
                                                                                color: const Color(0xff111111)),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 7),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            // mainAxisSize:
                                                                            //     MainAxisSize.min,
                                                                            children: [
                                                                              RangeSlider(
                                                                                min: rangeValue.start,
                                                                                max: rangeValue.end,
                                                                                values: selectingRange,
                                                                                divisions: 50,
                                                                                activeColor: const Color(0xff95170D),
                                                                                inactiveColor: const Color(0xffD9D9D9),
                                                                                onChanged: (value) {
                                                                                  selectingRange = value;
                                                                                  setStatet2(() {});
                                                                                },
                                                                              ),
                                                                              const Spacer(),
                                                                              ElevatedButton(
                                                                                  style: ElevatedButton.styleFrom(side: const BorderSide(color: Color(0xff111111)), backgroundColor: Colors.transparent, shadowColor: Colors.transparent, overlayColor: Colors.transparent, surfaceTintColor: Colors.transparent, elevation: 0),
                                                                                  onPressed: () {
                                                                                    selectedRange = selectingRange;
                                                                                    setState(() {});
                                                                                    overlayPortalController.hide();
                                                                                  },
                                                                                  child: Text(
                                                                                    "Go",
                                                                                    style: GoogleFonts.poppins(color: const Color(0xff111111), fontSize: 13.5),
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
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child:
                                                            DropdownButtonFormField(
                                                          hint: const Text(
                                                            'Price Range',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff6C6C6C),
                                                                fontSize: 14),
                                                          ),
                                                          icon: const Icon(
                                                            CupertinoIcons
                                                                .chevron_down,
                                                            color: Color(
                                                                0xff6C6C6C),
                                                            size: 18,
                                                          ),
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xff6C6C6C)),
                                                            ),
                                                            disabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xff6C6C6C)),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xff6C6C6C)),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xff6C6C6C)),
                                                            ),
                                                          ),
                                                          items: const [],
                                                          onChanged: (value) {},
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if (selectedPrice != null ||
                                                    selectedRange != null ||
                                                    selectedType != null)
                                                  const SizedBox(width: 20),
                                                if (selectedPrice != null ||
                                                    selectedRange != null ||
                                                    selectedType != null)
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: OutlinedButton.icon(
                                                        onPressed: () {
                                                          clearFilters();
                                                        },
                                                        icon: const Icon(
                                                            CupertinoIcons
                                                                .xmark),
                                                        label: const Text(
                                                            "Clear filters")),
                                                  ),
                                                const Spacer(),
                                                Expanded(
                                                    child: TextFormField(
                                                  cursorColor:
                                                      const Color.fromARGB(
                                                          255, 153, 149, 149),
                                                  decoration:
                                                      const InputDecoration(
                                                    prefixIcon: Icon(
                                                      CupertinoIcons.search,
                                                      size: 18,
                                                      color: Color(0xff6C6C6C),
                                                    ),
                                                    hintText: ' Search',
                                                    hintStyle: TextStyle(
                                                        color:
                                                            Color(0xff6C6C6C),
                                                        fontSize: 14),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xff6C6C6C)),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xff6C6C6C)),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xff6C6C6C)),
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
                                                  filteredProducts.length,
                                                  (index) {
                                                    final product =
                                                        filteredProducts[index];
                                                    // final image = index % 2 == 0
                                                    //     ? 'assets/money_envol_image.png'
                                                    //     : 'assets/gift_sets_image.png';
                                                    // final text =
                                                    //     index % 2 == 0 ? "GFT SETS" : "MONEY ENVELOPES";
                                                    return InkWell(
                                                        highlightColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        splashColor:
                                                            Colors.transparent,
                                                        onTap: () {
                                                          context.go(
                                                              "${Routes.product}/${product.docId}");

                                                          // Navigator.push(context, MaterialPageRoute(
                                                          //   builder: (context) {
                                                          //     return const SudarshanProductDetails();
                                                          //   },
                                                          // ));
                                                        },
                                                        child: ProductBagWid(
                                                            product: product,
                                                            forHome: false));
                                                  },
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      : const Center(
                                          child: Text('No products available')),
                                ),
                              ),
                              const SizedBox(height: 50),
                              const SudarshanFooterSection(),
                            ],
                          )
                        : const Center(child: Text('Sub-category unavailable')),
              ),
            ),
          );
  }
}
