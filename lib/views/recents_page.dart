import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reader/components/advertisements.dart';
import 'package:reader/components/comic_card.dart';
import 'package:reader/components/custom_app_bar.dart';
import 'package:reader/components/main_drawer.dart';
import 'package:reader/models/comic.dart';

class RecentsPage extends StatefulWidget {
  const RecentsPage({super.key});

  @override
  State<RecentsPage> createState() => _RecentsPageState();
}

class _RecentsPageState extends State<RecentsPage> {
  final listComic = <Comic>[];

  void _genereteComic() async {
    var inputComic = await rootBundle.loadString("assets/comic_example.json");
    var map = jsonDecode(inputComic);

    map.forEach(
      (element) => {
        listComic.add(
          Comic.fromJson(element),
        ),
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _genereteComic();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (
      context,
      orientation,
    ) {
      return Stack(
        children: [
          Scaffold(
            appBar: CustomAppBar.build(
              context,
              "Reader",
              centerTitle: false,
              automaticallyImplyLeading: true,
            ),
            drawer: const MainDrawer(),
            body: Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height *
                    (orientation == Orientation.portrait ? 0.10 : 0.15),
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 5.0,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                itemCount: listComic.length,
                itemBuilder: (BuildContext context, int index) {
                  return ComicCard(
                    comic: listComic[index],
                  );
                },
              ),
            ),
          ),
          Advertisements(
            orientation: orientation,
          ),
        ],
      );
    });
  }
}
