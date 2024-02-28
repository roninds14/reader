import 'package:flutter/material.dart';
import 'package:reader/components/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reader/components/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  bool _checkboxValue = false;
  void Function()? _buttonFunction;

  void _buttonActive(bool checkboxValue) {
    setState(() {
      _buttonFunction = checkboxValue
          ? () {
              _saveUserPrefs();

              Navigator.of(context).pushNamed("recents");
            }
          : null;
    });
  }

  Future<void> _saveUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('termsPage', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(context, AppLocalizations.of(context)!.terms),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15.0),
                ),
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              padding: const EdgeInsets.all(15.0),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.85,
              child: SingleChildScrollView(
                child: Text(
                  AppLocalizations.of(context)!.termsAndConditions,
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 30,
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _checkboxValue,
                    onChanged: (value) {
                      setState(() {
                        _checkboxValue = value!;

                        _buttonActive(value);
                      });
                    },
                  ),
                  Flexible(
                    child: GestureDetector(
                      child: Text(
                        AppLocalizations.of(context)!.confirmTermsAcept,
                        textAlign: TextAlign.justify,
                      ),
                      onTap: () {
                        setState(() {
                          _checkboxValue = !_checkboxValue;

                          _buttonActive(_checkboxValue);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            CustomButton.build(context, _buttonFunction),
          ],
        ),
      ),
    );
  }
}
