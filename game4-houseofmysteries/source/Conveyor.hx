package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

class Conveyor extends FlxTypedGroup<Glyph>
{
  inline static private var SPACING = 20;
  inline static private var SPEED = 3.5;

  public var start:FlxObject;
  public var end:FlxObject;

  private var _cartesianDistance:FlxPoint;
  private var _pythagoreanDistance:Float;
  private var _offset:Float;

  public function new(?vStart:FlxObject, ?vEnd:FlxObject)
  {
    super();
    start = vStart;
    end = vEnd;
    _cartesianDistance = new FlxPoint();
    _pythagoreanDistance = 0;
    _offset = 0;
    if (start == null || end == null)
    {
      kill();
    }
  }

  override public function update():Void
  {
    calculateDistances();

    var glyphShift = false;
    _offset += SPEED;
    if (_offset > SPACING)
    {
      _offset -= SPACING;
      glyphShift = true;
    }

    var counter:UInt = 0;
    forEach(function(glyph:Glyph):Void
    {
      var distance = _offset + counter * SPACING;
      if (distance < _pythagoreanDistance)
      {
        if (!glyph.alive)
        {
          glyph.revive();
        }
        else if (glyphShift)
        {
          glyph.randomize();
        }
        var percent = distance / _pythagoreanDistance;
        var startPoint = getPoint(start);
        glyph.x = startPoint.x - percent * _cartesianDistance.x - glyph.width / 2;
        glyph.y = startPoint.y - percent * _cartesianDistance.y - glyph.height / 2;
        counter++;
      }
      else if (glyph.alive)
      {
        glyph.kill();
      }
    });

    super.update();
  }

  private function calculateDistances():Void
  {
    var startPoint = getPoint(start);
    var endPoint = getPoint(end);

    var xDistance = startPoint.x - endPoint.x;
    var yDistance = startPoint.y - endPoint.y;
    if (xDistance != _cartesianDistance.x || yDistance != _cartesianDistance.y)
    {
      _cartesianDistance.x = xDistance;
      _cartesianDistance.y = yDistance;
      _pythagoreanDistance = Math.sqrt(xDistance * xDistance +
                                       yDistance * yDistance);
      var optimalNumberOfGlyphs = Std.int(_pythagoreanDistance / SPACING);
      while (length < optimalNumberOfGlyphs)
      {
        add(new Glyph());
      }
    }
  }

  private function getPoint(object:FlxObject):FlxPoint
  {
    var x = object.x + object.width / 2;
    var y = object.y + object.height / 2;
    return new FlxPoint(x, y);
  }
}

class Glyph extends FlxSprite
{
  public function new()
  {
    super();
    loadGraphic("assets/images/Glyphs.png", true, 8, 8);
    for (index in 0...4)
    {
      animation.add(Std.string(index), [index]);
    }
    kill();
  }

  override public function revive():Void
  {
    super.revive();
    randomize();
  }

  public function randomize():Void
  {
    animation.play(Std.string(FlxRandom.intRanged(0, 3)));
  }
}
