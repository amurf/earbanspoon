import 'package:flutter/foundation.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool _isRecording = false;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  late NoiseMeter _noiseMeter;

  @override
  void initState() {
    super.initState();
    _noiseMeter = NoiseMeter(onError);
  }

  @override
  void dispose() {
    _noiseSubscription?.cancel();
    super.dispose();
  }

  void onData(NoiseReading noiseReading) {
    setState(() {
      if (!_isRecording) {
        _isRecording = true;
      }
    });
    if (kDebugMode) {
      print(noiseReading.toString());
    }
  }

  void onError(Object error) {
    if (kDebugMode) {
      print(error.toString());
    }
    _isRecording = false;
  }

  void start() async {
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  void stop() async {
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription!.cancel();
        _noiseSubscription = null;
      }
      setState(() {
        _isRecording = false;
      });
    } catch (err) {
      if (kDebugMode) {
        print('stopRecorder error: $err');
      }
    }
  }

  List<Widget> getContent() => <Widget>[
        Container(
            margin: const EdgeInsets.all(25),
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(_isRecording ? "Mic: ON" : "Mic: OFF",
                    style: const TextStyle(fontSize: 25, color: Colors.blue)),
              )
            ])),
      ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getContent())),
        floatingActionButton: FloatingActionButton(
            backgroundColor: _isRecording ? Colors.red : Colors.green,
            onPressed: _isRecording ? stop : start,
            child: _isRecording ? const Icon(Icons.stop) : const Icon(Icons.mic)),
      ),
    );
  }
}

