import 'package:flutter/material.dart';

class Splashpage extends StatelessWidget {
  const Splashpage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const Splashpage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
