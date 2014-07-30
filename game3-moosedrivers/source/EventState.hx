package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class EventState extends SimulationState
{
  private var _event:Event;

  public function new(status:SimulationStatus, event:Event)
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
    text.text = _event.action(_status);
    text.x = 10;
    text.y = image.y + image.height + 10;
    add(text);

    if (_event.options.length == 0)
    {
      var continueButton = new TextButton("Continue");
      continueButton.x = FlxG.width - 10 - continueButton.width;
      continueButton.y = FlxG.height - 10 - continueButton.height;
      continueButton.clickCallback = function():Void
      {
        FlxG.switchState(new HubState(_status));
      };
      add(continueButton);
    }
    else
    {
      for(index in 0..._event.options.length)
      {
        var option = _event.options[index];
        if (option != null)
        {
          var button = new TextButton(option.text);
          button.x = (10 * (index + 1)) + (button.width * index);
          button.y = FlxG.height - 10 - button.height;
          button.clickCallback = function():Void
          {
            FlxG.switchState(new EventState(_status, option.next));
          };
          add(button);
        }
      }
    }
  }
}