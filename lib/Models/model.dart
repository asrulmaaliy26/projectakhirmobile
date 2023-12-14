class Kategori {
  final int kategori_id;
  final String name;
  final String imageUrl;

  const Kategori({
    required this.kategori_id,
    required this.name,
    required this.imageUrl,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
        kategori_id: json['category_id'],
        name: json['name'],
        imageUrl: json['imageUrl']);
  }
}

class Album {
  final int album_id;
  final String title;
  final String duration;
  final int release_year;
  final String imageUrl;

  const Album({
    required this.album_id,
    required this.title,
    required this.duration,
    required this.release_year,
    required this.imageUrl,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        album_id: json['album_id'],
        title: json['title'],
        duration: json['duration'],
        release_year: json['release_year'],
        imageUrl: json['imageUrl']);
  }
}

class Artist {
  final int artist_id;
  final String name;
  final String country;
  final String bio;
  final String imageUrl;

  const Artist({
    required this.artist_id,
    required this.name,
    required this.country,
    required this.bio,
    required this.imageUrl,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
        artist_id: json['artist_id'],
        name: json['name'],
        country: json['country'],
        bio: json['bio'],
        imageUrl: json['imageUrl']);
  }
}

class Song {
  final int song_id;
  final String title;
  final String duration;
  final String description;
  final String imageUrl;
  final String filemp3;

  const Song({
    required this.song_id,
    required this.title,
    required this.duration,
    required this.description,
    required this.imageUrl,
    required this.filemp3,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
        song_id: json['song_id'],
        title: json['title'],
        duration: json['duration'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        filemp3: json['file_mp3']);
  }
}
