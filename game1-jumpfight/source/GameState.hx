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
  var walls:FlxTypedGroup<Wall>;

  override public function create():Void
  {
    super.create();

    // Set up camera
    // Note that the game world starts at 0 and values become increasingly
    // negative over time.
    FlxG.cameras.useBufferLocking = true;
    FlxG.camera.scroll.y = -FlxG.height;

    player = new Hero();
    player.x = (FlxG.width - player.width) / 2;
    player.y = (FlxG.height - player.height) / 2;
    add(player);

    platforms = new FlxTypedGroup<Platform>();
    add(platforms);
    walls = new FlxTypedGroup<Wall>(2);
    add(walls);

    // Add the floor
    platforms.add(new Platform(0, FlxG.width, FlxG.height - 10));

    // Add the left and right walls
    walls.add(new Wall(0));
    walls.add(new Wall(FlxG.width - Wall.WIDTH));
  }

  override public function update():Void
  {
    super.update();

    FlxG.collide(player, walls);
    if (FlxG.collide(player, platforms))
    {
      player.isOnFloor = true;
    }
  }
}
