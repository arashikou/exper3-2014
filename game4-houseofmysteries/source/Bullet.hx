package;

import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;

typedef Group = FlxTypedGroup<Bullet>;

class Bullet extends FlxSprite
{
  public function new()
  {
    super("assets/images/Bullet.png");
    velocity.y = 100;
  }
}
