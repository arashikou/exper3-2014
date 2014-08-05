package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;

class Conveyor extends FlxTypedGroup<Glyph>
{
  inline static private var SPACING = 20;
  inline static private var SPEED = 3;

  private var _targetA:FlxObject;
  private var _targetB:FlxObject;

  public function new(targetA:FlxObject, targetB:FlxObject)
  {
    super();
    _targetA = targetA;
    _targetB = targetB;
  }

  override public function update():Void
  {
    var xDistance = _targetA.x - _targetB.x;
    var yDistance = _targetA.y - _targetB.y;
    var distance = Math.sqrt(xDistance * xDistance + yDistance * yDistance);
    var optimalNumberOfGlyphs = distance / SPACING + 1;
    while (length < optimalNumberOfGlyphs)
    {
      add(new Glyph());
    }

    // Update glyph progresses and find the shortest living progress
    var shortestProgress = distance + SPACING;
    forEachAlive(function(glyph:Glyph):Void
    {
      glyph.progress += SPEED;
      if (glyph.progress > distance)
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
      var percent = glyph.progress / distance;
      glyph.x = _targetA.x - percent * xDistance;
      glyph.y = _targetA.y - percent * yDistance;
    });

    super.update();
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
