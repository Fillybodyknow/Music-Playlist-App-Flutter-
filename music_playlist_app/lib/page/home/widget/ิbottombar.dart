import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:music_playlist_app/page/home/controller.dart';

Widget bottomBar() {
  AppHomeController controller = Get.find();
  final music = controller.currentPlaying.value;
  if (music == null) return const SizedBox.shrink();
  return Obx(() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    controller.author_list[music.author_id].trumbnail,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(music.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(controller.author_list[music.author_id].name,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),
                Obx(() => IconButton(
                      icon: Icon(
                        controller.isPlaying.value
                            ? Icons.pause
                            : Icons.play_arrow_rounded,
                        size: 30,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (controller.isPlaying.value) {
                          controller.pauseMusic();
                        } else {
                          controller.resumeMusic();
                        }
                      },
                    )),
              ],
            ),
            Obx(() {
              final pos = controller.position.value;
              final dur = controller.duration.value;

              // ถ้า duration ยังเป็น 0 (ยังไม่ได้ค่า) ก็ไม่แสดง progress bar
              if (dur.inMilliseconds == 0) {
                return const SizedBox.shrink();
              }

              return Column(
                children: [
                  Slider(
                    min: 0,
                    max: dur.inMilliseconds.toDouble(),
                    value: pos.inMilliseconds
                        .clamp(0, dur.inMilliseconds)
                        .toDouble(),
                    onChanged: (value) {
                      controller
                          .seekMusic(Duration(milliseconds: value.toInt()));
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.formatDuration(pos)),
                      Text(controller.formatDuration(dur)),
                    ],
                  ),
                ],
              );
            }),
          ],
        ),
      ));
}
