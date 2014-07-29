package;

import flixel.text.FlxText;
import flixel.util.FlxColor;

class HubState extends SimulationState
{
  private var _moosepowerReadout:FlxText;

  override public function create():Void
  {
    _moosepowerReadout = new FlxText();
    _moosepowerReadout.size = 24;
    _moosepowerReadout.font = "external_assets/fonts/Roboto.ttf";
    _moosepowerReadout.color = FlxColor.WHITE;
    _moosepowerReadout.x = 10;
    _moosepowerReadout.y = 10;
    add(_moosepowerReadout);
  }

  override public function update():Void
  {
    _moosepowerReadout.text = "Moosepower: " + _status.moosepower;
  }
}