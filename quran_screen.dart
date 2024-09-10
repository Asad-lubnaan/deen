import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  List<dynamic>? surah;

  @override
  void initState() {
    super.initState();
    _loadSurahData();
  }

  Future<void> _loadSurahData() async {
    try {
      final String response = await rootBundle.loadString('assets/surah_al_fatiha.json');
      final data = json.decode(response);
      setState(() {
        surah = data['surah']['ayahs'];
      });
    } catch (e) {
      print('Failed to load Surah data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran'),
      ),
      body: surah == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: surah!.length,
              itemBuilder: (context, index) {
                final ayah = surah![index];
                return ListTile(
                  title: Text('${ayah['number']}. ${ayah['text']}'),
                  subtitle: Text(ayah['translation']),
                );
              },
            ),
    );
  }
}
