import 'package:get/get.dart';
import 'package:music_playlist_app/approute/routes.dart';
import 'package:music_playlist_app/page/home/view.dart';

class AppPages {
  List<GetPage> pages = [
    GetPage(name: AppRoutes.home, page: () => AppHome()),
  ];
}
