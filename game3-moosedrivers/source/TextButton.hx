package;

import flixel.text.FlxText;
import flixel.util.FlxColorUtil;

class TextButton extends Button
{
  public var text(get, set):String;

  private var _text:FlxText;

  public function new(text:String)
  {
    super("assets/images/TextButton.png", 300, 100);
    _text = new FlxText();
    _text.size = 32;
    _text.font = "external_assets/fonts/Roboto.ttf";
    _text.color = FlxColorUtil.getColor24(82, 198, 39);
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