import 'package:flutter/material.dart';
import 'package:projectakhirmobile/views/album_view.dart';
import 'package:projectakhirmobile/views/kategori_view.dart';
import 'package:projectakhirmobile/views/song_view.dart';

class AlbumCard extends StatelessWidget {
  final String image;
  final String label;
  final int id;
  // final Function onTap;
  final double size;
  const AlbumCard({
    Key? key,
    required this.image,
    required this.id,
    required this.label,
    // required this.onTap,
    this.size = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumView(
              id: id,
              image: image,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage(image),
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }
}

class AlbumSongCard extends StatelessWidget {
  final String image;
  final String label;
  final int id;
  // final Function onTap;
  final double size;
  const AlbumSongCard({
    Key? key,
    required this.image,
    required this.id,
    required this.label,
    // required this.onTap,
    this.size = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongView(
              id: id,
              image: image,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage(image),
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }
}

class AlbumCardLibrary extends StatelessWidget {
  final int id;
  final String label;
  final String description;
  final String image;
  final double size;

  AlbumCardLibrary({
    required this.id,
    required this.label,
    required this.description,
    required this.image,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KategoriView(
              id: id,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(image),
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
