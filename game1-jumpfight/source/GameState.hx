package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxRandom;

// Gameplay state
class GameState extends FlxState
{
  private var player:Hero;
  private var platforms:FlxTypedGroup<Platform>;

  private var maxPlayerX:Int;

  override public function create():Void
  {
    super.create();

    // Set up camera
    FlxG.cameras.useBufferLocking = true;

    player = new Hero();
    maxPlayerX = FlxG.width - Std.int(player.width);
    player.x = maxPlayerX / 2;
    player.y = FlxG.height - player.height - 10;
    add(player);

    // Add the floor
    platforms = new FlxTypedGroup<Platform>();
    add(platforms);
    platforms.add(new Platform(0, FlxG.width, 0));

    for (f in 1...7)
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
    var isPlatform = [true, true, true, true, true, true, true, true];
    var increment = Std.int(FlxG.width / isPlatform.length);
    for (i in 0...4)
    {
      // Yes, this may repeat the same segment. That's expected.
      isPlatform[FlxRandom.intRanged(0, isPlatform.length - 1)] = false;
    }
    // Parse the isPlatform array into platform objects
    var start = 0;
    while (start < isPlatform.length)
    {
      if (isPlatform[start])
      {
        var end = start + 1;
        while (end < isPlatform.length && isPlatform[end]) end++;
        platforms.add(new Platform(start * increment,
                                   end * increment,
                                   height));
        start = end;
      }
      else
      {
        start++;
      }
    }
  }
}
