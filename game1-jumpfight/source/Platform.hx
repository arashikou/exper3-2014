package;

import flixel.FlxG;
import flixel.FlxObject.UP;
import flixel.FlxSprite;
import flixel.util.FlxColor;

// Sprite for a platform
class Platform extends FlxSprite
{
  public inline static var HEIGHT = 2;

  public function new(start:Float, end:Float, altitude:Float)
  {
    super(start, FlxG.height - altitude - HEIGHT);

    makeGraphic(Std.int(end - start), HEIGHT, FlxColor.WHITE);

    moves = false;
    immovable = true;
    allowCollisions = UP;
  }
}
