import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SoundMaker extends StatefulWidget {
  const SoundMaker({Key? key}) : super(key: key);

  @override
  _SoundMakerState createState() => _SoundMakerState();
}

class _SoundMakerState extends State<SoundMaker> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  _playSound() async {
    final file = await audioCache.loadAsFile('sounds/sound_new.mp3');
    final bytes = await file.readAsBytes();
    audioCache.playBytes(bytes);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) => _playSound());

    return const Scaffold();
  }
}
