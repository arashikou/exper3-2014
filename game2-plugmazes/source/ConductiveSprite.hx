package;

import flixel.FlxSprite;

class ConductiveSprite extends FlxSprite implements Powerable implements Connectable
{
  private var _source: Powerable;

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
}
