import 'package:flutter/material.dart';
import 'package:glak_flix_app/SCREENS/categoryitemscrren.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> category = [
    'Popular Movies',
    'Top Trending Movies',
    'Top Rated Movies',
    'Popular TV Shows',
    'Top Trending TV Shows',
    'Top Rated TV Shows'
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: category.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CategoryItemScreen(title: category[index]),
                ));
          },
          title: Center(
              child: Text(
            category[index],
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          )),
        );
      },
    );
  }
}
