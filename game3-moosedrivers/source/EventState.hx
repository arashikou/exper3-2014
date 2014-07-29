package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

typedef EventFunction = SimulationStatus -> String;

class EventState extends SimulationState
{
  private var _event:EventFunction;

  public function new(status:SimulationStatus, event:EventFunction)
  {
    super(status);
    _event = event;
  }

  override public function create():Void
  {
    var image = new FlxSprite("assets/images/DefaultEvent.png");
    image.x = (FlxG.width - image.width) / 2;
    image.y = 10;
    add(image);

    var text = new MooseText(16, FlxColor.WHITE);
    text.text = _event(_status);
    text.x = 10;
    text.y = image.y + image.height + 10;
    add(text);

    var continueButton = new TextButton("Continue");
    continueButton.x = FlxG.width - 10 - continueButton.width;
    continueButton.y = FlxG.height - 10 - continueButton.height;
    continueButton.clickCallback = function():Void
    {
      FlxG.switchState(new HubState(_status));
    };
    add(continueButton);
  }
}