package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxMath;

class Button extends FlxSprite
{
  public var clickCallback:Void -> Void;

  static public function DO_NOTHING():Void {}

  public function new(imagePath:String, width:Int, height:Int)
  {
    super();
    loadGraphic(imagePath, true, width, height);
    animation.add("normal", [0]);
    animation.add("hover", [1]);
    animation.add("depressed", [2]);
    clickCallback = DO_NOTHING;
  }

  override public function update():Void
  {
    if (FlxMath.pointInCoordinates(FlxG.mouse.x, FlxG.mouse.y,
                                   x, y, width, height))
    {
      if (FlxG.mouse.pressed)
      {
        animation.play("depressed");
      }
      else
      {
        animation.play("hover");
      }
    }
    else
    {
      animation.play("normal");
    }
  }
}
