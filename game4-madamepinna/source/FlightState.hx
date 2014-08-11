package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

class FlightState extends FlxState
{
  private var _squadrons:FlxTypedGroup<Squadron>;
  private var _player:Player;
  private var _conveyors:Conveyor.WorkAroundHaxeLimitationGroup;
  private var _bullets:Bullet.Group;
  private var _personTether:Conveyor;
  private var _predictionTether:Conveyor;

  override public function create():Void
  {
    super.create();
    FlxG.mouse.load("assets/images/Target.png", 1, -8, -8);
    add(new CrazyBackground());

    _squadrons = new FlxTypedGroup<Squadron>();
    _player = new Player();
    _conveyors = new Conveyor.WorkAroundHaxeLimitationGroup();
    _bullets = new Bullet.Group();
    _personTether = new Conveyor(_player);
    _predictionTether = new Conveyor(_player);

    add(_squadrons);
    add(_player);
    add(_conveyors);
    add(_bullets);
    add(_personTether);
    add(_predictionTether);
  }

  override public function destroy():Void
  {
    super.destroy();
    FlxG.mouse.load();
  }

  override public function update():Void
  {
    if (_squadrons.members.length == 0 || !_squadrons.members[0].isViable())
    {
      _squadrons.forEach(function(squadron:Squadron):Void
      {
        squadron.kill();
      });
      _squadrons.clear();

      var s = new Squadron(FlxRandom.intRanged(1, 4), _bullets);
      _squadrons.add(s);
      introduce(s);
    }

    super.update();
    _bullets.forEachAlive(function(bullet:Bullet):Void
    {
      if (bullet.x < -100 || bullet.x > FlxG.width + 100 ||
          bullet.y < -100 || bullet.y > FlxG.height + 100)
      {
        bullet.kill();
      }
    });

    if (FlxG.mouse.justPressed)
    {
      _squadrons.members[0].forEach(function(apparition:Apparition):Void
      {
        if (FlxG.mouse.x >= apparition.x && FlxG.mouse.x < apparition.x + apparition.width &&
            FlxG.mouse.y >= apparition.y && FlxG.mouse.y < apparition.y + apparition.height)
        {
          if (apparition.form == Person)
          {
            _personTether.end = apparition;
            _personTether.revive();
          }
          else
          {
            _predictionTether.end = apparition;
            _predictionTether.revive();
          }
        }
      });
    }

    if (_personTether.alive && _predictionTether.alive)
    {
      var tetheredPerson = cast(_personTether.end, Apparition);
      var tetheredPrediction = cast(_predictionTether.end, Apparition);
      if (tetheredPerson.subject == tetheredPrediction.subject)
      {
        bringTogether(tetheredPrediction, tetheredPerson);
        _personTether.kill();
        _predictionTether.kill();
      }
    }
  }

  private function introduce(squadron:Squadron):Void
  {
    var maxY = 0.0; // Silly Haxe bug. If this is 0, it can't discern the types for Math.max below.
    squadron.forEach(function(app:Apparition)
    {
      maxY = Math.max(maxY, app.y + app.height);
    });
    squadron.forEach(function(app:Apparition)
    {
      var oldY = app.y;
      app.y -= maxY;
      FlxTween.tween(app, { y: oldY }, 1,
                     { type: FlxTween.ONESHOT, ease: FlxEase.expoOut });
    });
  }

  private function bringTogether(a:Apparition, b:Apparition):Void
  {
    var conveyor = _conveyors.getFirstDead();
    conveyor.start = a;
    conveyor.end = b;
    conveyor.revive();
    var center = new FlxPoint();
    center.x = (a.x + b.x) / 2;
    center.y = (a.y + b.y) / 2;
    var collisionComplete = function(ignored:FlxTween):Void
    {
      a.kill();
      b.kill();
      conveyor.kill();
    };
    FlxTween.tween(a, { x: center.x, y: center.y }, 0.5,
                     { type: FlxTween.ONESHOT, ease: FlxEase.expoIn, complete: collisionComplete });
    FlxTween.tween(b, { x: center.x, y: center.y }, 0.5,
                     { type: FlxTween.ONESHOT, ease: FlxEase.expoIn });
  }
}
