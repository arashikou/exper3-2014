package;

import flixel.FlxSprite;

class Outlet extends FlxSprite
{
  public function new(spriteSheet:String, direction:Direction)
  {
    super();
    loadGraphic(spriteSheet, true, Constants.CELL_SIZE, Constants.CELL_SIZE);
    animation.add("U", [16]);
    animation.add("D", [17]);
    animation.add("L", [18]);
    animation.add("R", [19]);
    animation.play(direction.shorthand);
  }
}