import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

class IslamicCalendarScreen extends StatefulWidget {
  const IslamicCalendarScreen({super.key});

  @override
  _IslamicCalendarScreenState createState() => _IslamicCalendarScreenState();
}

class _IslamicCalendarScreenState extends State<IslamicCalendarScreen> {
  Map<String, dynamic>? dateInfo;
  bool isLoading = true;
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchDateInfo();
  }

  Future<void> fetchDateInfo() async {
    String city = 'Raipur';  // You can change this dynamically
    String country = 'IN';   // Country code
    String apiUrl = 'https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=2';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          dateInfo = json.decode(response.body)['data']['date'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load date information');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching date information: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Islamic Calendar'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2040, 12, 31),
                    focusedDay: _selectedDay,
                    selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                      });
                    },
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                    ),
                  ),
                ),
                if (dateInfo != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Current Hijri Date:',
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${dateInfo!['hijri']['day']} ${dateInfo!['hijri']['month']['en']} ${dateInfo!['hijri']['year']}',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Current Gregorian Date:',
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${dateInfo!['gregorian']['day']} ${dateInfo!['gregorian']['month']['en']} ${dateInfo!['gregorian']['year']}',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}
