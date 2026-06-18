import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

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

  runApp(MyApp());
}

class SoundButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const SoundButton({
    super.key,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 20),
        curve: Curves.easeInOut,

        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),

        decoration: BoxDecoration(
          color: active ? const Color.fromARGB(0, 0, 150, 135) : const Color.fromARGB(0, 96, 125, 139),
          borderRadius: BorderRadius.circular(10),
        ),

        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,

          style: TextStyle(
            color: active ? const Color.fromARGB(255, 252, 247, 179) : Colors.white70,
            fontSize: 16,
          ),

          child: Text(label),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final player_1 = AudioPlayer();
  final player_2 = AudioPlayer();
  final player_3 = AudioPlayer();
  final player_4 = AudioPlayer();
  final player_5 = AudioPlayer();
  final player_6 = AudioPlayer();  

  List<bool> buttonToggles = [false, false, false, false, false, false];

  bool button_1_toggled = false;
  bool button_2_toggled = false;
  bool button_3_toggled = false;
  bool button_4_toggled = false;
  bool button_5_toggled = false;
  bool button_6_toggled = false;

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
                    active: button_1_toggled,
                    onTap: () async {
                      if (!button_1_toggled) {
                        setState(() => button_1_toggled = true);
                        await player_1.setReleaseMode(ReleaseMode.loop);
                        await fadeIn(player_1, AssetSource("river_base.mp3"));
                      } else {
                        await fadeOut(player_1);
                        setState(() => button_1_toggled = false);
                      }
                    },
                  ),

                  SoundButton(
                    label: "Rain",
                    active: button_2_toggled,
                    onTap: () async {
                      if (!button_2_toggled) {
                        button_2_toggled = true;
                        await player_2.setReleaseMode(ReleaseMode.loop);
                        await fadeIn(player_2, AssetSource("rain.wav"));
                      } else {
                        await fadeOut(player_2);
                        button_2_toggled = false;
                      }
                      setState(() {});
                    },
                  ),

                  SoundButton(
                    label: "Wind",
                    active: button_3_toggled,
                    onTap: () async {
                      if (!button_3_toggled) {
                        button_3_toggled = true;
                        await player_3.setReleaseMode(ReleaseMode.loop);
                        await fadeIn(player_3, AssetSource("wind.wav"));
                      } else {
                        await fadeOut(player_3);
                        button_3_toggled = false;
                      }
                      setState(() {});
                    },
                  ),

                  SoundButton(
                    label: "Campfire",
                    active: button_4_toggled,
                    onTap: () async {
                      if (!button_4_toggled) {
                        button_4_toggled = true;
                        await player_4.setReleaseMode(ReleaseMode.loop);
                        await fadeIn(player_4, AssetSource("campfire.wav"));
                      } else {
                        await fadeOut(player_4);
                        button_4_toggled = false;
                      }
                      setState(() {});
                    },
                  ),

                  SoundButton(
                    label: "Book",
                    active: button_5_toggled,
                    onTap: () async {
                      if (!button_5_toggled) {
                        button_5_toggled = true;
                        await player_5.setReleaseMode(ReleaseMode.loop);
                        await fadeIn(player_5, AssetSource("book.wav"));
                      } else {
                        await fadeOut(player_5);
                        button_5_toggled = false;
                      }
                      setState(() {});
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
