import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_playlist_app/approute/pages.dart';
import 'package:music_playlist_app/page/home/controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AppHomeController());
  runApp(const MainApp());
}

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
