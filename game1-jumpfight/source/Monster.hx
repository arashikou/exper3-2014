package;

import flixel.FlxG;
import flixel.FlxObject.FLOOR;
import flixel.FlxSprite;
import flixel.util.FlxColorUtil;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;

// Constants that control enemy motion
private class MonsterPhysics
{
  public inline static var GRAVITY = 1000;
  public inline static var TERMINAL_VELOCITY = 500;
  public inline static var GROUND_SPEED = 100;
}

// Sprite for enemies
class Monster extends FlxSprite
{
  var maxX:Float;

  public function new(power:Int)
  {
    super();

    makeGraphic(16, 16, FlxColorUtil.getColor32(255, 255, 0, 50));
    maxX = FlxG.width - width;

    acceleration.y = MonsterPhysics.GRAVITY;
    maxVelocity.y = MonsterPhysics.TERMINAL_VELOCITY;

    var startingDirection = FlxRandom.intRanged(-1, 1, [0]);
    velocity.x = MonsterPhysics.GROUND_SPEED * startingDirection;
  }

  override public function update():Void
  {
    super.update();

    if (x < 0)
    {
      x = 0;
      velocity.x = -velocity.x;
    }
    else if (x > maxX)
    {
      x = maxX;
      velocity.x = -velocity.x;
    }
  }
}
