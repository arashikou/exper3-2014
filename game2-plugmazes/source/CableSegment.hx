package;

import flixel.text.FlxText;
import flixel.util.FlxColor;

class CableSegment extends ConductiveSprite
{
  public var previous(default, null):CableSegment;
  private var _next:CableSegment;
  private var _maxLength:Null<UInt>;
  private var _lengthDisplay:FlxText;

  public function new(spriteSheet:String, parent:CableSegment, ?maxLength:UInt)
  {
    super();

    loadGraphic(spriteSheet, true, Constants.CELL_SIZE, Constants.CELL_SIZE);
    loadAnimations();

    previous = parent;
    if (previous != null)
    {
      previous._next = this;
    }

    if (previous == null)
    {
      _maxLength = maxLength;
      _lengthDisplay = new FlxText();
      _lengthDisplay.size = 14;
      _lengthDisplay.font = "external_assets/fonts/NovaMono.ttf";
      _lengthDisplay.color = FlxColor.BLACK;
      _lengthDisplay.text = Std.string(_maxLength);
    }
  }

  public function length():UInt
  {
    var pastLength =
      if (previous != null)
        previous.length();
      else
        0;
    return pastLength + 1;
  }

  public function lengthRemaining():UInt
  {
    return
      if (previous != null)
        previous.lengthRemaining() - 1;
      else
        _maxLength;
  }

  public function cutOffHere():Void
  {
    if (_next != null && _next.alive)
    {
      _next.kill();
    }
    _next = null;
  }

  public function inDescendants(what:CableSegment):Bool
  {
    return
      if (_next == what)
        true;
      else if (_next == null)
        false;
      else
        _next.inDescendants(what);
  }

  public function getPlug():CableSegment
  {
    return
      if (_next == null)
        this;
      else
        _next.getPlug();
  }

  override public function isPowered():Bool
  {
    return
      if (previous != null)
        previous.isPowered();
      else
        super.isPowered();
  }

  override public function connectTo(source:Powerable):Void
  {
    // Disallow connection for non-base pieces.
    if (previous == null)
      super.connectTo(source);
  }

  override public function kill():Void
  {
    cutOffHere();
    super.kill();
  }

  override public function draw():Void
  {
    if (previous == null)
    {
      // This is the start of the chain.
      var exitDirection = getDirection(_next);
      animation.play(exitDirection.shorthand + "-base");
    }
    else if (_next == null)
    {
      // This is the end of the chain.
      var enterDirection = getDirection(previous);
      animation.play(enterDirection.shorthand + "-plug");
    }
    else
    {
      // This is somewhere in the middle of the chain.
      var enterDirection = getDirection(previous);
      var exitDirection = getDirection(_next);
      if (enterDirection.priority > exitDirection.priority)
        animation.play(enterDirection.shorthand + "-to-" + exitDirection.shorthand);
      else
        animation.play(exitDirection.shorthand + "-to-" + enterDirection.shorthand);
    }

    super.draw();

    if (_lengthDisplay != null)
    {
      _lengthDisplay.x = x + (width - _lengthDisplay.fieldWidth) / 2;
      _lengthDisplay.y = y + (height - _lengthDisplay.height) / 2;
      _lengthDisplay.draw();
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
