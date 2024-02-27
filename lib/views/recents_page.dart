import 'package:flutter/material.dart';
import 'package:reader/components/custom_app_bar.dart';
import 'package:reader/components/main_drawer.dart';

class RecentsPage extends StatefulWidget {
  const RecentsPage({super.key});

  @override
  State<RecentsPage> createState() => _RecentsPageState();
}

class _RecentsPageState extends State<RecentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        "Reader",
        centerTitle: false,
        automaticallyImplyLeading: true,
      ),
      drawer: const MainDrawer(),
    );
  }
}
