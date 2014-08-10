package;

import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;

class Bullet extends FlxSprite
{
  public function new()
  {
    super("assets/images/Bullet.png");
    kill();
  }
}

class Group extends FlxTypedGroup<Bullet>
{
  override public function getFirstDead():Bullet
  {
    var c = super.getFirstDead();
    if (c == null)
    {
      c = new Bullet();
      add(c);
    }
    return c;
  }
}
