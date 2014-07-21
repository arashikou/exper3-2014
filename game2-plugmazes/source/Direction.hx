package;

@:enum
abstract Direction(Int)
{
  public var UP    = 3;
  public var DOWN  = 2;
  public var LEFT  = 1;
  public var RIGHT = 0;

  public var shorthand(get, never):String;
  inline public function get_shorthand():String
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
}
