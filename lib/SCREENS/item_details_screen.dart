import 'package:flutter/material.dart';
import 'package:glak_flix_app/API/api.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen(
      {super.key, required this.snapshot, required this.index});
  final AsyncSnapshot snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      appBar: AppBar(
        actions: [
          Container(
            width: 25,
            height: 25,
            color: Colors.amber,
          )
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Image.network(
                  '${ApiTools.imageUrl}${snapshot.data[index].backdropPath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                (snapshot.data[index].title != null)
                    ? '${snapshot.data[index].title}'
                    : '${snapshot.data[index].tvTitle}',
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Overview',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '${snapshot.data[index].overview}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (snapshot.data[index].releaseDate != null)
                        ? 'Release Date : ${snapshot.data[index].releaseDate}'
                        : 'Release Date : ${snapshot.data[index].airDate}',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
