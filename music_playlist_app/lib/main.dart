import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_playlist_app/approute/pages.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: AppPages().pages,
    );
  }
}
