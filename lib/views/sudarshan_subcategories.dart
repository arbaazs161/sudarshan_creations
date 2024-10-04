import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:sudarshan_creations/shared/responsive.dart';
import '../shared/router.dart';
import 'sudarshan_allproducts.dart';
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
  @override
  Widget build(BuildContext context) {
    return ResponsiveWid(
      mobile: Scaffold(
        backgroundColor: const Color(0xffFEF7F3),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              const SubCatProductTopBar(),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 1200,

                    // imp: Min height calculation (deviceHeight- footerheight - top section height - extra height of sizedbox between widgets)
                    minHeight:
                        MediaQuery.sizeOf(context).height - 200 - 350 - 100,
                  ),
                  child: StaggeredGrid.extent(
                    maxCrossAxisExtent: 400,
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 25,
                    children: [
                      ...List.generate(
                        6,
                        (index) {
                          final image = index % 2 == 0
                              ? 'assets/money_envol_image.png'
                              : 'assets/gift_sets_image.png';
                          final text =
                              index % 2 == 0 ? "GIFT SETS" : "MONEY ENVELOPES";
                          return InkWell(
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                context.go("${Routes.subcategory}/id");

                                // Navigator.push(context, MaterialPageRoute(
                                //   builder: (context) {
                                //     return const SudarshanDisplayAllProducts(
                                //         subCatId: "");
                                //   },
                                // ));
                              },
                              child: SubCatCardWid(image: image, text: text));
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
              const SubCatProductTopBar(),
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
                        6,
                        (index) {
                          final image = index % 2 == 0
                              ? 'assets/money_envol_image.png'
                              : 'assets/gift_sets_image.png';
                          final text =
                              index % 2 == 0 ? "GIFT SETS" : "MONEY ENVELOPES";
                          return InkWell(
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                context.go("${Routes.subcategory}/id");

                                // Navigator.push(context, MaterialPageRoute(
                                //   builder: (context) {
                                //     return const SudarshanDisplayAllProducts(
                                //         subCatId: "");
                                //   },
                                // ));
                              },
                              child: SubCatCardWid(image: image, text: text));
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
  }
}
