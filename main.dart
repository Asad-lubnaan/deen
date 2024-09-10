import 'dart:math';
import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'prayer_times_screen.dart';
import 'qibla_direction_screen.dart';
import 'quran_screen.dart';
import 'dua_collection_screen.dart';
import 'tasbeeh_counter_screen.dart';
import 'islamic_calendar_screen.dart';
import 'hadith_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  final List<String> _quotes = [
    "Be good to others, that will protect you against evil.",
    "A person does not have an understanding of the religion of Islam until he thinks of a hardship as being a blessing, and comfort and luxury as being a tribulation.",
    "Do not sell your conscience for anything but Jannah.",
    "Truth lifts the heart like water refreshes thirst.",
    "The world is but a moment, so make it a moment of obedience.",
    "Every soul shall taste death… (Quran 3:185)",
    "When love of this world enters the heart, the fear of the Hereafter exits from it.",
    "Knowledge is not what is memorized. Knowledge is what benefits."
  ];

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _showRandomQuote(BuildContext context) {
    final random = Random();
    final quote = _quotes[random.nextInt(_quotes.length)];

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: const Text('Daily Quote'),
        content: Text(quote),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DEEN App',
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.green,
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.green,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(
              onSplashComplete: () => _showRandomQuote(context),
            ),
        '/home': (context) => MyHomePage(onThemeToggle: _toggleTheme),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const MyHomePage({super.key, required this.onThemeToggle});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onMenuSelected(String value) {
    setState(() {
      switch (value) {
        case 'Prayer Times':
          _selectedIndex = 0;
          break;
        case 'Qibla Direction':
          _selectedIndex = 1;
          break;
        case 'Quran':
          _selectedIndex = 2;
          break;
        case 'Dua Collection':
          _selectedIndex = 3;
          break;
        case 'Tasbeeh Counter':
          _selectedIndex = 4;
          break;
        case 'Islamic Calendar':
          _selectedIndex = 5;
          break;
        case 'Hadith':
          _selectedIndex = 6;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const PrayerTimesScreen(),
      const QiblaDirectionScreen(),
      const QuranScreen(),
      const DuaCollectionScreen(),
      const TasbeehCounterScreen(),
      const IslamicCalendarScreen(),
      const HadithScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('DEEN App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      body: pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.access_time),
                    title: const Text('Prayer Times'),
                    onTap: () {
                      _onMenuSelected('Prayer Times');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.navigation),
                    title: const Text('Qibla Direction'),
                    onTap: () {
                      _onMenuSelected('Qibla Direction');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text('Quran'),
                    onTap: () {
                      _onMenuSelected('Quran');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.bookmark),
                    title: const Text('Dua Collection'),
                    onTap: () {
                      _onMenuSelected('Dua Collection');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Tasbeeh Counter'),
                    onTap: () {
                      _onMenuSelected('Tasbeeh Counter');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('Islamic Calendar'),
                    onTap: () {
                      _onMenuSelected('Islamic Calendar');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('Hadith'),
                    onTap: () {
                      _onMenuSelected('Hadith');
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.menu),
      ),
    );
  }
}
