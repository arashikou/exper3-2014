package;

import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

typedef Pointlike = {
  var x(default,never):Float;
  var y(default,never):Float;
};

class Conveyor extends FlxTypedGroup<Glyph>
{
  inline static private var SPACING = 20;
  inline static private var SPEED = 3.5;

  private var _start:Pointlike;
  private var _end:Pointlike;
  private var _cartesianDistance:FlxPoint;
  private var _pythagoreanDistance:Float;
  private var _offset:Float;

  public function new(start:Pointlike, end:Pointlike)
  {
    super();
    _start = start;
    _end = end;
    _cartesianDistance = new FlxPoint();
    _pythagoreanDistance = 0;
    _offset = 0;
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
        glyph.x = _start.x - percent * _cartesianDistance.x - glyph.width / 2;
        glyph.y = _start.y - percent * _cartesianDistance.y - glyph.height / 2;
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
    var xDistance = _start.x - _end.x;
    var yDistance = _start.y - _end.y;
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
