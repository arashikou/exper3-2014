package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.util.FlxMath;

import flash.display.BlendMode;

// Very popular with New Age Retro Hippies
class CrazyBackground extends FlxTypedGroup<FlxSprite>
{
  inline static private var SPINNER_SPEED = 1;
  private var _spinner:FlxSprite;

  public function new()
  {
    super();

    var base = new FlxSprite();
    base.makeGraphic(FlxG.width, FlxG.height, FlxColor.PURPLE);
    add(base);

    _spinner = new FlxSprite("assets/images/CrazyBGSpin.png");
    _spinner.blend = BlendMode.MULTIPLY;
    _spinner.scale.x = 0.71;
    _spinner.scale.y = 0.71;
    _spinner.centerOrigin();
    _spinner.x = (FlxG.width - _spinner.width) / 2;
    _spinner.y = (FlxG.height - _spinner.height) / 2;
    add(_spinner);
  }

  override public function update():Void
  {
    super.update();
    _spinner.angle = (_spinner.angle + SPINNER_SPEED) % 360;
  }
}
