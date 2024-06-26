import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:glak_flix_app/API/api.dart';
import 'package:glak_flix_app/MODEL/model_type.dart';
import 'package:glak_flix_app/MODEL/moviecard.dart';
import 'package:glak_flix_app/SCREENS/item_details_screen.dart';
import 'package:glak_flix_app/WIDGETS/list_view_items.dart';

class Movies extends StatefulWidget {
  const Movies({
    super.key,
  });

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  late Future<List<ModelType>> popularMovies;
  late Future<List<ModelType>> ratedMovies;
  late Future<List<ModelType>> upcomingMovies;
  @override
  void initState() {
    popularMovies = Api().getPopularMovies();
    ratedMovies = Api().getRatedMovies();
    upcomingMovies = Api().getUpcomingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                child: FutureBuilder(
              future: popularMovies,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  return SizedBox(
                    width: double.infinity,
                    height: 520,
                    child: CarouselSlider.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index, realIndex) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemDetailsScreen(
                                      snapshot: snapshot,
                                      index: index,
                                    ),
                                  ));
                            },
                            child: MovieCard(
                              snapshot: snapshot,
                              index: index,
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 520,
                          autoPlay: true,
                          viewportFraction: 0.88,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayAnimationDuration: const Duration(seconds: 2),
                        )),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Rated Movies',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: FutureBuilder(
                  future: ratedMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.hasData) {
                      return SizedBox(
                        child: ListviewsItem(
                          snapshot: snapshot,
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Upcoming Movies',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: FutureBuilder(
                  future: upcomingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.hasData) {
                      return SizedBox(
                        child: ListviewsItem(
                          snapshot: snapshot,
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
