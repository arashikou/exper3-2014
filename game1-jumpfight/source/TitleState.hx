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

    var titleText = new FlxText(0, FlxG.height * 0.1);
    titleText.size = 100;
    titleText.font = "external_assets/fonts/Anton.ttf";
    titleText.text = "Jump Fight";
    titleText.x = (FlxG.width - titleText.fieldWidth) / 2;
    add(titleText);
  }

  override public function destroy():Void
  {
    super.destroy();
  }

  override public function update():Void
  {
    super.update();
  }
}