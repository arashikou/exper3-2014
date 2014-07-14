package;

import flixel.FlxG;
import flixel.FlxObject.FLOOR;
import flixel.FlxSprite;
import flixel.util.FlxColorUtil;
import flixel.util.FlxMath;

// Constants that control player motion
private class HeroPhysics
{
  public inline static var GRAVITY = 1000;
  public inline static var TERMINAL_VELOCITY = 500;
  public inline static var JUMP_SPEED = TERMINAL_VELOCITY * 9 / 10;
  public inline static var JUMP_ABORT_SPEED = JUMP_SPEED / 5;
  public inline static var GROUND_SPEED = 200;
  public inline static var AIR_CONTROL = GROUND_SPEED / 20;
}

// Sprite for player character
class Hero extends FlxSprite
{
  // We have to manually manage this state due to a bug in HaxeFlixel physics.
  public var isOnFloor:Bool;

  public function new()
  {
    super();

    makeGraphic(16, 16, FlxColorUtil.getColor32(255, 100, 255, 100));

    isOnFloor = false;
    acceleration.y = HeroPhysics.GRAVITY;
    maxVelocity.y = HeroPhysics.TERMINAL_VELOCITY;
  }

  override public function update():Void
  {
    super.update();

    // Handle left/right movement
    var left = if (FlxG.keys.pressed.LEFT) -1 else 0;
    var right = if (FlxG.keys.pressed.RIGHT) 1 else 0;
    if (isOnFloor)
    {
      velocity.x = (left + right) * HeroPhysics.GROUND_SPEED;
    }
    else
    {
      velocity.x += (left + right) * HeroPhysics.AIR_CONTROL;
      velocity.x = FlxMath.bound(velocity.x,
                                 -HeroPhysics.GROUND_SPEED,
                                 HeroPhysics.GROUND_SPEED);
    }

    // Handle jumping
    if (FlxG.keys.pressed.UP && isOnFloor)
    {
      // A jump is an instantaneous burst of upward speed.
      velocity.y = -HeroPhysics.JUMP_SPEED;
      // To work around a bug in the current version of HaxeFlixel, we need to
      // prime the first few pixels of the jump.
      y -= 2;
      isOnFloor = false;
    }
    else if (!FlxG.keys.pressed.UP &&
             velocity.y < -HeroPhysics.JUMP_ABORT_SPEED)
    {
      // If the player releases the jump button before gravity peaks the jump,
      // cut the jump short.
      velocity.y = -HeroPhysics.JUMP_ABORT_SPEED;
    }
  }
}
