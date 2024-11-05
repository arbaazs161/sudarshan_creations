
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudarshan_creations/controller/home_controller.dart';
import 'package:sudarshan_creations/shared/responsive.dart';
import 'package:sudarshan_creations/shared/router.dart';
import 'package:sudarshan_creations/views/widgets/cart_card.dart';
import 'package:sudarshan_creations/views/widgets/footer.dart';
import 'package:sudarshan_creations/views/widgets/product_bag.dart';
import 'package:sudarshan_creations/views/widgets/sub_cat_product_topbar.dart';
import 'package:sudarshan_creations/views/widgets/top_appbar.dart';
import 'package:sudarshan_creations/views/wrapper.dart';

final _cartScaffKey = GlobalKey<ScaffoldState>();

class SudarshanCartPage extends StatefulWidget {
  const SudarshanCartPage({super.key});

  @override
  State<SudarshanCartPage> createState() => _SudarshanCartPageState();
}

class _SudarshanCartPageState extends State<SudarshanCartPage> {
  double totalPrice = 0;

  void calculateTotalPrice(HomeCtrl hctrl) {
    totalPrice = 0; // Reset to ensure we don't keep adding on rebuilds
    for (var item in hctrl.cartItems) {
      final selectedVariant = item.product?.variants
          .firstWhereOrNull((element) => element.id == item.vId);
      if (selectedVariant != null && selectedVariant.fixedPrice != null) {
        totalPrice += item.qty.toDouble() * selectedVariant.fixedPrice!.toDouble();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    //int index;
    
    // print(hctrl.cartItems.length);
    // for(index =0; index<hctrl.cartItems.length; index++){
    //   final selectedVariant =
    //                               hctrl.cartItems[index].product?.variants.firstWhereOrNull((element) => element.id==hctrl.cartItems[index].vId);
    //                               print("Line 1 ${hctrl.cartItems[index].qty.toDouble()}");
    //                               print("Line 2 ${selectedVariant!.fixedPrice!.toDouble()}");
    //                               totalPrice = totalPrice + hctrl.cartItems[index].qty.toDouble() * selectedVariant!.fixedPrice!.toDouble();
    //                               print("Line 3 ${totalPrice}");
    // }

    return GetBuilder<HomeCtrl>(
      builder: (ctrl) {

        calculateTotalPrice(ctrl);

        return ResponsiveWid(
          mobile: Wrapper(
            scafkey: _cartScaffKey,
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
                        minHeight:
                            MediaQuery.sizeOf(context).height - 200 - 300 - 70,
                      ),
                      child: Column(
                        children: [
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
          desktop: Wrapper(
            scafkey: _cartScaffKey,
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  //const PageHeaderTopBar(title: "Shopping Cart"),
                  
                  SizedBox(
        height: 200,
        child: Stack(
          children: [
            
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 25),
              child: Column(
                children: [
                  const TopAppBar(mobile: false),
                  const Divider(color: Color(0xffB58543)),
                  const Spacer(),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Row(
                      children: [
                        Expanded( flex: 3,
                          child: Text(
                            "Shopping Cart",
                            style: GoogleFonts.brawler(
                              color: const Color(0xff95170D),
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
  child: Center( // Center the Text widget
    child: Text(
      "Order Summary",
      style: GoogleFonts.brawler(
        color: const Color(0xff95170D),
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
)

                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    

                 
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
                         const SizedBox(height: 50),
                         Row(
                           children: [
                             Expanded(flex: 3,
                               child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: ctrl.cartItems.length,
                                itemBuilder: (context, index){
                                  return CartCardWid(forHome: false, cartModel: ctrl.cartItems[index],);
                                }
                               
                               ),
                             ),
                             Expanded(
                              
                               child: Column(
                                 children: [
                        //           Text(
                        //   "Order Summary",
                        //   style: GoogleFonts.brawler(
                        //     color: const Color(0xff95170D),
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                                   Container(
                                    //height: 300,
                                    width: 500,
                                                             decoration: const BoxDecoration(
                                                               //border: Border.all(color: Colors.black),
                                                               color: Colors.white
                                                               ,
                                                               
                                                             ),
                                                             child: Column(
                                                               children: [
                                    SummaryText(totalPrice: totalPrice, priceType: "Subtotal",),
                                    const SummaryText(totalPrice: 0, priceType: "Delivery Charge"),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Divider(thickness: 1, color: Colors.grey),
                                    ),  // Adjust thickness and color as needed

                                    SummaryText(totalPrice: totalPrice, priceType: "Estimated Total"),
                                    Padding(
  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
  child: SizedBox(
    width: double.infinity, // Make button fill the parent container width
    child: ElevatedButton(
      onPressed: () {
        print("Hello");
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, // Text color
        backgroundColor: const Color.fromRGBO(143, 23, 13, 1), // Background color
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        textStyle: GoogleFonts.leagueSpartan( // Custom font style
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: const Text("Continue to Checkout"),
    ),
  ),
)

                                                               ],
                                                             ),
                                                            ),
                                 ],
                               ),
                             ),
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
    );
  
  }
}

class SummaryText extends StatelessWidget {
  const SummaryText({
    super.key,
    required this.totalPrice,
    required this.priceType
  });

  final double totalPrice;
  final String priceType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex:3,child: Text("$priceType", style: GoogleFonts.leagueSpartan(
              
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),)),
          
          Expanded(child: Text("₹ ${totalPrice}", style: GoogleFonts.poppins(
              
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),)),
        ],
      ),
    );
  }
}
