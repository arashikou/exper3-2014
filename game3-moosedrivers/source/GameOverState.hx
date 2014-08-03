package;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSave;

class GameOverState extends SimulationState
{
  override public function create():Void
  {
    var saveData = new FlxSave();
    saveData.bind(Constants.saveName);
    saveData.erase();

    var message = new MooseText(96, FlxColor.RED);
    message.text = "GAME OVER";
    message.y = 150;
    message.x = (FlxG.width - message.fieldWidth) / 2;
    add(message);

    var button = new TextButton("Return to Title");
    button.y = FlxG.height - 10 - button.height;
    button.x = (FlxG.width - button.width) / 2;
    button.clickCallback = function():Void
    {
      FlxG.switchState(new TitleState());
    };
    add(button);
  }
}
