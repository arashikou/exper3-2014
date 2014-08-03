package;

import flixel.text.FlxText;

class MooseText extends FlxText
{
  public function new(initialSize:Float, initialColor:Int)
  {
    super();
    font = "external_assets/fonts/Roboto.ttf";
    size = initialSize;
    color = initialColor;
  }
}
