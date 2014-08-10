package;

import flixel.FlxG;
import flixel.FlxState;

class FlightState extends FlxState
{
  private var _player:Player;
  private var _bullets:Bullet.Group;

  override public function create():Void
  {
    super.create();
    FlxG.mouse.load("assets/images/Target.png", 1, -8, -8);
    add(new CrazyBackground());

    _bullets = new Bullet.Group();
    add(_bullets);

    _player = new Player();
    add(_player);

    var conveyor = new Conveyor(_player, FlxG.mouse);
    add(conveyor);
  }

  override public function destroy():Void
  {
    super.destroy();
    FlxG.mouse.load();
  }

  override public function update():Void
  {
    super.update();
    _bullets.forEachAlive(function(bullet:Bullet):Void
    {
      if (bullet.x < -100 || bullet.x > FlxG.width + 100 ||
          bullet.y < -100 || bullet.y > FlxG.height + 100)
      {
        bullet.kill();
      }
    });
  }
}
