import 'package:flutter/material.dart';
import 'package:reader/components/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reader/components/theme_flutter_switch.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        AppLocalizations.of(context)!.settings,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: const TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                const ThemeFlutterSwitch(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
