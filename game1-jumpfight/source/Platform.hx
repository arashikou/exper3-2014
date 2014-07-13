package;

import flixel.FlxG;
import flixel.FlxObject.UP;
import flixel.FlxSprite;
import flixel.util.FlxColorUtil;

// Sprite for a platform
class Platform extends FlxSprite
{
  public function new(width:Int)
  {
    super();

    makeGraphic(width, 2, FlxColorUtil.getColor32(255, 255, 255, 255));

    moves = false;
    immovable = true;
    allowCollisions = UP;
  }
}