import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: VoiceToTextScreen(),
    );
  }
}

class VoiceToTextScreen extends StatefulWidget {
  @override
  _VoiceToTextScreenState createState() => _VoiceToTextScreenState();
}

class _VoiceToTextScreenState extends State<VoiceToTextScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _transcription = "";
  double _waveformAmplitude = 0.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    _isListening = true;
    _transcription = "";
    setState(() {});

    bool available = await _speech.initialize(
      onStatus: (val) => print('Status: $val'),
      onError: (val) => print('Error: $val'),
      debugLogging: true,
    );

    if (available) {
      _speech.listen(
        onResult: (val) {
          setState(() {
            _transcription = val.recognizedWords;
            _waveformAmplitude = val.hasConfidenceRating ? val.confidence : 0.0;
          });
        },
        localeId: 'id_ID',
      );
    } else {
      print("Pengakuan suara tidak tersedia.");
    }
  }

  void _stopListening() async {
    _isListening = false;
    setState(() {
      _transcription = "";
      _waveformAmplitude = 0.0;
    });
    await _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Suara ke Teks'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _isListening ? 'Mendengarkan...' : 'Mulai menerjemahkan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _transcription.isEmpty ? 'Silakan berbicara...' : _transcription,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            _isListening ? Waveform(amplitude: _waveformAmplitude) : SizedBox.shrink(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isListening ? _stopListening : _startListening,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: _isListening ? Colors.red : Colors.green,
              ),
              child: Icon(Icons.mic, size: 30, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _speech.cancel();
    super.dispose();
  }
}

class Waveform extends StatelessWidget {
  final double amplitude;

  const Waveform({Key? key, required this.amplitude}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: CustomPaint(
        painter: WaveformPainter(amplitude: amplitude),
      ),
    );
  }
}

class WaveformPainter extends CustomPainter {
  final double amplitude;

  WaveformPainter({required this.amplitude});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    for (int i = 0; i < size.width.toInt(); i += 5) {
      double height = (size.height / 2) + (amplitude * 20 * (0.5 - (i / size.width)));
      canvas.drawLine(Offset(i.toDouble(), size.height), Offset(i.toDouble(), height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
