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
    var result = _event(_status);

    var image = new FlxSprite("assets/images/DefaultEvent.png");
    image.x = (FlxG.width - image.width) / 2;
    image.y = 10;
    add(image);

    var text = new MooseText(16, FlxColor.WHITE);
    text.text = result.message;
    text.x = 10;
    text.fieldWidth = FlxG.width - 20;
    text.wordWrap = true;
    text.y = image.y + image.height + 10;
    add(text);

    for(index in 0...result.options.length)
    {
      var option = result.options[index];
      if (option != null)
      {
        var button = new TextButton(option.text);
        button.x = (10 * (index + 1)) + (button.width * index);
        button.y = FlxG.height - 10 - button.height;
        button.clickCallback = function():Void
        {
          if (option.nextState == null)
            FlxG.switchState(new EventState(_status, option.nextEvent));
          else
            FlxG.switchState(Type.createInstance(option.nextState, [_status]));
        };
        add(button);
      }
    }
  }
}