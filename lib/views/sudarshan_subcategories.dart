import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sudarshan_creations/controller/home_controller.dart';
import 'package:sudarshan_creations/models/main_category.dart';
import 'package:sudarshan_creations/models/sub_category.dart';
import 'package:sudarshan_creations/shared/firebase.dart';
import 'package:sudarshan_creations/shared/methods.dart';
import 'package:sudarshan_creations/shared/responsive.dart';
import '../shared/router.dart';
import 'widgets/footer.dart';
import 'widgets/product_card.dart';
import 'widgets/sub_cat_product_topbar.dart';

class SudarshanDisplayAllSubCategories extends StatefulWidget {
  const SudarshanDisplayAllSubCategories({super.key, required this.categoryId});
  final String categoryId;
  @override
  State<SudarshanDisplayAllSubCategories> createState() =>
      _SudarshanDisplayAllSubCategoriesState();
}

class _SudarshanDisplayAllSubCategoriesState
    extends State<SudarshanDisplayAllSubCategories> {
  List<SubCategory> subCategories = [];
  MainCategory? mainCategoryModel;
  @override
  void initState() {
    super.initState();
    getSubCategoriesData();
  }

  getSubCategoriesData() async {
    // final ctrl = Get.find<HomeCtrl>();
    // print("-=-=-=-=-==-=${ctrl.categories.length}");

    // mainCategoryModel = ctrl.categories.firstWhereOrNull((element) {
    //   return element.docId == widget.categoryId;
    // });
    final subCategoriesSnap = await FBFireStore.subCategories
        .where('mainCatId', isEqualTo: widget.categoryId)
        .where('isActive', isEqualTo: true)
        .get();
    subCategories =
        subCategoriesSnap.docs.map((e) => SubCategory.fromSnap(e)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // getSubCategoriesData();
    return GetBuilder<HomeCtrl>(builder: (ctrl) {
      mainCategoryModel = ctrl.homeCategories.firstWhereOrNull((element) {
        return element.docId == widget.categoryId;
      });
      return ResponsiveWid(
        mobile: Scaffold(
          backgroundColor: const Color(0xffFEF7F3),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                SubCatProductTopBar(mainCategoryModel: mainCategoryModel),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 1200,

                      // imp: Min height calculation (deviceHeight- footerheight - top section height - extra height of sizedbox between widgets)
                      minHeight:
                          MediaQuery.sizeOf(context).height - 200 - 300 - 100,
                    ),
                    child: StaggeredGrid.extent(
                      maxCrossAxisExtent: 400,
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 25,
                      children: [
                        ...List.generate(
                          subCategories.length,
                          (index) {
                            final image = subCategories[index].image;
                            final text = subCategories[index].name;
                            return InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  context.go(
                                      "${Routes.subcategory}/${subCategories[index].docId}");

                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) {
                                  //     return const SudarshanDisplayAllProducts(
                                  //         subCatId: "");
                                  //   },
                                  // ));
                                },
                                child: SubCatCardWid(
                                    image: image,
                                    text: capilatlizeFirstLetter(text)));
                          },
                        )
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
                SubCatProductTopBar(mainCategoryModel: mainCategoryModel),
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
                    child: StaggeredGrid.extent(
                      maxCrossAxisExtent: 300,
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 25,
                      children: [
                        ...List.generate(
                          subCategories.length,
                          (index) {
                            final image = subCategories[index].image;
                            final text = subCategories[index].name;
                            return InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  context.go(
                                      "${Routes.subcategory}/${subCategories[index].docId}");

                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) {
                                  //     return const SudarshanDisplayAllProducts(
                                  //         subCatId: "");
                                  //   },
                                  // ));
                                },
                                child: SubCatCardWid(
                                    image: image,
                                    text: capilatlizeFirstLetter(text)));
                          },
                        )
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
    });
  }
}
