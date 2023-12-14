import 'package:flutter/material.dart';
import 'package:projectakhirmobile/Models/model.dart';
import 'package:projectakhirmobile/API/repository.dart';

class SearchSongWidget extends StatefulWidget {
  @override
  _SearchSongWidgetState createState() => _SearchSongWidgetState();
}

class _SearchSongWidgetState extends State<SearchSongWidget> {
  TextEditingController _searchController = TextEditingController();
  List<Song> _searchResults = [];

  Repository repository = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Songs'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchSongs(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Text('No results'),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        Song song = _searchResults[index];
        return ListTile(
          title: Text(song.title),
          subtitle: Text(song.description),
          // Add more details or customize the ListTile as needed
        );
      },
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

void main() {
  runApp(MaterialApp(
    home: SearchSongWidget(),
  ));
}
