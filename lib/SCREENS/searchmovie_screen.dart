import 'package:flutter/material.dart';
import 'package:glak_flix_app/API/api.dart';
import 'package:glak_flix_app/MODEL/model_type.dart';
import 'package:glak_flix_app/SCREENS/item_details_screen.dart';

class SearchMovieScreen extends StatefulWidget {
  const SearchMovieScreen({super.key});

  @override
  State<SearchMovieScreen> createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  TextEditingController _searchController = TextEditingController();
  late Future<List<ModelType>> searchMovies;
  List<ModelType> _movies = [];

  @override
  void initState() {
    super.initState();
    searchMovies = Api().getSearchMovie('');
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
      searchMovies = Api().getSearchMovie(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
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
                    hintText: 'Search Movie here....',
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
                  future: searchMovies,
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
                      _movies = snapshot.data!;
                      return ListView.builder(
                        itemCount: _movies.length,
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
                              color: Colors.grey,
                              width: double.infinity,
                              margin: const EdgeInsets.all(2),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 120,
                                    child: Image.network(
                                      (_movies[index].posterPath != null &&
                                              _movies[index]
                                                  .posterPath!
                                                  .isNotEmpty)
                                          ? '${ApiTools.imageUrl}${snapshot.data![index].posterPath}'
                                          : 'https://via.placeholder.com/150',
                                      fit: BoxFit.contain,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Text(
                                        '${snapshot.data![index].title}',
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
