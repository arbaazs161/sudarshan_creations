import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudarshan_creations/views/sudarshan_account.dart';
import 'package:sudarshan_creations/views/sudarshan_allproducts.dart';
import 'package:sudarshan_creations/views/sudarshan_homepage.dart';
import 'package:sudarshan_creations/views/sudarshan_product_details.dart';
import '../views/sudarshan_cart_page.dart';
import '../views/sudarshan_favourites.dart';
import 'error_page.dart';

final routeHistory = [Routes.home];

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: Routes.home,
  routes: _routes,
  redirect: redirector,
  errorBuilder: (context, state) => const ErrorPage(),
);

FutureOr<String?> redirector(BuildContext context, GoRouterState state) {
  if (state.uri.path ==
      appRouter.routerDelegate.currentConfiguration.uri.path) {
    throw Exception('Router declined redirect');
  }
  return null;
  // routeHistory.add(state.uri.path);
  // if (isLoggedIn() && state.fullPath == Routes.auth) {
  //   return routeHistory.reversed.elementAt(1);
  //   // return Routes.home;
  // }
  // return null;
}

List<RouteBase> get _routes {
  return <RouteBase>[
    GoRoute(
      path: Routes.home,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(child: SudarshanHomePage()),
    ),
    GoRoute(
      path: Routes.account,
      pageBuilder: (BuildContext context, GoRouterState state) {
        final routeTo = state.extra as String?;

        return NoTransitionPage(child: SudarshanAccountPage(routeTo: routeTo));
      },
    ),
    GoRoute(
      path: Routes.cart,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const NoTransitionPage(child: SudarshanCartPage());
      },
    ),
    GoRoute(
      path: Routes.favourites,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(child: SudarshanDisplayFavourites()),
    ),
    GoRoute(
      path: '${Routes.product}/:id',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          NoTransitionPage(
              child: SudarshanProductDetails(
        productId: state.pathParameters['id'] ?? "",
      )),
    ),
    // GoRoute(
    //   path: '${Routes.subcategory}/:id',
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       NoTransitionPage(
    //           child: SudarshanDisplayAllProducts(
    //               subCatId: state.pathParameters['id'] ?? "")),
    // ),
    GoRoute(
      path: '${Routes.category}/:id',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          NoTransitionPage(
        child: SudarshanDisplayAllProducts(
            maincategoryId: state.pathParameters['id'] ?? ""),
      ),
    ),
    GoRoute(
      path: Routes.addressbook,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(child: AddressDetail()),
    ),
    // GoRoute(
    //   path: Routes.overview,
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       const NoTransitionPage(child: ProfileOverview()),
    // ),
    // GoRoute(
    //   path: Routes.orders,
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       const NoTransitionPage(child: MyOrders()),
    // ),
    // GoRoute(
    //   path: '${Routes.orders}/:oId',
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       NoTransitionPage(
    //           child: OrderDetails(orderDocId: state.pathParameters['oId'])),
    // ),
    // GoRoute(
    //   path: Routes.addressbook,
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       const NoTransitionPage(child: AddressBook()),
    // ),
    // GoRoute(
    //   path: Routes.contact,
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       const NoTransitionPage(child: ContactUs()),
    // ),
    // GoRoute(
    //   path: Routes.about,
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       const NoTransitionPage(child: AboutUs()),
    // ),
    // GoRoute(
    //   path: Routes.faqs,
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       const NoTransitionPage(child: FAQPage()),
    // ),
    // GoRoute(
    //   path: Routes.terms,
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       const NoTransitionPage(child: TermsAndConditions()),
    // ),
    // GoRoute(
    //   path: Routes.privacy,
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       const NoTransitionPage(child: PrivacyPolicy()),
    // ),
    // GoRoute(
    //     path: Routes.search,
    //     pageBuilder: (BuildContext context, GoRouterState state) {
    //       String searchedText = state.extra.toString();
    //       return NoTransitionPage(
    //           child: SearchPage(searchedText: searchedText));
    //     }),
    // GoRoute(
    //   path: Routes.returnAndExchange,
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       const NoTransitionPage(child: ReturnsAndExchange()),
    // ),
    // GoRoute(
    //   path: Routes.internationalShipping,
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       const NoTransitionPage(child: InternationalShipping()),
    // ),
    // GoRoute(
    //   path: Routes.refundPolicy,
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       const NoTransitionPage(child: Refunds()),
    // ),
    // GoRoute(
    //   path: Routes.refundPolicy,
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       const NoTransitionPage(child: ReturnPolicy()),
    // ),
    // GoRoute(
    //   path: Routes.shippingDelivery,
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       const NoTransitionPage(child: ShippingAndDelivery()),
    // ),
    // GoRoute(
    //   path: Routes.shippingDelivery,
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       const NoTransitionPage(child: ShippingAndDelivery()),
    // ),
  ];
}

class Routes {
  static const home = "/home";
  static const products = "/products";
  static const category = "/category";
  static const account = "/account";
  static const overview = "/overview";
  static const favourites = "/favourites";
  static const cart = "/cart";
  static const subcategory = "/sub-category";
  static const product = "/product";
  static const checkout = "/checkout";
  static const orders = "/orders";
  static const addressbook = "/addressbook";
  static const contact = "/contact";
  static const about = "/about";
  static const terms = "/terms";
  static const privacy = "/privacy";
  static const search = "/search";
}




/* import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'error_page.dart';
import 'methods.dart';

const homeRoute = Routes.vendors;

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: Routes.signin,
  routes: _routes,
  redirect: redirector,
  errorBuilder: (context, state) => const ErrorPage(),
);

FutureOr<String?> redirector(BuildContext context, GoRouterState state) {
  // routeHistory.add(state.uri.path);
  // if (isLoggedIn() && state.fullPath == Routes.auth) {
  //   return routeHistory.reversed.elementAt(1);
  //   // return Routes.home;
  // }
  if (isLoggedIn()) {
    if (state.fullPath == Routes.signin) {
      if (Get.isRegistered<HomeCtrl>()) {
        Future.delayed(const Duration(milliseconds: 10))
            .then((value) => Get.find<HomeCtrl>().update());
      }
      return homeRoute;
    } else {
      if (Get.isRegistered<HomeCtrl>()) Get.find<HomeCtrl>().update();
      return null;
    }
  } else {
    return Routes.signin;
  }
}

List<RouteBase> get _routes {
  return <RouteBase>[
    // GoRoute(
    //   path: '${Routes.category}/:name',
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       NoTransitionPage(
    //           child: CategoryWid(
    //     name: state.pathParameters['name'] ?? "",
    //   )),
    // ),
    ShellRoute(
        builder: (context, state, child) {
          if (!Get.isRegistered<HomeCtrl>()) Get.put(HomeCtrl());
          return DashboardScreen(child: child);
        },
        routes: [
          GoRoute(
            path: Routes.categories,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const NoTransitionPage(child: CategoriesPage()),
          ),
          GoRoute(
              path: '${Routes.category}/:id',
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  NoTransitionPage(
                      child: CategoryForm(
                    categoryId: state.pathParameters['id'] as String,
                  ))),
        ]),
    GoRoute(
      path: Routes.signin,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(child: LoginScreen()),
    ),
    // GoRoute(
    //   path: Routes.dashboard,
    //   pageBuilder: (BuildContext context, GoRouterState state) =>
    //       const NoTransitionPage(child: DashboardScreen()),
    // ),
  ];
}

class Routes {
  static const signin = '/signin';
  // static const dashboard = '/dashboard';
  static const vendors = '/vendors';
  static const newvendors = '/newvendors';
  static const vendor = '/vendor';
  static const users = '/users';
  static const basicanalytics = '/basicanalytics';
  static const categories = '/categories';
  static const category = '/category';
  static const cities = '/cities';
  static const banners = '/banners';
  static const settings = '/settings';
  // static const addon = '/addon';
  // static const notification = '/notification';
  // static const food = '/food';
  // static const report = '/report';
}

  // return isLoggedIn()
  //     ? (state.uri.path == Routes.auth ? Routes.home : null)
  //     : Routes.auth;
 */