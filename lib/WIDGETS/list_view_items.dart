import 'package:flutter/material.dart';
import 'package:glak_flix_app/API/api.dart';
import 'package:glak_flix_app/SCREENS/item_details_screen.dart';

class ListviewsItem extends StatelessWidget {
  const ListviewsItem({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
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
              child: SizedBox(
                width: 150,
                height: 200,
                child: Image.network(
                  '${ApiTools.imageUrl}${snapshot.data[index].posterPath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
