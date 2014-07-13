package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

// Title Screen state
class TitleState extends FlxState
{
  override public function create():Void
  {
    super.create();

    var titleText = new FlxText();
    titleText.size = 90;
    titleText.font = "external_assets/fonts/Anton.ttf";
    titleText.text = "Jump Fight";
    titleText.y = FlxG.height * 0.1;
    titleText.x = (FlxG.width - titleText.fieldWidth) / 2;
    add(titleText);

    var startText = new FlxText();
    startText.size = 25;
    startText.font = "external_assets/fonts/Anton.ttf";
    startText.text = "Press Any Key to Start";
    startText.y = FlxG.height * 0.6;
    startText.x = (FlxG.width - startText.fieldWidth) / 2;
    add(startText);
  }

  override public function update():Void
  {
    super.update();

    if (FlxG.keys.firstPressed() != "") {
      FlxG.switchState(new GameState());
    }
  }
}