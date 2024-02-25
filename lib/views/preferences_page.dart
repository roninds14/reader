import 'package:flutter/material.dart';
import 'package:reader/components/custom_app_bar.dart';
import 'package:reader/components/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../main.dart';

import '../configs/config.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  bool? _themeMode;
  String? _language;

  @override
  void initState() {
    super.initState();

    _loadUserPrefs();
  }

  Future<void> _loadUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      String? theme = prefs.getString('theme');
      _language = prefs.getString('language');

      _themeMode = theme! == "light";
    });
  }

  Future<void> _saveUserLocalePrefs(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', locale);
    _language = locale;
  }

  Future<void> _saveUserThemePrefs(bool theme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme ? "light" : "dark");
  }

  Future<void> _saveUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('prefsPage', true);
  }

  InkWell imageFlag(List<String> flag) {
    return InkWell(
      onTap: () {
        MyApp.of(context)!.setLocale(flag[1]);

        _saveUserLocalePrefs(flag[1]);
      },
      borderRadius: const BorderRadius.all(
        Radius.circular(24.0),
      ),
      child: Opacity(
        opacity: flag[1] == _language ? 1.0 : 0.4,
        child: CircleAvatar(
          backgroundImage: AssetImage(flag[0]),
        ),
      ),
    );
  }

  Text _getSubtitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
    );
  }

  Column _getLanguageColumn() {
    return Column(
      children: [
        _getSubtitle(AppLocalizations.of(context)!.selectLanguage),
        const SizedBox(
          height: 15.0,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.spaceEvenly,
          spacing: 20.0,
          children: [
            ...[
              usaFlag,
              brazilFlag,
              spainFlag,
            ].map((flag) => imageFlag(flag)),
          ],
        ),
      ],
    );
  }

  Column _getThemeSwitch() {
    return Column(
      children: [
        _getSubtitle(AppLocalizations.of(context)!.selectTheme),
        const SizedBox(
          height: 15.0,
        ),
        FlutterSwitch(
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
        ),
      ],
    );
  }

  Column _getButtonArea() {
    return Column(
      children: [
        CustomButton.build(context, () {
          _saveUserPrefs();

          Navigator.pushNamed(context, "terms");
        }),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          AppLocalizations.of(context)!.youCanChangeLater,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        AppLocalizations.of(context)!.preferences,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _getLanguageColumn(),
            _getThemeSwitch(),
            _getButtonArea(),
          ],
        ),
      ),
    );
  }
}
