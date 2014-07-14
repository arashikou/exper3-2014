package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxRandom;

// Gameplay state
class GameState extends FlxState
{
  private var player:Hero;
  private var platforms:FlxTypedGroup<Platform>;
  private var enemies:FlxTypedGroup<Monster>;
  private var powerMeter:FlxText;

  private var highestFloorGenerated:Int;
  private var totalScrollDistance:Float;

  private var maxPlayerX:Float;

  private inline static var FLOOR_SEPARATION = 70;
  private inline static var PLAYER_BOUNDARY = 200;

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

    // Add the power meter
    powerMeter = new FlxText();
    powerMeter.size = 75;
    powerMeter.font = "external_assets/fonts/Anton.ttf";
    powerMeter.text = "000";
    powerMeter.y = 10;
    powerMeter.x = (FlxG.width - powerMeter.fieldWidth) / 2;
    add(powerMeter);

    // Add the floor
    platforms = new FlxTypedGroup<Platform>();
    add(platforms);
    platforms.add(new Platform(0, FlxG.width, FlxG.height));

    // Add the empty enemy list
    enemies = new FlxTypedGroup<Monster>();
    add(enemies);

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

    // Collide enemies with platforms
    FlxG.collide(enemies, platforms);

    // Collide enemies with each other
    FlxG.collide(enemies, enemies);

    // Collide player with enemies
    FlxG.overlap(player, enemies, function(a:Dynamic, b:Dynamic):Void
    {
      var p:Hero = cast a;
      var e:Monster = cast b;
      if (p.power > e.power)
        e.kill();
      else if (p.power < e.power)
        p.kill();
      else
        FlxObject.separate(a, b);
    });

    // Bound player on horizontal screen edges
    if (player.x < 0) player.x = 0;
    else if (player.x > maxPlayerX) player.x = maxPlayerX;

    // Scroll if player nears top of screen
    if (player.y < PLAYER_BOUNDARY)
    {
      var scrollDistance = PLAYER_BOUNDARY - player.y;
      totalScrollDistance += scrollDistance;

      function addScrollDistance(o:FlxObject):Void
      {
        o.y += scrollDistance;
      }
      player.y += scrollDistance;
      platforms.forEach(addScrollDistance);
      enemies.forEach(addScrollDistance);
    }

    // Generate new platforms if needed
    var heightSeen = totalScrollDistance + FlxG.height;
    while (highestFloorGenerated * FLOOR_SEPARATION < heightSeen)
    {
      highestFloorGenerated++;
      addRandomFloor(highestFloorGenerated);
    }

    // Update the power meter
    powerMeter.text = StringTools.lpad(Std.string(player.power), "0", 3);
    powerMeter.x = (FlxG.width - powerMeter.fieldWidth) / 2;
  }

  private function addRandomFloor(floorNumber:Int):Void
  {
    var worldHeight = FlxG.height - (floorNumber * FLOOR_SEPARATION);
    var currentHeight = worldHeight + totalScrollDistance;
    addRandomPlatforms(currentHeight);

    var monster = new Monster(FlxRandom.intRanged(0, 2));
    monster.x = (FlxG.width - monster.width) / 2;
    monster.y = currentHeight - monster.width - 5;
    enemies.add(monster);
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
