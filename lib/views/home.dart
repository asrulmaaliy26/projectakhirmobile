import 'package:flutter/material.dart';
import 'package:projectakhirmobile/API/repository.dart';
import 'package:projectakhirmobile/Models/model.dart';
import 'package:projectakhirmobile/views/kategori_view.dart';
import 'package:projectakhirmobile/widgets/album_card.dart';
import 'package:projectakhirmobile/widgets/song_card.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Kategori> listKategori = [];
  List<Album> listAlbum = [];
  List<Song> listSong = [];
  Repository repository = Repository();

  Future<void> getDataKategori() async {
    try {
      List<Kategori> newData = await repository.getDataKategori();
      if (newData != null) {
        setState(() {
          listKategori = newData;
        });
      } else {
        print("Object not found");
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> getDataSong() async {
    try {
      List<Song> newData = await repository.getDataSong();
      if (newData != null) {
        setState(() {
          listSong = newData;
        });
      } else {
        print("Object not found");
      }
      // print(newData);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> getDataAlbum() async {
    try {
      List<Album> newData = await repository.getDataAlbum();
      if (newData != null) {
        setState(() {
          listAlbum = newData;
        });
      } else {
        print("Object not found");
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataKategori();
    getDataAlbum();
    getDataSong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green.withOpacity(0.5),
                  Colors.green.withOpacity(0.1),
                  Colors.green.withOpacity(0)
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Selamat Datang",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Icon(Icons.notifications_none),
                              SizedBox(width: 16),
                              InkWell(
                                onTap: () {
                                  // Tambahkan logika untuk menjalankan refresh halaman di sini
                                  print('Refresh halaman');
                                },
                                child: Icon(Icons.history),
                              ),
                              SizedBox(width: 16),
                              Icon(Icons.settings),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 16),
                        Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                listKategori.length,
                                (index) {
                                  final kategori = listKategori[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: RowAlbumCard(
                                      id: kategori.kategori_id,
                                      label: kategori.name,
                                      image: kategori.imageUrl,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Album Baru didengar",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: listAlbum.map((album) {
                        return AlbumCard(
                          id: album.album_id,
                          label: album.title,
                          image: album.imageUrl,
                        );
                      }).toList(),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.grey.withOpacity(0.2),
                              Colors.grey.withOpacity(0.01),
                              Colors.grey.withOpacity(0),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Sering anda dengar",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 20), // Adjust horizontal padding
                              child: Row(
                                children: listSong.map((song) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            16), // Add some spacing between SongCards
                                    child: SongCard(
                                      id: song.song_id,
                                      image: song.imageUrl,
                                      deskripsi: song.title,
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RowAlbumCard extends StatelessWidget {
  final int id;
  final String image;
  final String label;

  const RowAlbumCard({
    Key? key,
    required this.id,
    required this.image,
    required this.label,
  }) : super(key: key);

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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(4),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Image(
              image: NetworkImage(image),
              height: 48,
              width: 48,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
