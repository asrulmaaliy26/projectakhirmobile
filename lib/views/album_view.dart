import 'package:flutter/material.dart';
import 'package:projectakhirmobile/API/repository.dart';
import 'package:projectakhirmobile/Models/model.dart';
import 'package:projectakhirmobile/widgets/album_card.dart';

class AlbumView extends StatefulWidget {
  final int id;
  final String image;

  const AlbumView({Key? key, required this.image, required this.id})
      : super(key: key);

  @override
  _AlbumViewState createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  bool _loading = true;
  late ScrollController scrollController;
  double imageSize = 0;
  double initialSize = 240;
  double containerHeight = 500;
  double containerInitialHeight = 500;
  double imageOpacity = 1;
  bool showTopBar = false;

  List<Song> listPerSong = [];
  List<Album> listPerAlbum = [];
  List<Song> listSong = [];
  Repository repository = Repository();

  Future<void> getDataPerAlbum(int id) async {
    try {
      List<Album> newData = await repository.getDataPerAlbum(id);
      setState(() {
        listPerAlbum = newData;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print('Error fetching data: $e');
    }
  }

  Future<void> getSongByAlbum(int id) async {
    try {
      List<Song> newData = await repository.getSongByAlbum(id);
      if (newData != null) {
        setState(() {
          listSong = newData;
        });
      } else {
        print("Object not found");
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void handleScroll() {
    imageSize = initialSize - scrollController.offset;
    if (imageSize < 0) {
      imageSize = 0;
    }
    containerHeight = containerInitialHeight - scrollController.offset;
    if (containerHeight < 0) {
      containerHeight = 0;
    }
    imageOpacity = imageSize / initialSize;
    showTopBar = scrollController.offset > 224;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDataPerAlbum(widget.id);
    getSongByAlbum(widget.id);
    imageSize = initialSize;
    scrollController = ScrollController();
    scrollController.addListener(handleScroll);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: containerHeight,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            color: Color.fromARGB(255, 64, 229, 75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: imageOpacity.clamp(0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.5),
                          // ignore: prefer_const_constructors
                          offset: Offset(0, 20),
                          blurRadius: 32,
                          spreadRadius: 16,
                        )
                      ],
                    ),
                    child: Image.network(
                      widget.image,
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(1),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          SizedBox(height: initialSize + 32),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // for (Song song in listPerSong)
                                Text(
                                  listPerAlbum[0].title,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 8),
                                const Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/logo.png'),
                                      width: 32,
                                      height: 32,
                                    ),
                                    SizedBox(width: 8),
                                    Text("Spotifyyyyy"),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "1,888,132 likes             ${listPerAlbum[0].duration}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 16),
                                const Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.favorite),
                                        SizedBox(width: 16),
                                        Icon(Icons.more_horiz),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          listPerAlbum[0].title,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      for (var song in listSong.take(1))
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 16),
                                          child: AlbumSongCard(
                                            label: song.title,
                                            image: song.imageUrl,
                                            id: song.song_id,
                                          ),
                                        ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      for (var song in listSong.skip(1).take(1))
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 16),
                                          child: AlbumSongCard(
                                            label: song.title,
                                            image: song.imageUrl,
                                            id: song.song_id,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // App bar
          Positioned(
              child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            color: showTopBar
                ? const Color.fromARGB(255, 33, 198, 24).withOpacity(1)
                : const Color.fromARGB(255, 17, 175, 19).withOpacity(0),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: SafeArea(
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_left,
                          size: 38,
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: showTopBar ? 1 : 0,
                      child: Text(
                        "Music",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom:
                          80 - containerHeight.clamp(120.0, double.infinity),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff14D860),
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              size: 38,
                            ),
                          ),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.shuffle,
                              color: Colors.black,
                              size: 14,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
