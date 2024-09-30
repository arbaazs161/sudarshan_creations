import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sudarshan_account.dart';
import '../sudarshan_favourites.dart';
import '../sudarshan_homepage.dart';

class TopAppBarDesktop extends StatelessWidget {
  const TopAppBarDesktop({super.key});

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
            Navigator.push(context, MaterialPageRoute(
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
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
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
            const SizedBox(width: 15),
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
            Navigator.push(context, MaterialPageRoute(
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
        Row(
          children: [
            /*  InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
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
            const SizedBox(width: 15), */
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
