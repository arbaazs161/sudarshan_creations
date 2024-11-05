import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                  context.go(Routes.cart);

                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) {
                  //     return const SudarshanDisplayFavourites();
                  //   },
                  // ));
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
            const Icon(
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