import 'package:flutter/material.dart';
import 'package:reader/components/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reader/components/language_wrap_select.dart';
import 'package:reader/components/theme_flutter_switch.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final EdgeInsetsGeometry _rowPadding = const EdgeInsets.symmetric(
    horizontal: 35.0,
  );

  final SizedBox _sizedBox = const SizedBox(
    height: 15.0,
  );

  Text _getSettingLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 25.0,
      ),
    );
  }

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
            padding: _rowPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getSettingLabel(AppLocalizations.of(context)!.language),
                const Flexible(
                  child: LanguageWrapSelect(
                    radius: 13.0,
                  ),
                ),
              ],
            ),
          ),
          _sizedBox,
          Padding(
            padding: _rowPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getSettingLabel(AppLocalizations.of(context)!.theme),
                const ThemeFlutterSwitch(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
