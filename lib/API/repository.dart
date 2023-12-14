import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;
import 'package:projectakhirmobile/Models/model.dart';

class Repository {
  final _baseUrl = 'http://azzalea.pythonanywhere.com/api/';

  Future getDataKategori() async {
    try {
      String tambah = 'categories/?format=json';
      final response = await http.get(Uri.parse(_baseUrl + tambah));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<Kategori> category = it.map((e) => Kategori.fromJson(e)).toList();
        return category;
      }
    } catch (e) {
      developer.log('Error in getDataKategori: $e'); // Use dart:developer.log
    }
  }

  Future getDataAlbum() async {
    try {
      String tambah = 'albums/?format=json';
      final response = await http.get(Uri.parse(_baseUrl + tambah));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<Album> album = it.map((e) => Album.fromJson(e)).toList();
        return album;
      }
    } catch (e) {
      developer.log('Error in getDataAlbum: $e'); // Use dart:developer.log
    }
  }

  Future getDataArtist() async {
    try {
      String tambah = 'artists/?format=json';
      final response = await http.get(Uri.parse(_baseUrl + tambah));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<Artist> artist = it.map((e) => Artist.fromJson(e)).toList();
        return artist;
      }
    } catch (e) {
      developer.log('Error in getDataArtist: $e'); // Use dart:developer.log
    }
  }

  Future<List<Song>> getDataSong() async {
    try {
      String tambah = 'songs/?format=json';
      final response = await http.get(Uri.parse(_baseUrl + tambah));
      print(response);
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<Song> songs = it.map((e) => Song.fromJson(e)).toList();
        return songs;
      }
    } catch (e) {
      developer.log('Error in getDataSong: $e'); // Use dart:developer.log
      rethrow;
    }
    return [];
  }

  Future<List<Song>> getDataPerSong(int id) async {
    try {
      String tambah = 'songs/$id';
      final response = await http.get(Uri.parse(_baseUrl + tambah));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        Song song = Song.fromJson(data);
        return [song];
      }
    } catch (e) {
      developer.log('Error in getDataPerSong: $e'); // Use dart:developer.log
      rethrow;
    }
    return [];
  }

  Future<List<Album>> getDataPerAlbum(int id) async {
    try {
      String tambah = 'albums/$id/?format=json';
      final response = await http.get(Uri.parse(_baseUrl + tambah));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        Album album = Album.fromJson(data);
        return [album];
      }
    } catch (e) {
      developer.log('Error in getDataPerSong: $e'); // Use dart:developer.log
      rethrow;
    }
    return [];
  }

  Future<List<Song>> getSongByAlbum(int id) async {
    try {
      String tambah = 'album/$id/songs/?format=json';
      final response = await http.get(Uri.parse(_baseUrl + tambah));
      List<Song> songs = [];
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        for (var i = 0; i < data.length; i++) {
          songs.add(Song.fromJson(data[i]));
        }
        return songs;
      }
    } catch (e) {
      developer.log('Error in getDataPerSong: $e'); // Use dart:developer.log
      rethrow;
    }
    return [];
  }

  Future<List<Album>> getAlbumByKategori(int id) async {
    try {
      String tambah = 'category/$id/albums';
      final response = await http.get(Uri.parse(_baseUrl + tambah));
      List<Album> albums = [];
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        for (var i = 0; i < data.length; i++) {
          albums.add(Album.fromJson(data[i]));
        }
        return albums;
      }
    } catch (e) {
      developer.log('Error in getDataPerSong: $e'); // Use dart:developer.log
      rethrow;
    }
    return [];
  }

  Future<List<Song>> getSearchSong(String nama) async {
    try {
      String tambah = 'songs/search/$nama';
      final response = await http.get(Uri.parse(_baseUrl + tambah));
      List<Song> songs = [];
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        for (var i = 0; i < data.length; i++) {
          songs.add(Song.fromJson(data[i]));
        }
        return songs;
      }
    } catch (e) {
      developer.log('Error in getDataPerSong: $e'); // Use dart:developer.log
      rethrow;
    }
    return [];
  }
}
