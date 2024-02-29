import 'package:flutter/material.dart';
import 'package:reader/components/custom_app_bar.dart';
import 'package:sprintf/sprintf.dart';

import '../models/comic.dart';

class ReaderPage extends StatelessWidget {
  const ReaderPage({
    super.key,
    required this.comic,
  });

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(context, comic.title, centerTitle: false),
      body: ListView.builder(
        itemCount: comic.numberPages,
        itemBuilder: (_, index) {
          var imageUrl = sprintf(
              comic.urlModel, [index.toString().padLeft(comic.decimals, "0")]);

          return Image.network(
            imageUrl,
            loadingBuilder: (context, child, ImageChunkEvent? loadingProgress) {
              return loadingProgress != null
                  ? Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    )
                  : child;
            },
          );
        },
      ),
    );
  }
}
