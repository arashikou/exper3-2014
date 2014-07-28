package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSave;

class TitleState extends FlxState
{
  private var _saveData:FlxSave;

  override public function create():Void
  {
    super.create();

    var title = new FlxText();
    title.size = 80;
    title.font = "external_assets/fonts/Roboto.ttf";
    title.color = FlxColor.WHITE;
    title.text = "The Moose Drivers";
    title.y = 96;
    title.x = (FlxG.width - title.fieldWidth) / 2;
    add(title);

    var newButton = new TextButton("New Game");
    newButton.y = 350;
    newButton.x = (FlxG.width - newButton.width) / 2;
    newButton.clickCallback = function():Void
    {
      beginGame(new GameState());
    };
    add(newButton);

    _saveData = new FlxSave();
    _saveData.bind(Constants.saveName);

    if (_saveData.data.version != null)
    {
      var loadButton = new TextButton("Load Game");
      loadButton.y = 475;
      loadButton.x = (FlxG.width - loadButton.width) / 2;
      loadButton.clickCallback = function():Void
      {
        beginGame(GameState.load(_saveData));
      };
      add(loadButton);
    }
  }

  override public function destroy():Void
  {
    _saveData.destroy();
  }

  private function beginGame(state:GameState):Void
  {
    FlxG.switchState(new Dawn(state));
  }
}
