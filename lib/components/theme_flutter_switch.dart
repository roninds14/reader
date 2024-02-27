import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ThemeFlutterSwitch extends StatefulWidget {
  const ThemeFlutterSwitch({super.key});

  @override
  State<ThemeFlutterSwitch> createState() => _ThemeFlutterSwitchState();
}

class _ThemeFlutterSwitchState extends State<ThemeFlutterSwitch> {
  bool? _themeMode;

  @override
  void initState() {
    super.initState();

    _loadUserPrefs();
  }

  Future<void> _loadUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      String? theme = prefs.getString('theme');

      _themeMode = theme! == "light";
    });
  }

  Future<void> _saveUserThemePrefs(bool theme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme ? "light" : "dark");
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      showOnOff: true,
      value: _themeMode ?? true,
      activeColor: Theme.of(context).colorScheme.secondary,
      activeText: AppLocalizations.of(context)!.lightTheme,
      activeTextColor: Colors.white,
      activeIcon: Icon(
        Icons.light_mode,
        color: Theme.of(context).colorScheme.secondary,
      ),
      inactiveIcon: Icon(
        Icons.dark_mode,
        color: Theme.of(context).colorScheme.secondary,
      ),
      inactiveText: AppLocalizations.of(context)!.darkTheme,
      width: 90.0,
      height: 30.0,
      valueFontSize: 14.0,
      onToggle: (value) {
        setState(() {
          MyApp.of(context)!.setTheme(value);
          _themeMode = value;
          _saveUserThemePrefs(value);
        });
      },
    );
  }
}
