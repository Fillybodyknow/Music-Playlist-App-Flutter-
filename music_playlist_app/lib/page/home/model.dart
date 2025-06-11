class music_info_model {
  final int id;
  final int author_id;
  final String title;
  final String url_player;

  music_info_model(this.id, this.author_id, this.title, this.url_player);

  music_info_model.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        author_id = json['author_id'],
        title = json['title'],
        url_player = json['url_player'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'author_id': author_id,
        'title': title,
        'url_player': url_player,
      };
}

class author_model {
  final int author_id;
  final String name;
  final String trumbnail;

  author_model(this.author_id, this.name, this.trumbnail);

  author_model.fromJson(Map<String, dynamic> json)
      : author_id = json['author_id'],
        name = json['name'],
        trumbnail = json['trumbnail'];

  Map<String, dynamic> toJson() => {
        'author_id': author_id,
        'name': name,
        'trumbnail': trumbnail,
      };
}

class playlist_model {
  final int playlist_id;
  final String playlist_name;
  final List<music_info_model> music_list;

  playlist_model(this.playlist_id, this.playlist_name, this.music_list);

  playlist_model.fromJson(Map<String, dynamic> json)
      : playlist_id = json['playlist_id'],
        playlist_name = json['playlist_name'],
        music_list = (json['music_list'] as List<dynamic>)
            .map((musicJson) => music_info_model.fromJson(musicJson))
            .toList();

  Map<String, dynamic> toJson() => {
        'playlist_id': playlist_id,
        'playlist_name': playlist_name,
        'music_list': music_list.map((music) => music.toJson()).toList(),
      };
}
