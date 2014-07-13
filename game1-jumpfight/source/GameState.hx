package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;

// Gameplay state
class GameState extends FlxState
{
  var player:Hero;

  var world:FlxGroup;
  var platforms:FlxTypedGroup<Platform>;
  var walls:FlxTypedGroup<Wall>;

  override public function create():Void
  {
    super.create();

    FlxG.cameras.useBufferLocking = true;

    player = new Hero();
    player.x = (FlxG.width - player.width) / 2;
    player.y = (FlxG.height - player.height) / 2;
    add(player);

    platforms = new FlxTypedGroup<Platform>();
    var floor = new Platform(FlxG.width);
    floor.y = FlxG.height - 10;
    platforms.add(floor);

    walls = new FlxTypedGroup<Wall>(2);
    var leftWall = new Wall();
    leftWall.x = 0;
    walls.add(leftWall);
    var rightWall = new Wall();
    rightWall.x = FlxG.width - rightWall.width;
    walls.add(rightWall);

    world = new FlxGroup();
    world.add(platforms);
    world.add(walls);
    add(world);
  }

  override public function update():Void
  {
    super.update();
    FlxG.collide(player, world);
  }
}