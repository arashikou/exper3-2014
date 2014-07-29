package;

import flixel.util.FlxColor;

class HubState extends SimulationState
{
  private var _moosepowerReadout:MooseText;
  private var _mooseReadout:MooseText;
  private var _energyReadout:MooseText;
  private var _humanFoodReadout:MooseText;
  private var _mooseFeedReadout:MooseText;
  private var _reverseOdometer:MooseText;

  override public function create():Void
  {
    _moosepowerReadout = new MooseText(32, FlxColor.WHITE);
    _moosepowerReadout.x = 10;
    _moosepowerReadout.y = 10;
    add(_moosepowerReadout);

    _mooseReadout = new MooseText(24, FlxColor.WHITE);
    _mooseReadout.x = 10;
    _mooseReadout.y = 44;
    add(_mooseReadout);

    _energyReadout = new MooseText(24, FlxColor.WHITE);
    _energyReadout.x = 10;
    _energyReadout.y = 70;
    add(_energyReadout);

    _humanFoodReadout = new MooseText(24, FlxColor.WHITE);
    _humanFoodReadout.x = 10;
    _humanFoodReadout.y = 96;
    add(_humanFoodReadout);

    _mooseFeedReadout = new MooseText(24, FlxColor.WHITE);
    _mooseFeedReadout.x = 10;
    _mooseFeedReadout.y = 122;
    add(_mooseFeedReadout);

    _reverseOdometer = new MooseText(32, FlxColor.WHITE);
    _reverseOdometer.x = 10;
    _reverseOdometer.y = 148;
    add(_reverseOdometer);
  }

  override public function update():Void
  {
    _moosepowerReadout.text = _status.moosepower + " Moosepower";
    _mooseReadout.text = "Herd: " + _status.mooseCount + " Moose";
    _energyReadout.text = "Batteries: " + _status.mooseCount + " Energy";
    _humanFoodReadout.text = "Human Food: " + _status.humanFoodLevel + " Meals";
    _mooseFeedReadout.text = "Moose Feed: " + _status.mooseFeedLevel + " Sachets";
    _reverseOdometer.text = _status.distanceToNextTown + " km to " + _status.nameOfNextTown;
  }
}
