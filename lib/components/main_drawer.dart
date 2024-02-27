import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: const Text("Dashboard"),
            ),
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1.0,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.settings,
                        style: const TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      const Icon(
                        Icons.settings,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed("settings");
              },
            ),
          ],
        ),
      ),
    );
  }
}
