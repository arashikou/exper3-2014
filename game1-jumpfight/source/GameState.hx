package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxRandom;

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
    FlxG.cameras.useBufferLocking = true;

    player = new Hero();
    maxPlayerX = FlxG.width - Std.int(player.width);
    player.x = maxPlayerX / 2;
    player.y = FlxG.height - 100;
    add(player);

    // Add the floor
    platforms = new FlxTypedGroup<Platform>();
    add(platforms);
    platforms.add(new Platform(0, FlxG.width, 0));

    for (f in 1...6)
    {
      addRandomFloor(70 * f);
    }
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

  private function addRandomFloor(height:Int):Void
  {
    switch (FlxRandom.intRanged(0, 3))
    {
      case 0:
        // One long platform with symmetric gaps at the ends
        var gap = FlxRandom.intRanged(70, 150);
        platforms.add(new Platform(gap, FlxG.width - gap, height));
      case 1:
        // Two platforms, wall-attached
        var gap = FlxRandom.intRanged(140, 300);
        platforms.add(new Platform(0, Std.int((FlxG.width - gap) / 2), height));
        platforms.add(new Platform(Std.int((FlxG.width + gap) / 2), FlxG.width, height));
      case 2:
        // Two platforms, free-floating
        var gap = FlxRandom.intRanged(20, 70);
        platforms.add(new Platform(gap, Std.int((FlxG.width - gap) / 2), height));
        platforms.add(new Platform(Std.int((FlxG.width + gap) / 2), FlxG.width - gap, height));
      case 3:
        // Three platforms, two attached and one floating
        var sideWidth = FlxRandom.intRanged(20, 70);
        var middleWidth = (FlxG.width - sideWidth * 2 - 30) -
                          FlxRandom.intRanged(0, 30);
        platforms.add(new Platform(0, sideWidth, height));
        platforms.add(new Platform(Std.int((FlxG.width - middleWidth) / 2), Std.int((FlxG.width + middleWidth) / 2), height));
        platforms.add(new Platform(FlxG.width - sideWidth, FlxG.width, height));
    }
  }
}
