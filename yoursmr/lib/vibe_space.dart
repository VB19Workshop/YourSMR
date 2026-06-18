import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:yoursmr/sound_button_widget.dart';



class VibeSpace extends StatefulWidget {
  @override
  _VibeSpaceState createState() => _VibeSpaceState();
}

class _VibeSpaceState extends State<VibeSpace> {
  
  List<AudioPlayer> players = [AudioPlayer(), AudioPlayer(), AudioPlayer(), AudioPlayer(), AudioPlayer(), AudioPlayer()];
  List<bool> buttonToggles = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YourSMR',
      home: Scaffold(
        backgroundColor: Color(0xFF99bd99),

        appBar: AppBar(
          backgroundColor: Color(0xFF99bd99),
          /*title: Row(
            children: [
              IconButton(icon: Icon(Icons.menu),
              iconSize: 25.0,
              onPressed: () {
              }
            )
          ],
        ), */
      ),
        
        body: Center(
          child: Text('Find your vibe',
          style: TextStyle(fontSize: 20, 
          fontFamily: 'Arial'), 
          ),
        ),
        
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Color(0xFF6b605a),
            borderRadius: BorderRadius.circular(16),
          ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SoundButton(
                    label: "River",
                    active: buttonToggles[0],
                    onTap: () async {
                      if (!buttonToggles[0]) {
                        setState(() => buttonToggles[0] = true);
                        await players[0].setReleaseMode(ReleaseMode.loop);
                        await fadeIn(players[0], AssetSource("river_base.mp3"));
                      } else {
                        await fadeOut(players[0]);
                        setState(() => buttonToggles[0] = false);
                      }
                    },
                  ),

                  SoundButton(
                    label: "Rain",
                    active: buttonToggles[1],
                    onTap: () async {
                      if (!buttonToggles[1]) {
                        setState(() => buttonToggles[1] = true);
                        await players[1].setReleaseMode(ReleaseMode.loop);
                        await fadeIn(players[1], AssetSource("rain.wav"));
                      } else {
                        await fadeOut(players[1]);
                        setState(() => buttonToggles[1] = false);
                      }
                    },
                  ),

                  SoundButton(
                    label: "Wind",
                    active: buttonToggles[2],
                    onTap: () async {
                      if (!buttonToggles[2]) {
                        setState(() => buttonToggles[2] = true);
                        await players[2].setReleaseMode(ReleaseMode.loop);
                        await fadeIn(players[2], AssetSource("wind.wav"));
                      } else {
                        await fadeOut(players[2]);
                        setState(() => buttonToggles[2] = false);
                      }
                    },
                  ),

                  SoundButton(
                    label: "Campfire",
                    active: buttonToggles[3],
                    onTap: () async {
                      if (!buttonToggles[3]) {
                        setState(() => buttonToggles[3] = true);
                        await players[3].setReleaseMode(ReleaseMode.loop);
                        await fadeIn(players[3], AssetSource("campfire.wav"));
                      } else {
                        await fadeOut(players[3]);
                        setState(() => buttonToggles[3] = false);
                      }
                    },
                  ),

                  SoundButton(
                    label: "Book",
                    active: buttonToggles[4],
                    onTap: () async {
                      if (!buttonToggles[4]) {
                        setState(() => buttonToggles[4] = true);
                        await players[4].setReleaseMode(ReleaseMode.loop);
                        await fadeIn(players[4], AssetSource("book.wav"));
                      } else {
                        await fadeOut(players[4]);
                        setState(() => buttonToggles[4] = false);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }

Future<void> fadeIn(AudioPlayer player, AssetSource source,
    {Duration duration = const Duration(milliseconds: 800)}) async {
  await player.setVolume(0.0);
  await player.play(source);

  const steps = 20;
  final stepDuration = duration ~/ steps;

  for (int i = 1; i <= steps; i++) {
    await Future.delayed(stepDuration);
    player.setVolume(i / steps);
  }
}

Future<void> fadeOut(AudioPlayer player,
    {Duration duration = const Duration(milliseconds: 800)}) async {
  const steps = 20;
  final stepDuration = duration ~/ steps;

  for (int i = steps; i >= 0; i--) {
    await Future.delayed(stepDuration);
    player.setVolume(i / steps);
  }

  await player.stop();
}

}