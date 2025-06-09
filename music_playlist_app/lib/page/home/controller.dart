import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_playlist_app/page/home/model.dart';

class AppHomeController extends GetxController {
  RxList<music_info_model> music_list = RxList<music_info_model>();
  RxList<author_model> author_list = RxList<author_model>(); // <author_model>
  RxInt Index = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadData(); // ไม่ควรทำ async กับ onInit โดยตรง
  }

  Future<void> loadData() async {
    await getMusicList();
    await getAuthorList();
  }

  Future<void> getMusicList() async {
    final respones =
        await rootBundle.loadString('assets/files/music_info.json');
    music_list.value = (jsonDecode(respones) as List)
        .map((e) => music_info_model.fromJson(e))
        .toList();
  }

  Future<void> getAuthorList() async {
    final respones = await rootBundle.loadString('assets/files/authors.json');
    author_list.value = (jsonDecode(respones) as List)
        .map((e) => author_model.fromJson(e))
        .toList();
  }
}
