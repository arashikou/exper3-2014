package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColorUtil;

// Sprite for the walls at the left and right edges of the screen
class Wall extends FlxSprite
{
  public function new()
  {
    super();

    makeGraphic(2, FlxG.height, FlxColorUtil.getColor32(255, 100, 0, 0));

    moves = false;
    immovable = true;
  }
}