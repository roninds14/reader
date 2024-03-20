import 'package:flutter/material.dart';
import 'package:reader/components/advertisements.dart';
import 'package:reader/components/custom_app_bar.dart';
import 'package:sprintf/sprintf.dart';

import '../models/comic.dart';

class ReaderPage extends StatefulWidget {
  const ReaderPage({
    super.key,
  });

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  @override
  Widget build(BuildContext context) {
    final comic = ModalRoute.of(context)!.settings.arguments as Comic;

    return OrientationBuilder(builder: (context, orientation) {
      return Stack(children: [
        Scaffold(
          appBar: CustomAppBar.build(context, comic.title,
              centerTitle: false, automaticallyImplyLeading: true),
          body: Container(
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height *
                  (orientation == Orientation.portrait ? 0.10 : 0.15),
            ),
            child: ListView.builder(
              itemCount: comic.numberPages,
              itemBuilder: (_, index) {
                var imageUrl = sprintf(
                  comic.urlModel,
                  [
                    index
                        .toString()
                        .padLeft(comic.decimals, comic.decimalsSeparator)
                  ],
                );

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      imageUrl,
                      loadingBuilder:
                          (context, child, ImageChunkEvent? loadingProgress) {
                        return loadingProgress != null
                            ? Padding(
                                padding: const EdgeInsets.all(50.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ],
                                ),
                              )
                            : child;
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Advertisements(
          orientation: orientation,
        ),
      ]);
    });
  }
}
