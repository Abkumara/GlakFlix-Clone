import 'package:flutter/material.dart';

import 'package:glak_flix_app/API/api.dart';

class TvCard extends StatelessWidget {
  const TvCard({super.key, required this.snapshot, required this.index});
  final AsyncSnapshot snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          ClipRRect(
            child: SizedBox(
              height: 450,
              child: Image.network(
                '${ApiTools.imageUrl}${snapshot.data[index].posterPath}',
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${snapshot.data[index].tvTitle}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
