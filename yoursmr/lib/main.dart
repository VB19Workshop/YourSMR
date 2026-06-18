import "package:flutter/material.dart";
import "package:audioplayers/audioplayers.dart";
import "package:yoursmr/vibe_space.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AudioPlayer.global.setAudioContext(
    AudioContext(
      android: AudioContextAndroid(
        contentType: AndroidContentType.sonification,
        usageType: AndroidUsageType.game,
        audioFocus: AndroidAudioFocus.none,
      ),
    ),
  );

  runApp(VibeSpace());
}


