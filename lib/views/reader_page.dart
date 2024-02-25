import 'package:flutter/material.dart';
import 'package:reader/components/custom_app_bar.dart';

class ReaderPage extends StatefulWidget {
  const ReaderPage({super.key});

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        "Reader",
        centerTitle: false,
      ),
    );
  }
}
