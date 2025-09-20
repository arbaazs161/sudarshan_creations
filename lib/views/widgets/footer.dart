import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudarshan_creations/shared/responsive.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SudarshanFooterSection extends StatelessWidget {
  const SudarshanFooterSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWid(
      mobile: Container(
        height: 140,
        // padding: const EdgeInsets.symmetric(vertical: 30),
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: 30),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      privacyPolicyDialog(context);
                    },
                    child: const Text(
                      "Privacy Policy",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const VerticalDivider(color: Colors.white),
                  InkWell(
                    onTap: () {
                      termsDialog(context);
                    },
                    child: const Text(
                      "Terms of Use",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const VerticalDivider(color: Colors.white),
                  InkWell(
                    onTap: () {
                      launchUrlString(
                          'https://www.instagram.com/sudarshancardsindia/');
                    },
                    child: const Text(
                      "Instagram",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 15),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     // IconButton(
            //     //   onPressed: () {},
            //     //   icon: const Icon(Icons.facebook),
            //     //   color: Colors.white,
            //     // ),
            //     // const SizedBox(width: 10),
            //     // InkWell(

            //     //   child:  SizedBox(
            //     //     height: 22,
            //     //     child: Image.asset(
            //     //       'assets/insta_logo.png',
            //     //       color: Colors.white,
            //     //     ),
            //     //   ),
            //     // )
            //   ],
            // ),
            const SizedBox(height: 15),
            Text(
              "© Sudarshan Cards.",
              style: GoogleFonts.brawler(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Developed by ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    launchUrlString('https://www.diwizon.com');
                  },
                  child: const Text(
                    "Diwizon",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                // const Opacity(
                //   opacity: 0,
                //   child: IconButton(
                //     onPressed: null,
                //     icon: Icon(Icons.facebook),
                //     color: Colors.white,
                //   ),
                // ),
                // const SizedBox(width: 10),
                // InkWell(
                //     onTap: () {
                //       launchUrlString(
                //           'https://www.instagram.com/sudarshancardsindia/');
                //     },
                //     child: const Text.rich(TextSpan(children: [
                //       const TextSpan(
                //         text: 'Developed by ',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 12,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       TextSpan(
                //         text: 'Diwizon',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 12,
                //           fontWeight: FontWeight.w600,
                //           decoration: TextDecoration.underline,
                //         ),
                //       ),
                //     ]))

                //     // Text(
                //     //   'Developed by Diwizon',
                //     // ),
                //     )
                // IconButton(
                //     onPressed: () {},
                //     icon: const Icon(Icons.crop_square_outlined),
                //     color: Colors.white)
              ],
            ),

            // Text(
            //   "All rights reserved.",
            //   style: GoogleFonts.brawler(
            //     color: Colors.white,
            //     fontSize: 12,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
          ],
        ),
      ),
      desktop: Container(
        height: 60,
        width: double.maxFinite,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Row(
                children: [
                  const Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "© Sudarshan Cards.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              privacyPolicyDialog(context);
                            },
                            child: const Text(
                              "Privacy Policy",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const VerticalDivider(color: Color(0xff303030)),
                          InkWell(
                            onTap: () {
                              termsDialog(context);
                            },
                            child: const Text(
                              "Terms of Use",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const VerticalDivider(color: Color(0xff303030)),
                          InkWell(
                            onTap: () {
                              launchUrlString(
                                  'https://www.instagram.com/sudarshancardsindia/');
                            },
                            child: const Text(
                              "Instagram",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Developed by ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            launchUrlString('https://www.diwizon.com');
                          },
                          child: const Text(
                            "Diwizon",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),

                        // const Opacity(
                        //   opacity: 0,
                        //   child: IconButton(
                        //     onPressed: null,
                        //     icon: Icon(Icons.facebook),
                        //     color: Colors.white,
                        //   ),
                        // ),
                        // const SizedBox(width: 10),
                        // InkWell(
                        //     onTap: () {
                        //       launchUrlString(
                        //           'https://www.instagram.com/sudarshancardsindia/');
                        //     },
                        //     child: const Text.rich(TextSpan(children: [
                        //       const TextSpan(
                        //         text: 'Developed by ',
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w600,
                        //         ),
                        //       ),
                        //       TextSpan(
                        //         text: 'Diwizon',
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w600,
                        //           decoration: TextDecoration.underline,
                        //         ),
                        //       ),
                        //     ]))

                        //     // Text(
                        //     //   'Developed by Diwizon',
                        //     // ),
                        //     )
                        // IconButton(
                        //     onPressed: () {},
                        //     icon: const Icon(Icons.crop_square_outlined),
                        //     color: Colors.white)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> privacyPolicyDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Container(
            // decoration: BoxDecoration(),
            // constraints: const BoxConstraints(maxWidth: 800, maxHeight: 800),
            constraints: const BoxConstraints(
                maxWidth: 800, maxHeight: 800, minHeight: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                // SizedBox(height: 15),
                const Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum et molestie ligula. Nam ac rhoncus risus. Suspendisse potenti. Donec sagittis massa erat, sit amet dapibus urna posuere vitae. Etiam ligula eros, placerat sed sagittis et, consectetur sit amet odio. In at fermentum libero. Donec tincidunt quis justo sit amet lacinia. Donec elementum tellus vel justo gravida, at sagittis turpis malesuada. Nulla laoreet eu orci et feugiat. Nunc maximus odio volutpat nisl rhoncus, non scelerisque massa varius. Vivamus auctor tincidunt venenatis. Phasellus dictum turpis at justo aliquet commodo. Nullam laoreet sagittis nisi, quis finibus erat. In enim magna, sollicitudin eu gravida ac, gravida at lorem.\n",
                          style: TextStyle(fontSize: 11.5),
                        ),
                        Text(
                          "Maecenas eget magna dui. Nullam eleifend mi a nulla lacinia, a convallis felis consequat. Ut fringilla orci ante, nec porta elit eleifend a. Sed eget mollis massa. Morbi in placerat sapien. Integer congue non enim ac laoreet. Nunc sodales mollis dolor non bibendum. Pellentesque suscipit mauris ut vulputate congue. Donec luctus nisi ut condimentum faucibus. Suspendisse malesuada nisl sollicitudin maximus porta. Donec tempor nibh in lorem auctor tempor.\n",
                          style: TextStyle(fontSize: 11.5),
                        ),
                        Text(
                          "Nunc non leo ligula. Etiam eros purus, bibendum et elit a, cursus suscipit leo. Mauris auctor porttitor quam, non porta risus aliquet at. Sed pellentesque nibh a elit lacinia tempor. Aenean varius purus at nisi accumsan eleifend. Pellentesque posuere ex vitae diam vehicula, id laoreet felis finibus. Curabitur semper, lorem non sodales semper, purus metus scelerisque nibh, sit amet aliquam ligula orci a purus. Ut felis ante, porta non dolor at, ultricies porttitor nulla. Mauris interdum imperdiet risus, blandit ultrices libero venenatis eget.\n",
                          style: TextStyle(fontSize: 11.5),
                        ),
                        Text(
                          "Pellentesque non purus blandit arcu viverra auctor et id lorem. In cursus mauris ante, tempus semper lacus ullamcorper quis. Proin vehicula mattis imperdiet. Donec at pellentesque erat. Aenean bibendum laoreet metus pretium tempus. In ultricies metus et lorem posuere, et efficitur ante porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Quisque ac velit ac diam imperdiet vulputate nec non lectus. Donec consectetur et eros suscipit laoreet. Nullam massa augue, cursus vel sapien suscipit, vehicula commodo lacus. Nulla dignissim egestas accumsan. Aliquam erat volutpat. Sed ac velit sit amet magna accumsan molestie. Vestibulum consectetur ipsum eu dapibus faucibus. Duis suscipit vel tellus nec elementum. Nulla tincidunt ipsum sed enim posuere, nec laoreet nulla aliquet.\n",
                          style: TextStyle(fontSize: 11.5),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          overlayColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Done")),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> termsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Container(
            // decoration: BoxDecoration(),
            constraints: const BoxConstraints(
                maxWidth: 800, maxHeight: 800, minHeight: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Text(
                    "Terms & Condition",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                // SizedBox(height: 15),
                const Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "1.)",
                              style: TextStyle(fontSize: 12.5),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum et molestie ligula. Nam ac rhoncus risus. Suspendisse potenti. Donec sagittis massa erat, sit amet dapibus urna posuere vitae. Etiam ligula eros, placerat sed sagittis et, consectetur sit amet odio. In at fermentum libero. Donec tincidunt quis justo sit amet lacinia. Donec elementum tellus vel justo gravida, at sagittis turpis malesuada. Nulla laoreet eu orci et feugiat. Nunc maximus odio volutpat nisl rhoncus, non scelerisque massa varius. Vivamus auctor tincidunt venenatis. Phasellus dictum turpis at justo aliquet commodo. Nullam laoreet sagittis nisi, quis finibus erat. In enim magna, sollicitudin eu gravida ac, gravida at lorem.\n",
                                style: TextStyle(fontSize: 11.5),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "2.)",
                              style: TextStyle(fontSize: 12.5),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Maecenas eget magna dui. Nullam eleifend mi a nulla lacinia, a convallis felis consequat. Ut fringilla orci ante, nec porta elit eleifend a. Sed eget mollis massa. Morbi in placerat sapien. Integer congue non enim ac laoreet. Nunc sodales mollis dolor non bibendum. Pellentesque suscipit mauris ut vulputate congue. Donec luctus nisi ut condimentum faucibus. Suspendisse malesuada nisl sollicitudin maximus porta. Donec tempor nibh in lorem auctor tempor.\n",
                                style: TextStyle(fontSize: 11.5),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "3.)",
                              style: TextStyle(fontSize: 12.5),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Nunc non leo ligula. Etiam eros purus, bibendum et elit a, cursus suscipit leo. Mauris auctor porttitor quam, non porta risus aliquet at. Sed pellentesque nibh a elit lacinia tempor. Aenean varius purus at nisi accumsan eleifend. Pellentesque posuere ex vitae diam vehicula, id laoreet felis finibus. Curabitur semper, lorem non sodales semper, purus metus scelerisque nibh, sit amet aliquam ligula orci a purus. Ut felis ante, porta non dolor at, ultricies porttitor nulla. Mauris interdum imperdiet risus, blandit ultrices libero venenatis eget.\n",
                                style: TextStyle(fontSize: 11.5),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "4.)",
                              style: TextStyle(fontSize: 12.5),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Pellentesque non purus blandit arcu viverra auctor et id lorem. In cursus mauris ante, tempus semper lacus ullamcorper quis. Proin vehicula mattis imperdiet. Donec at pellentesque erat. Aenean bibendum laoreet metus pretium tempus. In ultricies metus et lorem posuere, et efficitur ante porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Quisque ac velit ac diam imperdiet vulputate nec non lectus. Donec consectetur et eros suscipit laoreet. Nullam massa augue, cursus vel sapien suscipit, vehicula commodo lacus. Nulla dignissim egestas accumsan. Aliquam erat volutpat. Sed ac velit sit amet magna accumsan molestie. Vestibulum consectetur ipsum eu dapibus faucibus. Duis suscipit vel tellus nec elementum. Nulla tincidunt ipsum sed enim posuere, nec laoreet nulla aliquet.\n",
                                style: TextStyle(fontSize: 11.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          overlayColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Done")),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
