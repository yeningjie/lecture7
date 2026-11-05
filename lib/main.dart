import 'package:flutter/material.dart';

import 'data/book_repository.dart';
import 'pages/about_page.dart';
import 'pages/detail_page.dart';
import 'pages/home_page.dart';
import 'pages/list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BookRepository.load();
  runApp(const AppSkeletonApp());
}

class AppSkeletonApp extends StatelessWidget {
  const AppSkeletonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '书架',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F7DF3)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F6FB),
      ),
      // 课程统一采用命名式路由：4 条路由全部在这里注册。
      routes: {
        '/': (_) => const HomePage(),
        '/list': (_) => const ListPage(),
        '/detail': (_) => const DetailPage(),
        '/about': (_) => const AboutPage(),
      },
    );
  }
}
