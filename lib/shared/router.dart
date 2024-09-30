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