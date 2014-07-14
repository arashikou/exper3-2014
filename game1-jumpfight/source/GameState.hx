package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxRandom;

// Gameplay state
class GameState extends FlxState
{
  private var player:Hero;
  private var platforms:FlxTypedGroup<Platform>;

  private var highestFloorGenerated:Int;
  private var totalScrollDistance:Float;

  private var maxPlayerX:Float;

  private inline static var FLOOR_SEPARATION = 70;
  private inline static var PLAYER_BOUNDARY = 100;

  override public function create():Void
  {
    super.create();

    // Set up camera
    FlxG.cameras.useBufferLocking = true;

    // Add the player character
    player = new Hero();
    maxPlayerX = FlxG.width - player.width;
    player.x = maxPlayerX / 2;
    player.y = FlxG.height - player.height - 10;
    add(player);

    // Add the floor
    platforms = new FlxTypedGroup<Platform>();
    add(platforms);
    platforms.add(new Platform(0, FlxG.width, FlxG.height));

    // Initialize floor generation
    highestFloorGenerated = 0;
    totalScrollDistance = 0;
  }

  override public function update():Void
  {
    super.update();

    // Collide player with platforms
    if (FlxG.collide(player, platforms))
    {
      player.isOnFloor = true;
    }

    // Bound player on horizontal screen edges
    if (player.x < 0) player.x = 0;
    if (player.x > maxPlayerX) player.x = maxPlayerX;

    // Scroll if player nears top of screen
    if (player.y < PLAYER_BOUNDARY)
    {
      var scrollDistance = PLAYER_BOUNDARY - player.y;
      totalScrollDistance += scrollDistance;
      player.y += scrollDistance;

      function addScrollDistance(o:FlxObject):Void
      {
        o.y += scrollDistance;
      }
      platforms.forEach(addScrollDistance);
    }

    // Generate new platforms if needed
    var heightSeen = totalScrollDistance + FlxG.height;
    while (highestFloorGenerated * FLOOR_SEPARATION < heightSeen)
    {
      highestFloorGenerated++;
      addRandomFloor(highestFloorGenerated);
    }
  }

  private function addRandomFloor(floorNumber:Int):Void
  {
    var worldHeight = FlxG.height - (floorNumber * FLOOR_SEPARATION);
    var currentHeight = worldHeight + totalScrollDistance;
    addRandomPlatforms(currentHeight);
  }

  private function addRandomPlatforms(height:Float):Void
  {
    var isPlatform = [true, true, true, true, true, true, true, true];
    var increment = Std.int(FlxG.width / isPlatform.length);
    for (i in 0...4)
    {
      // Yes, this may repeat the same segment. That's intended.
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
