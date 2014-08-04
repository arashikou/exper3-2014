package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class Player extends FlxSprite
{
  inline static private var Y_SPEED = 400;

  public function new()
  {
    super();
    makeGraphic(32, 32, FlxColor.WHEAT);
    y = FlxG.height - height;
  }

  override public function update():Void
  {
    super.update();

    var xMove = 2;
    if (FlxG.keys.pressed.D) xMove += 1;
    if (FlxG.keys.pressed.A) xMove -= 1;
    x = xMove * (FlxG.width / 4) - width / 2;

    var yMove = 0;
    if (FlxG.keys.pressed.S) yMove += 1;
    if (FlxG.keys.pressed.W) yMove -= 1;
    y += yMove * FlxG.elapsed * Y_SPEED;

    bound();
  }
}
