import 'package:flutter/material.dart';
import 'package:reader/models/comic.dart';

class ComicCard extends StatefulWidget {
  const ComicCard({super.key, required this.comic});

  final Comic comic;

  @override
  State<ComicCard> createState() => _ComicCardState();
}

class _ComicCardState extends State<ComicCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          "reader",
          arguments: widget.comic,
        );
      },
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 10,
        child: Center(child: Text(widget.comic.shortTitle)),
      ),
    );
  }
}
