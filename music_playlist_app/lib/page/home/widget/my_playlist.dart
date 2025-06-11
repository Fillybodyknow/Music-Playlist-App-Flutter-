// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:music_playlist_app/page/home/controller.dart';
// import 'package:music_playlist_app/page/home/model.dart';

// Widget Myplaylist(BuildContext context) {
//   AppHomeController controller = Get.put(AppHomeController());
//   return FutureBuilder(
//       future: controller.readPlaylistListFromFile(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return const Center(child: Text('Error loading playlist list.'));
//         } else {
//           return SafeArea(
//               bottom: true,
//               child: Obx(() => Container(
//                     height: controller.currentPlaying.value != null
//                         ? MediaQuery.of(context).size.height * 0.65
//                         : MediaQuery.of(context).size.height * 0.8,
//                     child: Stack(
//                       children: [
//                         Center(
//                           child: Obx(
//                             () {
//                               if (controller.playlist_list.isEmpty) {
//                                 return Text(
//                                   'ไม่พบ Playlist',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.cyan[800],
//                                   ),
//                                 );
//                               } else {
//                                 return ListView.separated(
//                                     itemBuilder: (context, index) {
//                                       playlist_model playlist =
//                                           controller.playlist_list[index];
//                                       return InkWell(
//                                         onTap: () {
//                                           // ถ้าอยากเพิ่ม event กด playlist
//                                         },
//                                         child: ListTile(
//                                           tileColor: Colors.transparent,
//                                           leading: ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                             child:
//                                                 Icon(Icons.music_note_outlined),
//                                           ),
//                                           title: Text(
//                                             playlist.playlist_name,
//                                             style:
//                                                 TextStyle(color: Colors.black),
//                                           ),
//                                           trailing: Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               // Container(
//                                               //   padding:
//                                               //       const EdgeInsets.all(8),
//                                               //   decoration: BoxDecoration(
//                                               //     border: Border.all(
//                                               //         color: Colors.black),
//                                               //     borderRadius:
//                                               //         BorderRadius.circular(50),
//                                               //     color: Colors.transparent,
//                                               //   ),
//                                               //   child: Icon(Icons.folder_copy),
//                                               // ),
//                                               IconButton(
//                                                 style: ButtonStyle(
//                                                   maximumSize:
//                                                       MaterialStateProperty.all(
//                                                           const Size(40, 40)),
//                                                 ),
//                                                 icon: Icon(Icons.delete,
//                                                     color: Colors.red),
//                                                 onPressed: () {
//                                                   // Confirm ก่อนลบ (optional)
//                                                   Get.defaultDialog(
//                                                     title: 'ลบ Playlist',
//                                                     middleText:
//                                                         'คุณต้องการลบ "${playlist.playlist_name}" หรือไม่?',
//                                                     textCancel: 'ยกเลิก',
//                                                     textConfirm: 'ลบ',
//                                                     confirmTextColor:
//                                                         Colors.white,
//                                                     onConfirm: () {
//                                                       controller.deletePlaylist(
//                                                           playlist.playlist_id);
//                                                       Get.back();
//                                                     },
//                                                   );
//                                                 },
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     separatorBuilder: (context, index) =>
//                                         const Divider(),
//                                     itemCount: controller.playlist_list.length);
//                               }
//                             },
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 20,
//                           right: 20,
//                           child: SizedBox(
//                             width: 70, // ปรับความกว้าง
//                             height: 70, // ปรับความสูง
//                             child: FloatingActionButton(
//                               onPressed: () {
//                                 Get.dialog(playlistFormPopup());
//                               },
//                               backgroundColor: Colors.cyan[800],
//                               child: const Icon(
//                                 Icons.add,
//                                 size: 40,
//                                 color: Colors.white,
//                               ), // ปรับขนาดไอคอน
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )));
//         }
//       });
// }

// Widget playlistFormPopup() {
//   AppHomeController controller = Get.put(AppHomeController());
//   final TextEditingController Tcontroller = TextEditingController();
//   return AlertDialog(
//     title: const Text('สร้าง Playlist'),
//     content: TextField(
//       controller: Tcontroller,
//       decoration: const InputDecoration(labelText: 'ตั้งชื่อ Playlist'),
//     ),
//     actions: <Widget>[
//       TextButton(
//         child: const Text('Cancel'),
//         onPressed: () => Get.back(),
//       ),
//       TextButton(
//         child: const Text('Create'),
//         onPressed: () {
//           if (Tcontroller.text.isNotEmpty) {
//             if (controller.playlist_list.isEmpty) {
//               controller
//                   .createPlaylist(playlist_model(0, Tcontroller.text, []));
//             } else {
//               controller.createPlaylist(playlist_model(
//                   controller.playlist_list.last.playlist_id + 1,
//                   Tcontroller.text, []));
//             }
//           }
//           Get.back();
//         },
//       ),
//     ],
//   );
// }
