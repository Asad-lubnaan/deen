import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For clipboard operations

class DuaCollectionScreen extends StatefulWidget {
  const DuaCollectionScreen({super.key});

  @override
  _DuaCollectionScreenState createState() => _DuaCollectionScreenState();
}

class _DuaCollectionScreenState extends State<DuaCollectionScreen> {
  final List<Map<String, dynamic>> _duaCategories = [
    {
      'category': 'Daily Duas',
      'duas': [
        {
          'text': 'اللهم صل على محمد وعلى آل محمد',
          'translation': 'O Allah, send blessings upon Muhammad and upon the family of Muhammad.',
          'isFavorite': false,
        },
        // Add more duas for this category
      ],
    },
    {
      'category': 'Duas for Specific Occasions',
      'duas': [
        {
          'text': 'بسم الله الرحمن الرحيم',
          'translation': 'In the name of Allah, the Most Gracious, the Most Merciful.',
          'isFavorite': false,
        },
        // Add more duas for this category
      ],
    },
    // Add more categories as needed
  ];

  void _toggleFavorite(int categoryIndex, int duaIndex) {
    setState(() {
      _duaCategories[categoryIndex]['duas'][duaIndex]['isFavorite'] =
          !_duaCategories[categoryIndex]['duas'][duaIndex]['isFavorite'];
    });
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dua copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dua Collection'),
      ),
      body: ListView.builder(
        itemCount: _duaCategories.length,
        itemBuilder: (context, categoryIndex) {
          final category = _duaCategories[categoryIndex];
          return ExpansionTile(
            title: Text(category['category']),
            children: category['duas'].map<Widget>((dua) {
              final isFavorite = dua['isFavorite'];
              return ListTile(
                title: Text(dua['text']),
                subtitle: Text(dua['translation']),
                trailing: IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                  onPressed: () => _toggleFavorite(categoryIndex, category['duas'].indexOf(dua)),
                ),
                onTap: () => _copyToClipboard(dua['text']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
