package;

import flixel.FlxSprite;

class CableSegment extends FlxSprite
{
  public function new(spriteSheet:String)
  {
    super();
    loadGraphic(spriteSheet, true, Constants.CELL_SIZE, Constants.CELL_SIZE);
    animation.add("U-base", [ 0]);
    animation.add("R-base", [ 1]);
    animation.add("D-base", [ 2]);
    animation.add("L-base", [ 3]);
    animation.add("U-plug", [ 4]);
    animation.add("R-plug", [ 5]);
    animation.add("D-plug", [ 6]);
    animation.add("L-plug", [ 7]);
    animation.add("U-to-R", [ 8]);
    animation.add("U-to-L", [ 9]);
    animation.add("D-to-R", [10]);
    animation.add("D-to-L", [11]);
    animation.add("U-to-D", [12]);
    animation.add("L-to-R", [13]);
  }

  public function chooseShape(before:CableSegment, after:CableSegment):Void
  {
    if (before == null)
    {
      // This is the start of the chain.
      var exitDirection = getDirection(after);
      animation.play(exitDirection.shorthand + "-base");
    }
    else if (after == null)
    {
      // This is the end of the chain.
      var enterDirection = getDirection(before);
      animation.play(enterDirection.shorthand + "-plug");
    }
    else
    {
      // This is somewhere in the middle of the chain.
      var enterDirection = getDirection(before);
      var exitDirection = getDirection(after);
      animation.play(enterDirection.shorthand + "-to-" + exitDirection.shorthand);
    }
  }

  private function getDirection(segment:CableSegment):Direction
  {
    return
        if (segment.y < y)
          Direction.UP;
        else if (segment.y > y)
          Direction.DOWN;
        else if (segment.x < x)
          Direction.LEFT;
        else
          Direction.RIGHT;
  }
}