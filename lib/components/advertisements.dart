import 'package:flutter/material.dart';

class Advertisements extends StatelessWidget {
  const Advertisements({super.key, required this.orientation});

  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        color: Colors.green,
        height: MediaQuery.of(context).size.height *
            (orientation == Orientation.portrait ? 0.10 : 0.15),
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
