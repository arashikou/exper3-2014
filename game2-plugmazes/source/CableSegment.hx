package;

import flixel.FlxSprite;

class CableSegment extends FlxSprite
{
  public function new(spriteSheet:String)
  {
    super();
    loadGraphic(spriteSheet, true, Constants.CELL_SIZE, Constants.CELL_SIZE);
    loadAnimations();
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
      if (enterDirection.priority > exitDirection.priority)
        animation.play(enterDirection.shorthand + "-to-" + exitDirection.shorthand);
      else
        animation.play(exitDirection.shorthand + "-to-" + enterDirection.shorthand);
    }
  }

  private function loadAnimations():Void
  {
    animation.add("U-base", [ 0]);
    animation.add("D-base", [ 1]);
    animation.add("L-base", [ 2]);
    animation.add("R-base", [ 3]);
    animation.add("U-plug", [ 4]);
    animation.add("D-plug", [ 5]);
    animation.add("L-plug", [ 6]);
    animation.add("R-plug", [ 7]);
    animation.add("U-to-L", [ 8]);
    animation.add("U-to-R", [ 9]);
    animation.add("D-to-L", [10]);
    animation.add("D-to-R", [11]);
    animation.add("U-to-D", [12]);
    animation.add("L-to-R", [13]);
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