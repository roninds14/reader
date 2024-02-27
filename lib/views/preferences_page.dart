import 'package:flutter/material.dart';
import 'package:reader/components/custom_app_bar.dart';
import 'package:reader/components/custom_button.dart';
import 'package:reader/components/language_wrap_select.dart';
import 'package:reader/components/theme_flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  Future<void> _saveUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('prefsPage', true);
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
        const LanguageWrapSelect(),
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
        const ThemeFlutterSwitch(),
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
