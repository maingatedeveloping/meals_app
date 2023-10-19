import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String textMessage;
  const EmptyList(this.textMessage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 90,
            ),
            Text(
              textMessage,
              style: const TextStyle(
                fontSize: 23,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
