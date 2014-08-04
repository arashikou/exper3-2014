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
  inline static private var SPINNER_SPEED = 60;

  public function new()
  {
    super();

    var base = new FlxSprite();
    base.makeGraphic(FlxG.width, FlxG.height, FlxColor.PURPLE);
    add(base);

    var spinner = new FlxSprite("assets/images/CrazyBGSpin.png");
    spinner.blend = BlendMode.MULTIPLY;
    spinner.scale.x = 0.71;
    spinner.scale.y = 0.71;
    spinner.centerOrigin();
    spinner.x = (FlxG.width - spinner.width) / 2;
    spinner.y = (FlxG.height - spinner.height) / 2;
    spinner.angularVelocity = SPINNER_SPEED;
    add(spinner);

    var emitterSpacing = FlxG.width / 3;
    for (x in 0...3)
    {
      var emitter = new FlxTypedEmitter<Star>(emitterSpacing * x, -50, 100);
      emitter.setSize(Std.int(emitterSpacing), 0);
      // Because emitters have ridiculous defaults, we have to unset them.
      emitter.setRotation(0, 0);
      for (ignored in 0...emitter.maxSize)
      {
        emitter.add(new Star());
      }
      emitter.start(false, 0, 0.1);
      add(emitter);
    }
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
    alpha = 0.2;
  }
}
