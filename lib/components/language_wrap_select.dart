import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/config.dart';
import '../main.dart';

class LanguageWrapSelect extends StatefulWidget {
  const LanguageWrapSelect({super.key});

  @override
  State<LanguageWrapSelect> createState() => _LanguageWrapSelectState();
}

class _LanguageWrapSelectState extends State<LanguageWrapSelect> {
  String? _language;

  @override
  void initState() {
    super.initState();

    _loadUserPrefs();
  }

  Future<void> _loadUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _language = prefs.getString('language');
    });
  }

  Future<void> _saveUserLocalePrefs(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', locale);
    setState(() {
      _language = locale;
    });
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

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.spaceEvenly,
      spacing: 20.0,
      children: [
        ...languageFlags.map((flag) => imageFlag(flag)),
      ],
    );
  }
}
