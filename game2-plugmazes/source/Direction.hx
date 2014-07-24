package;

import flixel.util.FlxPoint;

@:enum
abstract Direction(Int)
{
  public var UP    = 3;
  public var DOWN  = 2;
  public var LEFT  = 1;
  public var RIGHT = 0;

  public var shorthand(get, never):String;
  public function get_shorthand():String
  {
    return switch (this)
    {
      case Direction.UP:
        "U";
      case Direction.DOWN:
        "D";
      case Direction.RIGHT:
        "R";
      case Direction.LEFT:
        "L";
      default:
        // Haxe should detect that we have exhausted the enum, but for some
        // reason it still demands a default.
        throw "This should be impossible.";
    }
  }

  public var priority(get, never):Int;
  inline public function get_priority():Int
  {
    return cast(this, Int);
  }

  public var offset(get, never):FlxPoint;
  public function get_offset():FlxPoint
  {
    return switch (this)
    {
      case Direction.UP:
        new FlxPoint(0, -1);
      case Direction.DOWN:
        new FlxPoint(0, 1);
      case Direction.RIGHT:
        new FlxPoint(1, 0);
      case Direction.LEFT:
        new FlxPoint(-1, 0);
      default:
        // Haxe should detect that we have exhausted the enum, but for some
        // reason it still demands a default.
        throw "This should be impossible.";
    }
  }

  static public function parse(val:String):Direction
  {
    return switch (val)
    {
      case "U":
        Direction.UP;
      case "D":
        Direction.DOWN;
      case "R":
        Direction.RIGHT;
      case "L":
        Direction.LEFT;
      default:
        throw "Unknown shorthand.";
    }
  }
}
