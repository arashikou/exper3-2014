package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class TitleState extends FlxState
{
  override public function create():Void
  {
    super.create();

    var leftArrow = new Button("assets/images/LeftArrowButton.png", 30, 60);
    leftArrow.x = FlxG.width / 2 - 50 - leftArrow.width;
    add(leftArrow);

    var rightArrow = new Button("assets/images/RightArrowButton.png", 30, 60);
    rightArrow.x = FlxG.width / 2 + 50;
    add(rightArrow);

    var playButton = new TextButton("Play");
    playButton.x = (FlxG.width - playButton.width) / 2;
    playButton.y = (FlxG.height - playButton.height) / 2;
    playButton.clickCallback = function():Void
    {
      FlxG.switchState(new PuzzleState(2));
    };
    add(playButton);

    var musicButton = new TextButton("Music Credits");
    musicButton.x = (FlxG.width - musicButton.width) / 2;
    musicButton.y = FlxG.height - musicButton.height;
    musicButton.clickCallback = function():Void
    {
      FlxG.switchState(new MusicCreditsState());
    };
    add(musicButton);
  }

  override public function destroy():Void
  {
    super.destroy();
  }

  override public function update():Void
  {
    super.update();
  }
}