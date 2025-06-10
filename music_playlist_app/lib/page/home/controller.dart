import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_playlist_app/page/home/model.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:path_provider/path_provider.dart';

class AppHomeController extends GetxController {
  RxList<music_info_model> music_list = RxList<music_info_model>();
  RxList<author_model> author_list = RxList<author_model>(); // <author_model>
  RxInt Index = 0.obs;
  RxnInt selectedMusicIndex = RxnInt();
  Rxn<music_info_model> currentPlaying = Rxn<music_info_model>();

  RxBool isPlaying = false.obs;
  Rx<Duration> position = Rx(Duration.zero);
  Rx<Duration> duration = Rx(Duration.zero);

  RxList<playlist_model> playlist_list = RxList<playlist_model>();

  final player = AudioPlayer();

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();

    // ตั้ง Listener ก่อน
    player.onDurationChanged.listen((d) {
      duration.value = d;
    });

    player.onPositionChanged.listen((p) {
      position.value = p;
    });

    player.onPlayerComplete.listen((_) {
      isPlaying.value = false;
      position.value = Duration.zero;

      playNextMusic();
    });

    loadData();
  }

  void playNextMusic() async {
    if (music_list.isEmpty) return;

    int nextIndex = (selectedMusicIndex.value ?? 0) + 1;

    if (nextIndex >= music_list.length) {
      // ถ้าถึงเพลงสุดท้าย จะไม่เล่นต่อ (หรือวนกลับ index = 0 ก็ได้)
      isPlaying.value = false;
      return;
    }

    selectedMusicIndex.value = nextIndex;
    await playMusic(music_list[nextIndex]);
  }

  Future<void> playMusic(music_info_model music) async {
    await player.stop();
    await player.play(AssetSource(music.url_player)); // ← ชื่อไฟล์ใน assets

    currentPlaying.value = music;
    isPlaying.value = true;

    // Reset เฉย ๆ ไม่ต้องใส่ Listener ซ้ำ
    position.value = Duration.zero;
    //duration.value = Duration.zero;
  }

  void pauseMusic() async {
    await player.pause();
    isPlaying.value = false;
  }

  void resumeMusic() async {
    await player.resume();
    isPlaying.value = true;
  }

  void seekMusic(Duration newPosition) async {
    await player.seek(newPosition);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
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

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/MyPlaylist.json');
  }

  void createPlaylist(playlist_model playlist) async {
    playlist_list.add(playlist);
    await savePlaylistListToFile();
  }

  void deletePlaylist(int playlistId) {
    playlist_list.removeWhere((element) => element.playlist_id == playlistId);
    // ถ้ามี save ลง file ก็ save ด้วย เช่น:
    savePlaylistListToFile();
  }

  Future<void> savePlaylistListToFile() async {
    final file = await _localFile;

    List<Map<String, dynamic>> jsonList =
        playlist_list.map((p) => p.toJson()).toList();

    String jsonString = jsonEncode(jsonList);
    await file.writeAsString(jsonString);
  }

  Future<void> readPlaylistListFromFile() async {
    final file = await _localFile;

    if (await file.exists()) {
      String jsonString = await file.readAsString();
      print('Raw JSON string from file: $jsonString'); // Debug print

      List<dynamic> jsonData = jsonDecode(jsonString);
      print('Decoded JSON data (List<dynamic>): $jsonData'); // Debug print

      playlist_list.value = jsonData.map((jsonItem) {
        print('Mapping JSON item: $jsonItem'); // Debug print each item
        return playlist_model.fromJson(jsonItem);
      }).toList();
      print(
          'Successfully mapped playlist_list: ${playlist_list.value}'); // Debug print
    } else {
      playlist_list.value = [];
      print('Playlist file does not exist, initializing empty list.');
    }
  }
}
