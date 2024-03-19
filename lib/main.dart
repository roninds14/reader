import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:reader/views/preferences_page.dart';
import 'package:reader/views/reader_page.dart';
import 'package:reader/views/recents_page.dart';
import 'package:reader/views/settings_page.dart';
import 'package:reader/views/terms_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  FlavorConfig(
    name: 'dev',
    variables: {
      "flagBrazil": ["assets/locales/bandeira-do-brasil.png", "br"],
      "flagSpain": ["assets/locales/bandeira-espanha.png", "es"],
      "flagUsa": ["assets/locales/bandeira-dos-estados-unidos-eua.png", "en"],
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  // ignore: library_private_types_in_public_api
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  String? _locale;
  ThemeMode? _theme;

  void setLocale(String value) {
    setState(() {
      _locale = value;
    });
  }

  void setTheme(bool value) {
    setState(() {
      _theme = value ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserPrefs();
  }

  // void _genereteComic() async {
  //   var inputComic = await rootBundle.loadString("assets/exemple.json");
  //   var map = jsonDecode(inputComic);
  //   _comic = Comic.fromJson(map);
  // }

  Future<bool> _loadUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    String? language = prefs.getString('language');
    String? theme = prefs.getString('theme');

    setLocale(language!);
    setTheme(theme! == "light");

    return prefs.getBool("prefsPage")!;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(0, 3, 82, 64),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData.dark(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: _theme ?? ThemeMode.light,
      supportedLocales: const [
        Locale('pt'),
        Locale('en'),
        Locale('es'),
      ],
      locale: Locale(_locale ?? "en"),
      home: const HomePage(),
      //initialRoute: "reader",
      routes: {
        "preferences": (context) => const PreferencesPage(),
        "terms": (context) => const TermsPage(),
        "recents": (context) => const RecentsPage(),
        "settings": (context) => const SettingsPage(),
        "reader": (context) => const ReaderPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    _loadUserPrefs();
  }

  Future<void> _loadUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    bool? prefsPage = prefs.getBool("prefsPage");
    bool? termsPage = prefs.getBool("termsPage");

    if (termsPage ?? false) {
      redirect("recents");
    } else if (prefsPage ?? false) {
      redirect("terms");
    } else {
      redirect("preferences");
    }
  }

  void redirect(String route) {
    Navigator.of(context).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
