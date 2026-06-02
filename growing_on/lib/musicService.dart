import 'package:audioplayers/audioplayers.dart';

AudioPlayer audioPlayer = AudioPlayer();

void Start (){
  audioPlayer.setReleaseMode(ReleaseMode.loop);
  if(audioPlayer.state != PlayerState.playing)audioPlayer.play(AssetSource('audio/Stand-Tall.mp3'));
}