import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sample/providers/auth_provider.dart';
import 'package:sample/providers/entries_provider.dart';
import 'package:sample/screens/entries-page.dart';
import 'package:sample/screens/homepage.dart';
import 'firebase_options.dart';

// ...

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EntriesProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hao Are You',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(229, 244, 241, 241),
        primarySwatch: const MaterialColor(
          0xFF238878,
          <int, Color>{
            50: Color(0xFFD6E8E1),
            100: Color(0xFFB1D1C8),
            200: Color(0xFF89B8AE),
            300: Color(0xFF60A093),
            400: Color(0xFF3A897A),
            500: Color(0xFF238878),
            600: Color(0xFF1D716E),
            700: Color(0xFF185C5F),
            800: Color(0xFF134A50),
            900: Color(0xFF0D373F),
          },
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/entries-page': (context) => EntriesPage()
      },
    );
  }
}
