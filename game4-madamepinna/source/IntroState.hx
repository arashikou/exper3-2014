package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class IntroState extends FlxState
{
  static private var SCENES = [
    "assets/images/CrystalBall.png"
  ];

  private var _scene:FlxSprite;
  private var _currentScene:UInt;

  override public function create():Void
  {
    super.create();
    _scene = new FlxSprite();
    _scene.alpha = 0;
    add(_scene);
    _currentScene = 0;
    startCurrentScene();
  }

  private function startCurrentScene():Void
  {
    _scene.loadGraphic(SCENES[_currentScene]);
    FlxTween.tween(_scene, { alpha: 1.0 }, 0.5, { complete: delayCurrentScene });
  }

  private function delayCurrentScene(ignored:FlxTween):Void
  {
    var throwaway = new FlxTimer(5, endCurrentScene);
  }

  private function endCurrentScene(ignored:FlxTimer):Void
  {
    FlxTween.tween(_scene, { alpha: 0.0 }, 0.5, { complete: switchScenes });
  }

  private function switchScenes(ignored:FlxTween):Void
  {
    _currentScene++;
    if (_currentScene < SCENES.length)
    {
      startCurrentScene();
    }
    else
    {
      FlxG.switchState(new FlightState());
    }
  }
}
