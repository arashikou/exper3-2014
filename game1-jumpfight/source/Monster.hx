package;

import flixel.FlxG;
import flixel.FlxObject.FLOOR;
import flixel.FlxSprite;
import flixel.util.FlxColor;
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
  public var power:Int;

  private var maxX:Float;

  public function new(startingPower:Int)
  {
    super();

    power = startingPower;

    var size = if (power == 0)
    {
      makeGraphic(14, 14, FlxColor.RED);
    }
    else if (power <= 50)
    {
      makeGraphic(18, 18, FlxColor.RED);
    }
    else if (power < 100)
    {
      makeGraphic(32, 32, FlxColor.RED);
    }
    else
    {
      makeGraphic(64, 64, FlxColor.RED);
    }

    maxX = FlxG.width - width;

    acceleration.y = MonsterPhysics.GRAVITY;
    maxVelocity.y = MonsterPhysics.TERMINAL_VELOCITY;

    maxVelocity.x = MonsterPhysics.GROUND_SPEED;
    var startingDirection = FlxRandom.intRanged(-1, 1, [0]);
    velocity.x = MonsterPhysics.GROUND_SPEED * startingDirection;
    acceleration.x = velocity.x;
  }

  override public function update():Void
  {
    super.update();

    if (x < 0)
    {
      x = 0;
      velocity.x = -velocity.x;
      acceleration.x = -acceleration.x;
    }
    else if (x > maxX)
    {
      x = maxX;
      velocity.x = -velocity.x;
      acceleration.x = -acceleration.x;
    }
  }
}
