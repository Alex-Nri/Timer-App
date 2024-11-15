import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimerHomePage(),
    );
  }
}

class TimerHomePage extends StatefulWidget {
  @override
  _TimerHomePageState createState() => _TimerHomePageState();
}

class _TimerHomePageState extends State<TimerHomePage> {
  late Timer _timer;
  int _seconds = 0;
  bool _isRunning = false;

  void _startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
      _isRunning = true;
    }
  }

  void _pauseTimer() {
    if (_isRunning) {
      _timer.cancel();
      _isRunning = false;
    }
  }

  void _continueTimer() {
    if (!_isRunning) {
      _startTimer();
    }
  }

  void _restartTimer() {
    _timer.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  String _formatTime(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$secondsStr';
  }

  @override
  void dispose() {
    if (_isRunning) _timer.cancel();
    super.dispose();
  }

  Widget _buildButton(String label, Color color, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5, // Add shadow
          shadowColor: Colors.black.withOpacity(0.4),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(_seconds),
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            _buildButton('Start', Colors.green, _startTimer),
            _buildButton('Pause', Colors.yellow, _pauseTimer),
            _buildButton('Continue', Colors.blue, _continueTimer),
            _buildButton('Restart', Colors.red, _restartTimer),
          ],
        ),
      ),
    );
  }
}
