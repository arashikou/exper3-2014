package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
  public function new()
  {
    super();
    makeGraphic(32, 32, FlxColor.WHEAT);
    y = FlxG.height - height - 20;
  }

  override public function update():Void
  {
    super.update();

    var xMove = 2;
    if (FlxG.keys.pressed.D) xMove += 1;
    if (FlxG.keys.pressed.A) xMove -= 1;
    x = xMove * (FlxG.width / 4) - width / 2;
  }
}
