import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../configs/config.dart';

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

  Future<void> _loadUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      String? language = prefs.getString('language');
      String? theme = prefs.getString('theme');

      setLocale(language!);
      setTheme(theme! == "light");
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
      locale: Locale(_locale ?? "pt"),
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
        opacity: flag[1] == _language ? 1.0 : 0.6,
        child: CircleAvatar(
          backgroundImage: AssetImage(flag[0]),
        ),
      ),
    );
  }

  FlutterSwitch _getThemeSwitch() {
    return FlutterSwitch(
      showOnOff: true,
      value: _themeMode ?? true,
      activeColor: const Color.fromARGB(255, 50, 64, 168),
      activeText: AppLocalizations.of(context)!.lightTheme,
      activeTextColor: Colors.white,
      activeIcon: const Icon(
        Icons.light_mode,
        color: Color.fromARGB(255, 50, 64, 168),
      ),
      inactiveText: AppLocalizations.of(context)!.darkTheme,
      inactiveIcon: const Icon(
        Icons.dark_mode,
        color: Colors.black38,
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.spaceEvenly,
              spacing: 20.0,
              children: [
                ...[
                  brazilFlag,
                  usaFlag,
                  spainFlag,
                ].map((flag) => imageFlag(flag)),
              ],
            ),
            _getThemeSwitch(),
          ],
        ),
      ),
    );
  }
}
