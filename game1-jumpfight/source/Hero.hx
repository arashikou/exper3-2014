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

    makeGraphic(16, 16, FlxColorUtil.getColor32(255, 0, 255, 0));

    acceleration.y = 320;
    maxVelocity.y = 200;
    maxVelocity.x = 300;
    drag.y = 0;
    drag.x = 500;
  }

  override public function update():Void
  {
    super.update();

    // Handle left/right movement
    var left = if (FlxG.keys.pressed.LEFT) -1 else 0;
    var right = if (FlxG.keys.pressed.RIGHT) 1 else 0;
    var hAcceleration = left + right;
    var isQuickTurn = (hAcceleration < 0 && velocity.x > 0) ||
                      (hAcceleration > 0 && velocity.x < 0);
    acceleration.x = hAcceleration * if (isQuickTurn) 750 else 500;

    // Handle jumping
    if (FlxG.keys.justPressed.UP) // && velocity.y == 0)
    {
      velocity.y = -200;
    }
    else if (!FlxG.keys.pressed.UP && velocity.y < -50)
    {
      velocity.y = -50;
    }
  }
}