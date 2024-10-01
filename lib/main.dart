import 'package:flutter/material.dart';
import 'package:sudarshan_creations/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sudarshan_creations/views/sudarshan_account.dart';
import 'package:sudarshan_creations/views/sudarshan_allproducts.dart';
import 'package:sudarshan_creations/views/sudarshan_homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sudarshan Creations',
      home: SudarshanHomePage(),
    );
    // return MaterialApp.router(
    //   title: 'Sudardshan Creations',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   routerConfig: _router,
    // );
  }
}
