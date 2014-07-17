package;

import flixel.FlxG;
import flixel.system.FlxSound;
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
class Hero extends EnhancedSprite
{
  public var power:Int;

  private var jump:FlxSound;

  public function new()
  {
    super(0, 0, "assets/images/Hero.png");

    power = 1;
    acceleration.y = HeroPhysics.GRAVITY;
    maxVelocity.y = HeroPhysics.TERMINAL_VELOCITY;

    jump = FlxG.sound.load("assets/sounds/Jump.wav");
    jump.volume = 0.7;
  }

  override public function update():Void
  {
    super.update();

    // Handle left/right movement
    var left = if (FlxG.keys.pressed.LEFT) -1 else 0;
    var right = if (FlxG.keys.pressed.RIGHT) 1 else 0;
    var direction = left + right;
    if (isOnFloor)
    {
      velocity.x = direction * HeroPhysics.GROUND_SPEED;
    }
    else
    {
      velocity.x += direction * HeroPhysics.AIR_CONTROL;
      velocity.x = FlxMath.bound(velocity.x,
                                 -HeroPhysics.GROUND_SPEED,
                                 HeroPhysics.GROUND_SPEED);
    }

    if (direction < 0 && !flipX)
      flipX = true;
    else if (direction > 0 && flipX)
      flipX = false;

    // Handle jumping
    var aJumpKeyIsPressed:Bool = FlxG.keys.pressed.UP || FlxG.keys.pressed.X;
    if (aJumpKeyIsPressed && isOnFloor)
    {
      // A jump is an instantaneous burst of upward speed.
      velocity.y = -HeroPhysics.JUMP_SPEED;
      // To work around a bug in the current version of HaxeFlixel, we need to
      // prime the first few pixels of the jump.
      y -= 2;
      isOnFloor = false;
      jump.play();
    }
    else if (!aJumpKeyIsPressed &&
             velocity.y < -HeroPhysics.JUMP_ABORT_SPEED)
    {
      // If the player releases the jump button before gravity peaks the jump,
      // cut the jump short.
      velocity.y = -HeroPhysics.JUMP_ABORT_SPEED;
    }
  }
}
