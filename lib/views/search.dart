import 'package:flutter/material.dart';
import 'package:projectakhirmobile/API/repository.dart';
import 'package:projectakhirmobile/Models/model.dart';
import 'package:projectakhirmobile/views/album_view.dart';
import 'package:projectakhirmobile/widgets/album_card.dart';
import 'package:projectakhirmobile/widgets/song_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  SearchViewState createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  List<Song> _searchResults = [];
  String searchText = '';
  List<Album> listAlbum = [];
  Repository repository = Repository();

  Future<void> getDataAlbum() async {
    try {
      List<Album> newData = await repository.getDataAlbum();
      if (newData != null) {
        setState(() {
          listAlbum = newData;
        });
      } else {
        print("object not found");
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.green.withOpacity(0.5),
                      Colors.green.withOpacity(0.2),
                      Colors.green.withOpacity(0),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/album1.jpg",
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "Cari",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: '  Artis, Lagu atau podcast',
                                hintStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(color: Colors.black),
                              textAlign:
                                  TextAlign.center, // Menambahkan properti ini
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              _searchSongs(_searchController.text);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: _buildSearchResults()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: SingleChildScrollView(
          // Add SingleChildScrollView here
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Jelajahi Semua",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildAlbumColumn(listAlbum.take(5)),
                      SizedBox(width: 16),
                      _buildAlbumColumn(listAlbum.skip(5).take(5)),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        Song song = _searchResults[index];
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              SongCardS(
                image: song
                    .imageUrl, // Replace with the actual image URL or property
                id: song.song_id,
                deskripsi: song.title,
              ),
              SizedBox(width: 16), // Add spacing between AlbumSongCard and text
              Expanded(
                child: Text(
                  song.description,
                  style: TextStyle(
                    color: Colors.white, // Set the text color to white
                    // Add other styling properties as needed
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAlbumColumn(Iterable<Album> albums) {
    return Column(
      children: albums.map((album) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RowAlbumCard(
            id: album.album_id,
            label: album.title,
            image: album.imageUrl,
          ),
        );
      }).toList(),
    );
  }

  Future<void> _searchSongs(String query) async {
    try {
      List<Song> results = await repository.getSearchSong(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      // Handle errors, e.g., show an error message
      print('Error searching songs: $e');
    }
  }
}

class RowAlbumCard extends StatelessWidget {
  final int id;
  final String label;
  final String image;

  const RowAlbumCard({
    required this.id,
    required this.label,
    required this.image,
  });

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
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
