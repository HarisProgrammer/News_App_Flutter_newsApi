import 'package:flutter/material.dart';


class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title:const Text("Detailed News Page")
      ),
    );
  }
}

