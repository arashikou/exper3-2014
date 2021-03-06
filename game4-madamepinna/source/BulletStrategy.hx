package;

import flixel.FlxObject;
import flixel.util.FlxVelocity;

class BulletStrategy
{
  private var _group:Bullet.Group;
  private var _source:FlxObject;

  public function new(group:Bullet.Group, source:FlxObject)
  {
    _group = group;
    _source = source;
  }

  public function fire():Void
  {
    // To be overridden by descendants.
  }
}

class RotatingCross extends BulletStrategy
{
  private var _angle:Float;

  public function new(group:Bullet.Group, source:FlxObject)
  {
    super(group, source);
    _angle = 0;
  }

  override public function fire():Void
  {
    for (addon in [0, 90, 180, 270])
    {
      var bullet = _group.getFirstDead();
      bullet.revive();
      bullet.x = _source.x + (_source.width - bullet.width) / 2;
      bullet.y = _source.y + (_source.height - bullet.height) / 2;
      var angle = _angle + addon;
      // -90 to deal with the different origins of this and velocityFromAngle.
      bullet.angle = angle - 90;
      var v = FlxVelocity.velocityFromAngle(angle, 100);
      bullet.velocity.x = v.x;
      bullet.velocity.y = v.y;
    }

    _angle += 10;
  }
}
