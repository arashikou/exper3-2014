package;

import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;

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

  public function new(start:Pointlike, end:Pointlike)
  {
    super();
    _start = start;
    _end = end;
    _cartesianDistance = new FlxPoint();
  }

  override public function update():Void
  {
    calculateDistances();

    // Update glyph progresses and find the shortest living progress
    var shortestProgress = _pythagoreanDistance + SPACING;
    forEachAlive(function(glyph:Glyph):Void
    {
      glyph.progress += SPEED;
      if (glyph.progress > _pythagoreanDistance)
      {
        glyph.kill();
      }
      else
      {
        shortestProgress = Math.min(shortestProgress, glyph.progress);
      }
    });

    // Add new glyphs to the empty space before that

    // This for loop is hella complicated because the obvious while loop runs
    // into a Haxe compiler bug.
    var newCount = Std.int(shortestProgress / SPACING);
    for (offset in 1...newCount + 1)
    {
      var glyph = getFirstDead();
      glyph.revive();
      glyph.progress = shortestProgress - offset * SPACING;
    }

    // Update all glyphs' position
    forEachAlive(function(glyph:Glyph):Void
    {
      var percent = glyph.progress / _pythagoreanDistance;
      glyph.x = _start.x - percent * _cartesianDistance.x;
      glyph.y = _start.y - percent * _cartesianDistance.y;
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
      var optimalNumberOfGlyphs = Std.int(_pythagoreanDistance / SPACING) + 1;
      while (length < optimalNumberOfGlyphs)
      {
        add(new Glyph());
      }
    }
  }
}

class Glyph extends FlxSprite
{
  public var progress:Float;

  public function new()
  {
    super();
    progress = 0;
    makeGraphic(6, 8, FlxColor.PINK);
    kill();
  }

  override public function revive():Void
  {
    super.revive();
  }
}
