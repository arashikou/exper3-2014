package;

import flixel.FlxG;
import flixel.FlxState;

class FlightState extends FlxState
{
  private var _player:Player;

  override public function create():Void
  {
    super.create();
    FlxG.mouse.load("assets/images/Target.png", 1, -8, -8);
    add(new CrazyBackground());

    _player = new Player();
    add(_player);

    var conveyor = new Conveyor(_player, FlxG.mouse);
    add(conveyor);
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
