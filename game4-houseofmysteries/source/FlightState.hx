package;

import flixel.FlxG;
import flixel.FlxState;

class FlightState extends FlxState
{
  private var player:Player;

  override public function create():Void
  {
    super.create();
    player = new Player();
    add(player);
  }

  override public function update():Void
  {
    super.update();
  }
}
