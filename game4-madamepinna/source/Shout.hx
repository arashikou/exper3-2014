package;

import Apparition.Subject;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;

class Shout extends FlxSprite
{
  private var _text:FlxText;

  public function new()
  {
    super();

    makeGraphic(FlxG.width, 84, FlxColor.BLACK);
    alpha = 0.5;
    x = 0;
    y = FlxG.height - height;

    _text = new FlxText();
    _text.font = "external_assets/fonts/Alice.ttf";
    _text.size = 32;
    _text.x = x + 10;
    _text.y = y;
    _text.fieldWidth = FlxG.width - 20;
    _text.wordWrap = true;
    _text.alignment = "center";

    kill();
  }

  public function randomize(subject:Subject):Void
  {
    _text.text = getQuip(subject);
  }

  override public function draw():Void
  {
    super.draw();
    _text.draw();
  }

  static private function getQuip(subject:Subject):String
  {
    return FlxRandom.getObject(switch (subject)
    {
      case Red:
        [
          "Your boyfriend is cheating on you."
        ];
      case Blue:
        [
          "It's time to get over your childhood pet's death."
        ];
      case Green:
        [
          "Next Tuesday, give exactly $3.50 to the blind beggar."
        ];
    });
  }
}
