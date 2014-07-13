package;

import flixel.FlxG;
import flixel.FlxObject.UP;
import flixel.FlxSprite;
import flixel.util.FlxColor;

// Sprite for a platform
class Platform extends FlxSprite
{
  public inline static var HEIGHT = 2;

  public function new(start:Int, end:Int, altitude:Int)
  {
    super(start, altitude);

    makeGraphic(end - start, HEIGHT, FlxColor.WHITE);

    moves = false;
    immovable = true;
    allowCollisions = UP;
  }
}
