import 'package:flutter/material.dart';
import 'package:projectakhirmobile/API/repository.dart';
import 'package:projectakhirmobile/Models/model.dart';
import 'package:projectakhirmobile/views/album_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
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
    return Scaffold(
      body: Stack(
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
                  const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [Icon(Icons.camera_alt_outlined)],
                    ),
                  )
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
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Artis, Lagu atau podcast',
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  "Jelajahi Semua",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: listAlbum.take(5).map((album) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RowAlbumCard(
                                    id: album.album_id,
                                    label: album.title,
                                    image: album.imageUrl,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 16),
                          Column(
                            children: listAlbum.skip(5).take(5).map((album) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RowAlbumCard(
                                  id: album.album_id,
                                  label: album.title,
                                  image: album.imageUrl,
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
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
