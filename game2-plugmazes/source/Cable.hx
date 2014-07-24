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

  public function updateAppearance():Void
  {
    for (index in 0..._segments.length)
    {
      var before =
        if (index > 0)
          _segments[index - 1];
        else
          null;
      var after =
        if (index < _segments.length - 1)
          _segments[index + 1];
        else
          null;
      _segments[index].chooseShape(before, after);
    }
  }

  override public function draw():Void
  {
    for (segment in _segments)
    {
      segment.draw();
    }
  }
}