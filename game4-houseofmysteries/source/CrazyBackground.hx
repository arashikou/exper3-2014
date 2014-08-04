package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.effects.particles.FlxParticle;
import flixel.effects.particles.FlxTypedEmitter;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;

import flash.display.BlendMode;

// Very popular with New Age Retro Hippies
class CrazyBackground extends FlxGroup
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

    var emitter = new FlxTypedEmitter<Star>(0, -32, 100);
    emitter.setSize(FlxG.width, 0);
    // Because emitters have ridiculous defaults, we have to unset them.
    emitter.setRotation(0, 0);
    for (ignored in 0...emitter.maxSize)
    {
      emitter.add(new Star());
    }
    emitter.start(false, 0, 0.1);
    add(emitter);
  }

  override public function update():Void
  {
    super.update();
    _spinner.angle = (_spinner.angle + SPINNER_SPEED) % 360;
  }
}

class Star extends FlxParticle
{
  inline static public var SPEED = 1000;

  public function new()
  {
    super();
    loadGraphic("assets/images/CrazyBGStar.png");
    visible = false;
    blend = BlendMode.ADD;
  }

  override public function onEmit():Void
  {
    var distance = FlxRandom.floatRanged(1, 4);
    scale.x = 1 / distance;
    scale.y = 1 / distance;
    centerOrigin();
    velocity.x = 0;
    velocity.y = SPEED / distance;
    angle = FlxRandom.floatRanged(0, 72);
    alpha = 0.3;
  }
}
