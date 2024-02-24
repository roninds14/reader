import 'package:flutter/material.dart';
import 'package:reader/components/custom_app_bar.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(context, "Terms"),
      body: const Center(),
    );
  }
}
