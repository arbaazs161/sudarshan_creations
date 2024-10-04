import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudarshan_creations/controller/home_controller.dart';
import 'package:sudarshan_creations/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sudarshan_creations/shared/router.dart';
import 'package:sudarshan_creations/views/sudarshan_homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(HomeCtrl());
  }

  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Sudarshan Creations',
    //   home: SudarshanHomePage(),
    // );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Sudardshan Creations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
