package;

import flixel.text.FlxText;
import flixel.util.FlxColor;

class TextButton extends Button
{
  public var text(get, set):String;

  private var _text:FlxText;

  public function new(text:String)
  {
    super("assets/images/TestButton.png", 300, 100);
    _text = new FlxText();
    _text.size = 24;
    _text.font = "external_assets/fonts/NovaMono.ttf";
    _text.color = FlxColor.BLACK;
    _text.text = text;
  }

  override public function draw():Void
  {
    super.draw();
    _text.y = y + (height - _text.height) / 2;
    _text.x = x + (width - _text.fieldWidth) / 2;
    _text.draw();
  }

  private function get_text():String
  {
    return _text.text;
  }

  private function set_text(text:String):String
  {
    return _text.text = text;
  }
}