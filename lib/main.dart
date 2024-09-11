import 'package:flutter/material.dart';
import 'package:sudarshan_creations/View/Auth/auth.dart';
import 'package:sudarshan_creations/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';

final GoRouter _router = GoRouter(routes: [
  
  GoRoute(path: "/", builder: (context, state) => const auth(),),

]);

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sudardshan Creations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}