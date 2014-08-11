package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class Player extends FlxSprite
{
  public var heart(default,null):FlxSprite;

  inline static private var LOW_SPEED = 100;
  inline static private var HIGH_SPEED = 400;

  public function new()
  {
    super("assets/images/CrystalBall.png");
    y = FlxG.height - height - 20;
    x = (FlxG.width - width) / 2;
    heart = new FlxSprite();
    heart.makeGraphic(2, 2, FlxColor.RED);
  }

  override public function update():Void
  {
    super.update();

    var xMove = 0;
    if (FlxG.keys.pressed.D) xMove += 1;
    if (FlxG.keys.pressed.A) xMove -= 1;
    var yMove = 0;
    if (FlxG.keys.pressed.S) yMove += 1;
    if (FlxG.keys.pressed.W) yMove -= 1;
    var speed = FlxG.keys.pressed.SHIFT ? LOW_SPEED : HIGH_SPEED;
    x += xMove * FlxG.elapsed * speed;
    y += yMove * FlxG.elapsed * speed;
    bound();

    heart.x = x + (width - heart.width) / 2;
    heart.y = y + (height - heart.height) / 2;
    heart.update();
  }

  override public function draw():Void
  {
    super.draw();
    heart.draw();
  }
}
