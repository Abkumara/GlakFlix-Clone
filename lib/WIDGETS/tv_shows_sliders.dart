import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:glak_flix_app/API/api.dart';
import 'package:glak_flix_app/MODEL/model_type.dart';

import 'package:glak_flix_app/MODEL/tvcard.dart';
import 'package:glak_flix_app/SCREENS/item_details_screen.dart';
import 'package:glak_flix_app/WIDGETS/list_view_items.dart';

class TvShows extends StatefulWidget {
  const TvShows({
    super.key,
  });

  @override
  State<TvShows> createState() => _TvShowsState();
}

class _TvShowsState extends State<TvShows> {
  late Future<List<ModelType>> popularTvShows;
  late Future<List<ModelType>> ratedTvShows;
  late Future<List<ModelType>> trendingTvShows;
  @override
  void initState() {
    popularTvShows = Api().getPopularTvShows();
    ratedTvShows = Api().getRatedTvShows();
    trendingTvShows = Api().getTrendingTvShows();
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
              future: popularTvShows,
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
                            child: TvCard(
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
              'Top Rated TV Shows',
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
                  future: ratedTvShows,
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
              'Trending Tv Shows',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: FutureBuilder(
                  future: trendingTvShows,
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
