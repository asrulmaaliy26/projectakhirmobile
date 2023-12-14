import 'package:flutter/material.dart';
import 'package:projectakhirmobile/views/song_view.dart';

class SongCard extends StatelessWidget {
  final String image;
  final int id;
  final String deskripsi;

  const SongCard({
    Key? key,
    required this.image,
    required this.deskripsi,
    required this.id,
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
      child: SizedBox(
        width: 140,
        child: Column(
          children: [
            Image(
              image: NetworkImage(image),
              width: 140,
              height: 140,
            ),
            Text(
              deskripsi,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class SongCardS extends StatelessWidget {
  final String image;
  final int id;
  final String deskripsi;

  const SongCardS({
    Key? key,
    required this.image,
    required this.deskripsi,
    required this.id,
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
      child: SizedBox(
        width: 140,
        child: Column(
          children: [
            Image(
              image: NetworkImage(image),
              width: 140,
              height: 140,
            ),
            Text(
              deskripsi,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white, // Set the text color to white
                    // Add other styling properties as needed
                  ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
