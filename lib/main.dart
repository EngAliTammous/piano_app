import 'package:flutter/material.dart';
import 'package:piano/piano.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  final _flutterMidi = FlutterMidi();

  @override
  void initState() {
    load('assets/best.sf2');
    super.initState();
  }
  void load(String asset) async {
    _flutterMidi.unmute(); // Optionally Unmute
    ByteData _byte = await rootBundle.load(asset);
    _flutterMidi.prepare(sf2: _byte);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Piano Demo',
        home: Scaffold(
          body: Center(
            child: InteractivePiano(

              highlightedNotes: [
                NotePosition(note: Note.A, octave: 3)
              ],
              naturalColor: Colors.white,
              accidentalColor: Colors.black,
              keyWidth: 60,
              noteRange: NoteRange.forClefs([
                Clef.Treble,
              ]),
              onNotePositionTapped: (position) {

                _flutterMidi.playMidiNote(midi: position.pitch);
               // playMidiNote(note: position, velocity: 127)
              },
            ),
          ),
        )
       );
  }
}