import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For clipboard operations

class HadithScreen extends StatefulWidget {
  const HadithScreen({super.key});

  @override
  _HadithScreenState createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  final List<Map<String, dynamic>> _hadithCategories = [
    {
      'category': 'Daily Hadith',
      'hadith': [
        {
          'text': 'The Prophet (peace be upon him) said: “The best among you are those who have the best manners and character.”',
          'translation': 'قال النبي (صلى الله عليه وسلم): "أفضل الناس من كان أفضلهم خلقا."',
          'isFavorite': false,
        },
        // Add more hadith for this category
      ],
    },
    {
      'category': 'Hadith on Various Topics',
      'hadith': [
        {
          'text': 'The Prophet (peace be upon him) said: “Seek knowledge from the cradle to the grave.”',
          'translation': 'قال النبي (صلى الله عليه وسلم): "طلب العلم من المهد إلى اللحد."',
          'isFavorite': false,
        },
        // Add more hadith for this category
      ],
    },
    // Add more categories as needed
  ];

  void _toggleFavorite(int categoryIndex, int hadithIndex) {
    setState(() {
      _hadithCategories[categoryIndex]['hadith'][hadithIndex]['isFavorite'] =
          !_hadithCategories[categoryIndex]['hadith'][hadithIndex]['isFavorite'];
    });
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Hadith copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hadith Collection'),
      ),
      body: ListView.builder(
        itemCount: _hadithCategories.length,
        itemBuilder: (context, categoryIndex) {
          final category = _hadithCategories[categoryIndex];
          return ExpansionTile(
            title: Text(category['category']),
            children: category['hadith'].map<Widget>((hadith) {
              final isFavorite = hadith['isFavorite'];
              return ListTile(
                title: Text(hadith['text']),
                subtitle: Text(hadith['translation']),
                trailing: IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                  onPressed: () => _toggleFavorite(categoryIndex, category['hadith'].indexOf(hadith)),
                ),
                onTap: () => _copyToClipboard(hadith['text']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
