package;

import flixel.FlxSprite;

// Base class for all objects that care if they are on the floor
class EnhancedSprite extends FlxSprite
{
  // We have to manually manage this state due to a bug in HaxeFlixel physics.
  public var isOnFloor:Bool;

  public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:Dynamic = null)
  {
    super(X, Y, SimpleGraphic);
    isOnFloor = false;
  }
}
