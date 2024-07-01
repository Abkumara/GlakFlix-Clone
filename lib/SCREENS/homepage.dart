import 'package:flutter/material.dart';
import 'package:glak_flix_app/SCREENS/categoryscreen.dart';
import 'package:glak_flix_app/SCREENS/searchmovie_screen.dart';
import 'package:glak_flix_app/SCREENS/searchtvshowsscreen.dart';
import 'package:glak_flix_app/WIDGETS/movie_slider.dart';
import 'package:glak_flix_app/WIDGETS/tv_shows_sliders.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _navigateToSearchScreen() {
    Widget searchScreen;
    if (_tabController.index == 0) {
      searchScreen = const SearchTvShowScreen();
    } else {
      searchScreen = const SearchMovieScreen();
    }

    Navigator.push(
      context,
      PageTransition(
        child: searchScreen,
        type: PageTransitionType.rightToLeftWithFade,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ClipOval(
          child: CircleAvatar(
              radius: 30, child: Image.asset('Assets/Images/log.png')),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: _navigateToSearchScreen,
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              Container(
                width: 30,
                height: 30,
                color: Colors.amber,
              )
            ],
          ),
        ],
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(
            child: Text(
              'Tv Shows',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Tab(
            child: Text(
              'Movies',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Tab(
            child: Text(
              'Categories',
              style: TextStyle(color: Colors.white),
            ),
          )
        ]),
      ),
      backgroundColor: Colors.white,
      body: TabBarView(controller: _tabController, children: const [
        TvShows(),
        Movies(),
        CategoryScreen(),
      ]),
    );
  }
}
