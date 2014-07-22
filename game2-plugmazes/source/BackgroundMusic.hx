package;

import flixel.FlxG;
import flixel.util.FlxRandom;

class BackgroundMusic
{
  static private var _tracks = [
    "DubstepLight",
    "LateNigthtTribe",
    "SpaceJazz"
  ];

  static private var currentTrack:Int;

  static public function play():Void
  {
    currentTrack = FlxRandom.intRanged(0, _tracks.length);
    playTrack();
  }

  static private function playTrack():Void
  {
    currentTrack = FlxRandom.intRanged(0, _tracks.length, [currentTrack]);
    var music = FlxG.sound.play("external_assets/music/" + _tracks[currentTrack] + ".ogg");
    music.onComplete = playTrack;
  }
}