import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudarshan_creations/shared/methods.dart';
import 'package:sudarshan_creations/views/sudarshan_favourites.dart';

import '../../shared/router.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key, required this.mobile});
  final bool mobile;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: const Icon(
            Icons.menu,
            color: Color(0xff95170D),
            size: 28,
          ),
        ),
        const Spacer(),
        InkWell(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            context.go(Routes.home);

            // Navigator.push(context, MaterialPageRoute(
            //   builder: (context) {
            //     return const SudarshanHomePage();
            //   },
            // ));
          },
          child: SizedBox(
            height: 70,
            // width: 300,
            child: Image.asset(
              'assets/sudarshan_logo.png',
              fit: BoxFit.cover,
              // height: 100,
            ),
          ),
        ),
        const Spacer(),
        Row(
          children: [
            if (!mobile)
              InkWell(
                onTap: () {
                  context.go(Routes.account);

                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) {
                  //     return const SudarshanAccountPage();
                  //   },
                  // ));
                },
                child: const Icon(
                  CupertinoIcons.profile_circled,
                  color: Color(0xff95170D),
                  size: 25,
                ),
              ),
            if (!mobile) const SizedBox(width: 15),
            if (!mobile)
              InkWell(
                onTap: () {
                  //context.go(Routes.cart);

                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const SudarshanDisplayFavourites();
                    },
                  ));
                },
                child: const Icon(
                  CupertinoIcons.heart,
                  color: Color(0xff95170D),
                  size: 25,
                ),
              ),
            if (!mobile) const SizedBox(width: 15),
            const Icon(
              CupertinoIcons.search,
              color: Color(0xff95170D),
              size: 25,
            ),
            const SizedBox(width: 15),
            if (!mobile)
              InkWell(
                onTap: () {
                  //context.go(Routes.cart);
                  if (isLoggedIn()) {
                    context.go(Routes.cart);
                  } else {
                    context.go(Routes.account);
                  }

                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) {
                  //     return const SudarshanDisplayFavourites();
                  //   },
                  // ));
                },
                child: const Icon(
                  CupertinoIcons.shopping_cart,
                  color: Color(0xff95170D),
                  size: 25,
                ),
              ),
          ],
        )
      ],
    );
  }
}

class TopAppBarDesk extends StatelessWidget {
  const TopAppBarDesk({super.key, required this.mobile});
  final bool mobile;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      constraints: BoxConstraints(maxWidth: 1200),
  
      child: Row(
        children: [
          const Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.white,
                  size: 15,
                ),
                SizedBox(width: 10),
                Text("(+880) 1910 000251",
                    style: TextStyle(color: Colors.white, fontSize: 13)),
                SizedBox(width: 20),
                // VerticalDivider(color: Colors.white, width: 1,thickness: 3,),
                Icon(
                  CupertinoIcons.clock,
                  color: Colors.white,
                  size: 15,
                ),
                SizedBox(width: 10),
                Text("Mon-fri 10:00 AM - 6:00 PM",
                    style: TextStyle(color: Colors.white, fontSize: 13)),
              ],
            ),
          ),

          // Center logo
          Image.asset(
            'assets/sudarshan_logo_white.png', // Replace with your actual logo path
            height: 40,
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    context.go(Routes.account);
                  },
                  child: const Icon(
                    CupertinoIcons.profile_circled,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const SudarshanDisplayFavourites();
                      },
                    ));
                  },
                  child: const Icon(
                    CupertinoIcons.heart,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 15),
                const Icon(
                  CupertinoIcons.search,
                  color: Colors.white,
                  size: 25,
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    if (isLoggedIn()) {
                      context.go(Routes.cart);
                    } else {
                      context.go(Routes.account);
                    }
                  },
                  child: const Icon(
                    CupertinoIcons.shopping_cart,
                    color: Colors.white,
                    size: 25,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
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
/* 
class TopAppBarMobile extends StatelessWidget {
  const TopAppBarMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.menu,
          color: Color(0xff95170D),
          size: 28,
        ),
        const Spacer(),
        InkWell(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
           // Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const SudarshanHomePage();
              },
            ));
          },
          child: SizedBox(
            height: 70,
            // width: 300,
            child: Image.asset(
              'assets/sudarshan_logo.png',
              fit: BoxFit.cover,
              // height: 100,
            ),
          ),
        ),
        const Spacer(),
        const Row(
          children: [
            /*  InkWell(
              onTap: () {
               // Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const SudarshanAccountPage();
                  },
                ));
              },
              child: const Icon(
                CupertinoIcons.profile_circled,
                color: Color(0xff95170D),
                size: 25,
              ),
            ),
            const SizedBox(width: 15),
            InkWell(
              onTap: () {
               // Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const SudarshanDisplayFavourites();
                  },
                ));
              },
              child: const Icon(
                CupertinoIcons.heart,
                color: Color(0xff95170D),
                size: 25,
              ),
            ),
            const SizedBox(width: 15), */
            Icon(
              CupertinoIcons.search,
              color: Color(0xff95170D),
              size: 25,
            ),
            SizedBox(width: 15),
            Icon(
              CupertinoIcons.shopping_cart,
              color: Color(0xff95170D),
              size: 25,
            ),
          ],
        )
      ],
    );
  }
}
 */
