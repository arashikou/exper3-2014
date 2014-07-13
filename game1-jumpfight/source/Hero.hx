package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColorUtil;

// Constants that control player motion
private class HeroPhysics
{
  public inline static var GRAVITY = 320;
  public inline static var TERMINAL_VELOCITY = 500;
  public inline static var JUMP_SPEED = TERMINAL_VELOCITY;
  public inline static var JUMP_ABORT_SPEED = TERMINAL_VELOCITY / 10;
}

// Sprite for player character
class Hero extends FlxSprite
{
  public function new()
  {
    super();

    makeGraphic(16, 16, FlxColorUtil.getColor32(255, 0, 255, 0));

    acceleration.y = HeroPhysics.GRAVITY;
    maxVelocity.y = HeroPhysics.TERMINAL_VELOCITY;
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
      // A jump is an instantaneous burst of upward speed.
      velocity.y = -HeroPhysics.JUMP_SPEED;
      // To work around a bug in the current version of HaxeFlixel, we need to
      // prime the first few pixels of the jump.
      y -= 2;
    }
    else if (!FlxG.keys.pressed.UP &&
             velocity.y < -HeroPhysics.JUMP_ABORT_SPEED)
    {
      velocity.y = -HeroPhysics.JUMP_ABORT_SPEED;
    }
  }
}
