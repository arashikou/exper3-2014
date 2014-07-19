package;

import flixel.FlxG;
import flixel.FlxObject.FLOOR;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

// Constants that control enemy motion
private class MonsterPhysics
{
  public inline static var GRAVITY = 1000;
  public inline static var TERMINAL_VELOCITY = 500;
  public inline static var GROUND_SPEED = 100;
}

// Sprite for enemies
class Monster extends EnhancedSprite
{
  public var power:Int;

  private var maxX:Float;
  private var powerBadge:FlxText;
  private var badgeOffset:FlxPoint;

  private var wasOnFloor:Bool;
  private var drop:FlxSound;

  public function new()
  {
    super();

    drop = FlxG.sound.load("assets/sounds/MonsterDrop.wav");
    powerBadge = new FlxText();
    badgeOffset = new FlxPoint();

    acceleration.y = MonsterPhysics.GRAVITY;
    maxVelocity.y = MonsterPhysics.TERMINAL_VELOCITY;
  }

  public function initialize(newPower:Int)
  {
    power = newPower;

    isOnFloor = false;
    wasOnFloor = isOnFloor;

    powerBadge.text = Std.string(power);

    if (power == 0)
    {
      loadGraphic("assets/images/ZeroBlob.png");
      powerBadge.size = 8;
      badgeOffset.x = 0;
      badgeOffset.y = 2;
    }
    else if (power <= 50)
    {
      loadGraphic("assets/images/SmallBlob.png");
      powerBadge.size = 8;
      badgeOffset.x = 0;
      badgeOffset.y = 0;
    }
    else if (power < 100)
    {
      makeGraphic(32, 32, FlxColor.RED);
      powerBadge.size = 16;
    }
    else
    {
      makeGraphic(64, 64, FlxColor.RED);
      powerBadge.size = 32;
    }
    updateHitbox();

    maxX = FlxG.width - width;

    var speedModifier = if (power == 0)
                          0;
                        else if (power <= 50)
                          FlxRandom.floatRanged(0.75, 1.0);
                        else if (power < 100)
                          FlxRandom.floatRanged(0.9, 1.2);
                        else
                          0.6;
    var speed = speedModifier * MonsterPhysics.GROUND_SPEED;

    maxVelocity.x = speed;
    var startingDirection = FlxRandom.intRanged(-1, 1, [0]);
    velocity.x = speed * startingDirection;
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

    if (isOnFloor && isOnFloor != wasOnFloor)
    {
      wasOnFloor = isOnFloor;
      if (isOnFloor)
      {
        drop.play();
      }
    }
  }

  override public function draw():Void
  {
    super.draw();

    powerBadge.x = x + (width - powerBadge.fieldWidth) / 2 +
        if (flipX) badgeOffset.x else -badgeOffset.x;
    powerBadge.y = y + (height - powerBadge.height) / 2 + badgeOffset.y;
    powerBadge.draw();
  }
}
