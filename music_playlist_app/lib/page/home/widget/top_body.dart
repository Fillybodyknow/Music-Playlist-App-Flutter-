import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_playlist_app/page/home/controller.dart';

Widget topBody() {
  AppHomeController Controller = Get.put(AppHomeController());
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(color: Colors.cyan[800]),
    child: Obx(() => Row(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Controller.Index.value == 0
                              ? Colors.white
                              : Colors.transparent,
                          width: 5))),
              child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  )),
                  onPressed: () {
                    Controller.Index.value = 0;
                  },
                  child: Text("My Playlist",
                      style: TextStyle(
                          color: Controller.Index.value == 0
                              ? Colors.white
                              : Colors.cyan[100]))),
            )),
            // Expanded(
            //     child: Container(
            //   decoration: BoxDecoration(
            //       border: Border(
            //           bottom: BorderSide(
            //               color: Controller.Index.value == 1
            //                   ? Colors.white
            //                   : Colors.transparent,
            //               width: 5))),
            //   child: TextButton(
            //       style: ButtonStyle(
            //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(0.0),
            //         ),
            //       )),
            //       onPressed: () {
            //         Controller.Index.value = 1;
            //       },
            //       child: Text("My Playlist",
            //           style: TextStyle(
            //               color: Controller.Index.value == 1
            //                   ? Colors.white
            //                   : Colors.cyan[100]))),
            // )),
          ],
        )),
  );
}
