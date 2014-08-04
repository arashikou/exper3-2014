package;

import flixel.FlxG;
import flixel.FlxState;

class FlightState extends FlxState
{
  private var player:Player;

  override public function create():Void
  {
    super.create();
    FlxG.mouse.load("assets/images/Target.png", 1, -8, -8);
    add(new CrazyBackground());

    player = new Player();
    add(player);
  }

  override public function destroy():Void
  {
    super.destroy();
    FlxG.mouse.load();
  }

  override public function update():Void
  {
    super.update();
  }
}
