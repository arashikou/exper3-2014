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

    var newButton = new TextButton("New Game");
    newButton.y = 350;
    newButton.x = Std.int((FlxG.width - newButton.width) / 2);
    add(newButton);

    var loadButton = new TextButton("Load Game");
    loadButton.y = 475;
    loadButton.x = Std.int((FlxG.width - loadButton.width) / 2);
    add(loadButton);
  }
}
