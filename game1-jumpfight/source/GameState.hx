package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;

// Gameplay state
class GameState extends FlxState
{
  var player:Hero;

  var platforms:FlxTypedGroup<Platform>;

  var maxPlayerX:Int;

  override public function create():Void
  {
    super.create();

    // Set up camera
    // Note that the game world starts at 0 and values become increasingly
    // negative over time.
    FlxG.cameras.useBufferLocking = true;
    FlxG.camera.scroll.y = -FlxG.height;

    player = new Hero();
    maxPlayerX = Std.int(FlxG.width - player.width);
    player.x = maxPlayerX / 2;
    player.y = -100;
    add(player);

    // Add the floor
    platforms = new FlxTypedGroup<Platform>();
    add(platforms);
    platforms.add(new Platform(0, FlxG.width, 0));
  }

  override public function update():Void
  {
    super.update();

    if (FlxG.collide(player, platforms))
    {
      player.isOnFloor = true;
    }

    if (player.x < 0) player.x = 0;
    if (player.x > maxPlayerX) player.x = maxPlayerX;
  }
}
