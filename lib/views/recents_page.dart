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
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 5.0,
          ),
          padding: const EdgeInsets.only(top: 10.0),
          itemCount: 300,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Theme.of(context).primaryColor,
              elevation: 10,
              child: Center(child: Text('$index')),
            );
          }),
    );
  }
}
