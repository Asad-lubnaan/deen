import 'package:flutter/material.dart';

class QiblaDirectionScreen extends StatelessWidget {
  const QiblaDirectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qibla Direction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              color: Colors.blue,
              child: const Center(child: Text('Compass with Qibla Arrow')),
            ),
            const SizedBox(height: 20),
            const Text(
              'Compass to show Qibla direction.',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
