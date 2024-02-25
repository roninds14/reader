import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomButton {
  static ElevatedButton build(BuildContext context, void Function()? func) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: const MaterialStatePropertyAll(
          Size(55.0, 55.0),
        ),
        overlayColor: MaterialStatePropertyAll(
          Theme.of(context).colorScheme.secondary,
        ),
        elevation: const MaterialStatePropertyAll(7.0),
      ),
      onPressed: func,
      child: Text(
        AppLocalizations.of(context)!.btnContinue,
        style: const TextStyle(
          fontSize: 23.0,
        ),
      ),
    );
  }
}
