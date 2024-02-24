import 'package:flutter/material.dart';
import 'package:reader/components/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  bool _checkboxValue = false;

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
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.7,
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
                      });
                    },
                  ),
                  const Flexible(
                    child: Text(
                      "Confirmo que li e concordo com os termos e condições de uso.",
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: const MaterialStatePropertyAll(
                  Size(55.0, 55.0),
                ),
                overlayColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.secondary,
                ),
                elevation: const MaterialStatePropertyAll(7.0),
              ),
              onPressed: null,
              child: Text(
                AppLocalizations.of(context)!.btnContinue,
                style: const TextStyle(
                  fontSize: 23.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
