package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class TitleState extends FlxState
{
  override public function create():Void
  {
    super.create();

    var title = new FlxText();
    title.size = 80;
    title.font = "external_assets/fonts/Roboto.ttf";
    title.color = FlxColor.WHITE;
    title.text = "The Moose Drivers";
    title.y = 96;
    title.x = Std.int((FlxG.width - title.fieldWidth) / 2);
    add(title);
  }
}
