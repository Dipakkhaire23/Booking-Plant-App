import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    // Add more words as needed
  };

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Speech Recognition', style: TextStyle(fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          backgroundColor: Colors.blueAccent,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Recognized Speech',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextHighlight(
                    text: _text,
                    words: _highlights,
                    textStyle: const TextStyle(
                      fontSize: 32.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Text(
            //   'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
            //   style: TextStyle(
            //     fontSize: 18,
            //     color: Colors.black54,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            print("Recognized words: $_text"); // Debug output
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      } else {
        print("Speech recognition not available");
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
