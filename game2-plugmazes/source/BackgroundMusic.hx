package;

import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.util.FlxRandom;

class BackgroundMusic
{
  static private var _tracks = [
    "DubstepLight",
    "LateNigthtTribe",
    "SpaceJazz"
  ];

  static private var currentTrack:Int;
  static private var currentSound:FlxSound;

  static public function play():Void
  {
    currentTrack = -1;
    playTrack();
  }

  static private function playTrack():Void
  {
    currentTrack = FlxRandom.intRanged(0, _tracks.length - 1, [currentTrack]);
    currentSound = FlxG.sound.play("external_assets/music/" + _tracks[currentTrack] + ".ogg");
    currentSound.onComplete = playTrack;
  }

  static public function fadeOut():Void
  {
    currentSound.fadeOut(1);
    currentSound.onComplete = null;
  }
}
