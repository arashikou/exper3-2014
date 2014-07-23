package;

class Cable extends ConductiveSprite
{
  private var _segments:Array<CableSegment>;
  private var _maxLength:Int;

  public function new(maxLength:Int, segments:Array<CableSegment>)
  {
    super();
    _segments = segments;
    _maxLength = maxLength;
  }

  public function cutShortBy(sections:Int):Void
  {
    var cutBy =
      if (_segments.length - sections < 2)
        _segments.length - 2;
      else
        sections;

    if (cutBy > 0)
      _segments = _segments.slice(0, -cutBy);
  }

  public function extendWith(segment:CableSegment):Bool
  {
    if (_segments.length < _maxLength)
    {
      _segments.push(segment);
      return true;
    }
    else
    {
      return false;
    }
  }
}