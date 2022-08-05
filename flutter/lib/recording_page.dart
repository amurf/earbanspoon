import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({Key? key}) : super(key: key);

  @override
  RecordingPageState createState() => RecordingPageState();
}

class RecordingPageState extends State<RecordingPage> {
  bool _isRecording = false;
  int dB = -1;
  StreamSubscription<NoiseReading>? _noiseSubscription;

  late List<int> dBHistory = [];
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
      // print(noiseReading.maxDecibel);
      dB = noiseReading.meanDecibel.floor();
      dBHistory.add(dB);
    }
  }

  int averageDb() {
    int total = dBHistory.reduce((value, element) => value + element);
    return (total / dBHistory.length).floor();
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

  String micText() => _isRecording ? "Mic: ON" : "Mic: OFF";

  Widget currentDecibels() => Text(
        'dB: $dB',
        style: const TextStyle(fontSize: 25, color: Colors.black),
      );

  Widget averageDecibelsForRecording() => Text('Avg dB ${averageDb()}',
      style: const TextStyle(fontSize: 25, color: Colors.black));

  Widget micOnOrOff() => Text(
        micText(),
        style: const TextStyle(fontSize: 25, color: Colors.blue),
      );

  List<Widget> recordingDisplay() => <Widget>[
        currentDecibels(),
        averageDecibelsForRecording(),
      ];

  List<Widget> getContent() => <Widget>[
        Container(
            margin: const EdgeInsets.all(25),
            child: Column(children: [
              micOnOrOff(),
              const SizedBox(height: 10),
              if (_isRecording) ...recordingDisplay(),
            ])),
      ];

  void recordingToggle() => _isRecording ? stop() : start();
  Color recordingColour() => _isRecording ? Colors.red : Colors.green;
  Icon recordingIcon() =>
      _isRecording ? const Icon(Icons.stop) : const Icon(Icons.mic);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recording view")),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getContent())),
      floatingActionButton: FloatingActionButton(
        backgroundColor: recordingColour(),
        onPressed: recordingToggle,
        child: recordingIcon(),
      ),
    );
  }
}
