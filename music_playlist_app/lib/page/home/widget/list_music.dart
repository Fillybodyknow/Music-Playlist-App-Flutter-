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
            return InkWell(
              onTap: () {
                controller.selectedMusicIndex.value =
                    controller.selectedMusicIndex.value == index ? null : index;

                if (controller.selectedMusicIndex.value == index) {
                  controller.currentPlaying.value = music;
                  controller.playMusic(
                      music); // ต้องมี music.audioPath เป็น path ของไฟล์
                } else {
                  controller.pauseMusic();
                  controller.currentPlaying.value = null;
                }
              },
              child: Obx(() {
                final isSelected = controller.selectedMusicIndex.value == index;
                return ListTile(
                  tileColor: isSelected ? Colors.cyan[900] : Colors.transparent,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8), // ปรับขอบโค้งได้
                    child: Image.asset(
                      controller.author_list[music.author_id].trumbnail,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(music.title,
                      style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black)),
                  subtitle: Text(controller.author_list[music.author_id].name,
                      style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.white : Colors.black)),
                  trailing: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: isSelected ? Colors.white : Colors.black),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.transparent,
                    ),
                    child: Icon(
                      isSelected ? Icons.pause : Icons.play_arrow_rounded,
                      color: isSelected ? Colors.white : Colors.black,
                      size: 25,
                    ),
                  ),
                );
              }),
            );
          },
          separatorBuilder: (context, index) => Divider(
                height: 0,
                color: Colors.transparent,
                thickness: 3,
              ),
          itemCount: controller.music_list.length));
}
