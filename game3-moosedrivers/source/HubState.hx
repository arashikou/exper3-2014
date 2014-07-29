package;

import flixel.util.FlxColor;

class HubState extends SimulationState
{
  private var _moosepowerReadout:MooseText;

  override public function create():Void
  {
    _moosepowerReadout = new MooseText(32, FlxColor.WHITE);
    _moosepowerReadout.x = 10;
    _moosepowerReadout.y = 10;
    add(_moosepowerReadout);
  }

  override public function update():Void
  {
    _moosepowerReadout.text = "Moosepower: " + _status.moosepower;
  }
}
