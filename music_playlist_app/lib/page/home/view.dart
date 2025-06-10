import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_playlist_app/page/home/widget/top_body.dart';
import 'package:music_playlist_app/page/home/widget/list_music.dart';
import 'package:music_playlist_app/page/home/controller.dart';
import 'package:music_playlist_app/page/home/widget/ิbottombar.dart';
import 'package:music_playlist_app/page/home/widget/my_playlist.dart';

class AppHome extends StatelessWidget {
  AppHomeController controller = Get.put(AppHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[50],
        appBar: AppBar(
          title: const Text('Music Playlist App',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
          backgroundColor: Colors.cyan[800],
        ),
        body: Container(
          height: double.infinity,
          child: Column(children: [
            topBody(),
            Obx(() {
              if (controller.Index.value == 0) {
                return listMusic();
              } else if (controller.Index.value == 1) {
                return Myplaylist(context);
              } else {
                return SizedBox.shrink();
              }
            })
          ]),
        ),
        bottomNavigationBar: Obx(() => bottomBar()));
  }
}
