import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import '../configs/config.dart';

void main() {
  FlavorConfig(
    name: 'dev',
    variables: {
      "flagBrazil": "assets/locales/bandeira-do-brasil.png",
      "flagSpain": "assets/locales/bandeira-espanha.png",
      "flagUsa": "assets/locales/bandeira-dos-estados-unidos-eua.png",
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt'),
        Locale('en'),
        Locale('es'),
      ],
      locale: const Locale('es'),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  InkWell imageFlag(String flag) {
    return InkWell(
      onTap: () {},
      borderRadius: const BorderRadius.all(
        Radius.circular(24.0),
      ),
      child: CircleAvatar(
        backgroundImage: AssetImage(flag),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...[brazilFlag, usaFlag, spainFlag].map((flag) => imageFlag(flag)),
          ],
        ),
      ),
    );
  }
}
