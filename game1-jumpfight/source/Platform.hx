package;

import flixel.FlxG;
import flixel.FlxObject.UP;
import flixel.FlxSprite;
import flixel.util.FlxColor;

// Sprite for a platform
class Platform extends FlxSprite
{
  private var leftSprite:FlxSprite;
  private var rightSprite:FlxSprite;
  private var centerSprite:FlxSprite;

  public function new(start:Float, end:Float, altitude:Float)
  {
    leftSprite = new FlxSprite(0, 0, "assets/images/Platform_L.png");
    centerSprite = new FlxSprite(0, 0, "assets/images/Platform_C.png");
    rightSprite = new FlxSprite(0, 0, "assets/images/Platform_R.png");
    centerSprite.setGraphicSize(Std.int(end - start + 1 - leftSprite.width - rightSprite.width),
                                Std.int(centerSprite.height));
    centerSprite.updateHitbox();

    super(start, altitude - leftSprite.height);

    makeGraphic(Std.int(end - start), Std.int(leftSprite.height), FlxColor.TRANSPARENT);

    moves = false;
    immovable = true;
    allowCollisions = UP;
  }

  override public function draw():Void
  {
    super.draw();

    leftSprite.x = x;
    leftSprite.y = y;
    centerSprite.x = x + leftSprite.width;
    centerSprite.y = y;
    rightSprite.x = x + leftSprite.width + centerSprite.width;
    rightSprite.y = y;

    leftSprite.draw();
    centerSprite.draw();
    rightSprite.draw();
  }
}
