package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

// Sprite for the walls at the left and right edges of the screen
class Wall extends FlxSprite
{
  public inline static var WIDTH = 16;

  public function new(offset:Int)
  {
    super(offset);

    makeGraphic(WIDTH, FlxG.height, FlxColor.WHITE);

    moves = false;
    immovable = true;
  }
}
