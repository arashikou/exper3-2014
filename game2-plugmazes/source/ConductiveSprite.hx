package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class ConductiveSprite extends FlxSprite implements Powerable implements Connectable
{
  private var _source:Powerable;
  private var _poweredBG:FlxSprite;

  public function new()
  {
    super();

    _poweredBG = new FlxSprite();
    _poweredBG.makeGraphic(Constants.CELL_SIZE, Constants.CELL_SIZE, FlxColor.YELLOW);
  }

  public function isPowered():Bool
  {
    return
      if (_source != null)
        _source.isPowered();
      else
        false;
  }

  public function connectTo(source:Powerable):Void
  {
    _source = source;
  }

  override public function draw():Void
  {
    if (isPowered())
    {
      _poweredBG.x = x;
      _poweredBG.y = y;
      _poweredBG.draw();
    }

    super.draw();
  }
}
