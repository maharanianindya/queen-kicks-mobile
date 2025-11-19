import 'package:flutter/material.dart';
import 'package:queen_kicks/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const brandColor = Color.fromARGB(255, 229, 179, 196); 

    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Queen Kicks',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: brandColor)
              .copyWith(
                primary: brandColor,
                secondary: brandColor,
              ),
        ),
        home: const LoginPage(),
      ),
    );
  }
}



