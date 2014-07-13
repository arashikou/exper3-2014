package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;

// Gameplay state
class GameState extends FlxState
{
  var player:Hero;
  var floor:Platform;
  var walls:FlxTypedGroup<Wall>;

  override public function create():Void
  {
    super.create();

    player = new Hero();
    player.x = (FlxG.width - player.width) / 2;
    player.y = (FlxG.height - player.height) / 2;
    add(player);

    floor = new Platform(FlxG.width);
    floor.y = FlxG.height - 10;
    add(floor);

    walls = new FlxTypedGroup<Wall>(2);
    var leftWall = new Wall();
    leftWall.x = 0;
    walls.add(leftWall);
    var rightWall = new Wall();
    rightWall.x = FlxG.width - rightWall.width;
    walls.add(rightWall);
    add(walls);
  }

  override public function update():Void
  {
    super.update();

    FlxG.collide(player, floor);
    FlxG.collide(player, walls);
  }
}