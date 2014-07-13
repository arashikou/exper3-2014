package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColorUtil;

// Sprite for player character
class Hero extends FlxSprite
{
  public function new()
  {
    super();

    makeGraphic(16, 16, FlxColorUtil.getColor32(255, 255, 0, 0));

    acceleration.y = 320;
    maxVelocity.y = 200;
    maxVelocity.x = 300;
    drag.y = 0;
    drag.x = 500;
  }

  override public function update():Void
  {
    super.update();

    var left = if (FlxG.keys.pressed.LEFT) -1 else 0;
    var right = if (FlxG.keys.pressed.RIGHT) 1 else 0;
    var groundAcceleration = left + right;

    // Increase the magnitude of the acceleration
    // Increase it more if we're making a quick turn
    if ((groundAcceleration < 0 && velocity.x > 0) ||
        (groundAcceleration > 0 && velocity.x < 0))
    {
      groundAcceleration *= 750;
    }
    else
    {
      groundAcceleration *= 500;
    }

    acceleration.x = groundAcceleration;
  }
}