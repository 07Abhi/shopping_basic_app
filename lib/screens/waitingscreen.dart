import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class WaitingPage extends StatelessWidget {
  static final String id = 'waitingscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Please Wait....',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }
}
