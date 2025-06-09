import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_playlist_app/page/home/controller.dart';
import 'package:music_playlist_app/page/home/model.dart';

Widget listMusic() {
  AppHomeController controller = Get.put(AppHomeController());
  return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            music_info_model music = controller.music_list[index];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8), // ปรับขอบโค้งได้
                child: Image.asset(
                  controller.author_list[music.author_id].trumbnail,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(music.title),
              subtitle: Text(controller.author_list[music.author_id].name),
            );
          },
          separatorBuilder: (context, index) => Divider(
                height: 0,
                color: Colors.transparent,
                thickness: 3,
              ),
          itemCount: controller.music_list.length));
}
