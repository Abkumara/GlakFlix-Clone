import 'package:flutter/material.dart';

class CategoryItemScreen extends StatelessWidget {
  const CategoryItemScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
