package;

import flixel.FlxSprite;

class ConductiveSprite extends FlxSprite implements Powerable
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

  public function connectTo(source:Powerable)
  {
    _source = source;
  }

  public function disconnect()
  {
    connectTo(null);
  }
}