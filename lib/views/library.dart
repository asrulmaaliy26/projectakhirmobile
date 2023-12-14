import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projectakhirmobile/API/repository.dart';
import 'package:projectakhirmobile/Models/model.dart';
import 'package:projectakhirmobile/views/kategori_view.dart';
import 'package:projectakhirmobile/widgets/album_card.dart';

class LibraryView extends StatefulWidget {
  @override
  _LibraryViewState createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  List<Kategori> listKategori = [];
  Repository repository = Repository();

  Future<void> getDataKategori() async {
    try {
      List<Kategori> newData = await repository.getDataKategori();
      if (newData != null) {
        setState(() {
          listKategori = newData;
        });
      } else {
        // Handle the case where data is null
        print("object not found");
      }
    } catch (e) {
      // Handle exceptions
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataKategori();
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
                  Colors.green.withOpacity(0.6),
                  Colors.green.withOpacity(0.2),
                  Colors.green.withOpacity(0),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 7),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image.asset(
                                "assets/album1.jpg",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          const Text(
                            "Koleksi Kamu",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 16),
                        Icon(Icons.add_outlined)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: min(
                        5,
                        listKategori
                            .length), // Ensure not to exceed the list size
                    itemBuilder: (context, index) {
                      var album = listKategori[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildCategory(album.name, album.kategori_id),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  color: Colors.grey.withOpacity(0.08),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                        child: Row(
                          children: [Icon(Icons.sync)],
                        ),
                      ),
                      Row(
                        children: [Icon(Icons.grid_view)],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey.withOpacity(0.5),
                          Colors.grey.withOpacity(0.1),
                          Colors.grey.withOpacity(0)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: min(
                          5,
                          listKategori
                              .length), // Ensure not to exceed the list size
                      itemBuilder: (context, index) {
                        var kategori = listKategori[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: AlbumCardLibrary(
                            id: kategori.kategori_id,
                            label: kategori.name,
                            image: kategori.imageUrl,
                            description: "Playlist",
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategory(String text, int id) {
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
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 52, 51, 51),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: const Color.fromARGB(255, 245, 245, 245),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      ),
    );
  }
}
