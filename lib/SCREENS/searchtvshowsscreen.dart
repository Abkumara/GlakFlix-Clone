import 'package:flutter/material.dart';
import 'package:glak_flix_app/API/api.dart';
import 'package:glak_flix_app/MODEL/model_type.dart';
import 'package:glak_flix_app/SCREENS/item_details_screen.dart';

class SearchTvShowScreen extends StatefulWidget {
  const SearchTvShowScreen({super.key});

  @override
  State<SearchTvShowScreen> createState() => _SearchTvShowScreenState();
}

class _SearchTvShowScreenState extends State<SearchTvShowScreen> {
  TextEditingController _searchController = TextEditingController();
  late Future<List<ModelType>> searchTvShows;
  List<ModelType> _tvShows = [];

  @override
  void initState() {
    super.initState();
    searchTvShows = Api().getSearchTvShows('');
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    setState(() {
      searchTvShows = Api().getSearchTvShows(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.teal[900],
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search Tv Series here...',
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        )),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: FutureBuilder<List<ModelType>>(
                  future: searchTvShows,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text(
                        'No results found',
                        style: TextStyle(color: Colors.white),
                      ));
                    } else {
                      _tvShows = snapshot.data!;
                      return ListView.builder(
                        itemCount: _tvShows.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemDetailsScreen(
                                        snapshot: snapshot, index: index),
                                  ));
                            },
                            child: Container(
                              height: 120,
                              color: Colors.grey[400],
                              width: double.infinity,
                              margin: const EdgeInsets.all(1),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 120,
                                    child: Image.network(
                                      '${ApiTools.imageUrl}${snapshot.data![index].posterPath}',
                                      fit: BoxFit.contain,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Text(
                                        '${snapshot.data![index].tvTitle}',
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
