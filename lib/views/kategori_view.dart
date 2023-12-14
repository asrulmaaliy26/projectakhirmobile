import 'package:flutter/material.dart';
import 'package:projectakhirmobile/API/repository.dart';
import 'package:projectakhirmobile/Models/model.dart';
import 'package:projectakhirmobile/views/album_view.dart';

class KategoriView extends StatefulWidget {
  final int id;

  const KategoriView({super.key, required this.id});
  @override
  _KategoriViewState createState() => _KategoriViewState();
}

class _KategoriViewState extends State<KategoriView> {
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
        // Handle the case where data is null
        print("object not found");
      }
      // print(newData);
    } catch (e) {
      // Handle exceptions
      print('Error fetching data: $e');
    }
  }

  Future<void> getAlbumByKategori(int id) async {
    try {
      List<Album> newData = await repository.getAlbumByKategori(id);
      if (newData != null) {
        setState(() {
          listAlbum = newData;
        });
      } else {
        // Handle the case where data is null
        print("object not found");
      }
      // print(newData);
    } catch (e) {
      // Handle exceptions
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // getDataAlbum();
    getAlbumByKategori(widget.id);
    // print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
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
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        children: [
                          Column(
                            children: listAlbum
                                .take(listAlbum.length >= 2 ? 2 : 1)
                                .map((album) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RowKategoriCard(
                                  id: album.album_id,
                                  label: album.title,
                                  image: album.imageUrl,
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 16),
                          Column(
                            children: listAlbum
                                .skip(listAlbum.length >= 2 ? 2 : 1)
                                .take(listAlbum.length >= 4 ? 3 : 2)
                                .map((album) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RowKategoriCard(
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

class RowKategoriCard extends StatelessWidget {
  final int id;
  final String label;
  final String image;

  const RowKategoriCard({
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
