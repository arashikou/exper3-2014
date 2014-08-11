package;

class Offsetter
{
  private var _target:Pointlike;
  private var _offset:Pointlike;

  public var x(get,never):Float;
  public var y(get,never):Float;

  public function new(target, offset)
  {
    _target = target;
    _offset = offset;
  }

  private function get_x():Float
  {
    return _target.x + _offset.x;
  }

  private function get_y():Float
  {
    return _target.y + _offset.y;
  }
}
