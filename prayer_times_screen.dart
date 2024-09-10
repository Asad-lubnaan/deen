import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  _PrayerTimesScreenState createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  late DateTime _currentTime;
  late DateTime _nextPrayerTime;
  final List<Map<String, String>> _prayerTimes = [
    {'Fajr': '05:00'},
    {'Dhuhr': '12:00'},
    {'Asr': '15:30'},
    {'Maghrib': '18:45'},
    {'Isha': '20:15'},
  ];

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _calculateNextPrayerTime();
  }

  void _calculateNextPrayerTime() {
    DateTime now = DateTime.now();
    DateTime nextPrayer = DateTime(now.year, now.month, now.day, 23, 59, 59); // Default to end of day

    for (var prayer in _prayerTimes) {
      final prayerTime = DateFormat('HH:mm').parse(prayer.values.first);
      final prayerDateTime = DateTime(now.year, now.month, now.day, prayerTime.hour, prayerTime.minute);

      if (now.isBefore(prayerDateTime)) {
        nextPrayer = prayerDateTime;
        break;
      }
    }

    if (nextPrayer == DateTime(now.year, now.month, now.day, 23, 59, 59)) {
      // If all prayer times have passed for today, set next prayer to tomorrow's Fajr
      final nextDay = now.add(const Duration(days: 1));
      final tomorrowFajr = DateFormat('HH:mm').parse(_prayerTimes.first.values.first);
      nextPrayer = DateTime(nextDay.year, nextDay.month, nextDay.day, tomorrowFajr.hour, tomorrowFajr.minute);
    }

    setState(() {
      _nextPrayerTime = nextPrayer;
    });
  }

  String _getTimeRemaining() {
    Duration remaining = _nextPrayerTime.difference(_currentTime);
    return '${remaining.inHours}:${(remaining.inMinutes % 60).toString().padLeft(2, '0')}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Times'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Current Time: ${DateFormat('HH:mm:ss').format(_currentTime)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Time Until Next Prayer: ${_getTimeRemaining()}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Prayer Times:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ..._prayerTimes.map((prayer) {
              final prayerName = prayer.keys.first;
              final prayerTime = prayer.values.first;
              return Text(
                '$prayerName: $prayerTime',
                style: const TextStyle(fontSize: 18),
              );
            }),
          ],
        ),
      ),
    );
  }
}
