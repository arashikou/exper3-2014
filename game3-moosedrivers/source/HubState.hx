package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class HubState extends SimulationState
{
  private var _moosepowerReadout:MooseText;
  private var _herdReadout:MooseText;
  private var _energyReadout:MooseText;
  private var _humanFoodReadout:MooseText;
  private var _mooseFeedReadout:MooseText;
  private var _walletReadout:MooseText;
  private var _reverseOdometer:MooseText;
  private var _prediction:MooseText;

  override public function create():Void
  {
    _moosepowerReadout = new MooseText(32, FlxColor.WHITE);
    _moosepowerReadout.x = 10;
    _moosepowerReadout.y = 10;
    add(_moosepowerReadout);

    _herdReadout = new MooseText(24, FlxColor.WHITE);
    _herdReadout.x = 10;
    _herdReadout.y = 44;
    add(_herdReadout);

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

    _walletReadout = new MooseText(24, FlxColor.WHITE);
    _walletReadout.x = 10;
    _walletReadout.y = 148;
    add(_walletReadout);

    _reverseOdometer = new MooseText(32, FlxColor.WHITE);
    _reverseOdometer.x = 10;
    _reverseOdometer.y = 174;
    add(_reverseOdometer);

    _prediction = new MooseText(16, FlxColor.RED);
    _prediction.y = 226;
    add(_prediction);

    var image = new FlxSprite("assets/images/Road.png");
    image.x = FlxG.width - 10 - image.width;
    image.y = 10;
    add(image);

    var cycleButton = new TextButton("Moosercycle");
    cycleButton.x = 10;
    cycleButton.y = FlxG.height - 10 - cycleButton.height;
    cycleButton.clickCallback = function():Void
    {
      FlxG.switchState(new EventState(_status, Events.moosercycle));
    };
    add(cycleButton);

    var nextButton = new TextButton("Next Day");
    nextButton.x = cycleButton.x + 10 + cycleButton.width;
    nextButton.y = cycleButton.y;
    nextButton.clickCallback = function():Void
    {
      FlxG.switchState(new EventState(_status, Events.night));
    };
    add(nextButton);

    var moveButton = new TextButton("Travel 1 km");
    moveButton.x = 10;
    moveButton.y = cycleButton.y - 10 - moveButton.height;
    moveButton.clickCallback = function():Void
    {
      FlxG.switchState(new EventState(_status, Events.travel));
    };
    add(moveButton);

    var huntButton = new TextButton("Hunt for Food");
    huntButton.x = moveButton.x + 10 + moveButton.width;
    huntButton.y = moveButton.y;
    huntButton.clickCallback = function():Void
    {
      FlxG.switchState(new EventState(_status, Events.hunt));
    };
    add(huntButton);
  }

  override public function update():Void
  {
    super.update();
    _moosepowerReadout.text = _status.moosepower + " Moosepower";
    _herdReadout.text = "Herd: " + _status.mooseCount + " Moose & " +
                        _status.driverCount + " Drivers";
    _energyReadout.text = "Batteries: " + _status.batteryLevel + " Energy";
    _humanFoodReadout.text = "Human Food: " + _status.humanFoodLevel + " Meals";
    _mooseFeedReadout.text = "Moose Feed: " + _status.mooseFeedLevel + " Sachets";
    _walletReadout.text = "Money: " + _status.moneyString;
    _reverseOdometer.text = _status.distanceToNextTown + " km to " + _status.nameOfNextTown;
    _prediction.text = "You will need " + _status.neededFood + " Meals, " +
                       _status.neededFeed + " Sachets of Feed, and " +
                       _status.neededEnergy + " Energy tonight.";
    _prediction.x = (FlxG.width - _prediction.fieldWidth) / 2;
  }
}
