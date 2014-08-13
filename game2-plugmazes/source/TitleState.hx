package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;

class TitleState extends FlxState
{
  private var _currentLevel:UInt;
  private var _levelDisplay:FlxText;

  public function new(startingLevel:UInt = 1)
  {
    super();
    _currentLevel = startingLevel;
  }

  override public function create():Void
  {
    super.create();
    bgColor = FlxColor.BLACK;

    var leftArrow = new Button("assets/images/LeftArrowButton.png", 30, 60);
    leftArrow.x = FlxG.width / 2 - 100 - leftArrow.width;
    leftArrow.clickCallback = function():Void
    {
      _currentLevel--;
    };
    add(leftArrow);

    var rightArrow = new Button("assets/images/RightArrowButton.png", 30, 60);
    rightArrow.x = FlxG.width / 2 + 100;
    rightArrow.clickCallback = function():Void
    {
      _currentLevel++;
    };
    add(rightArrow);

    var playButton = new TextButton("Play");
    playButton.x = (FlxG.width - playButton.width) / 2;
    playButton.y = (FlxG.height - playButton.height) / 2;
    playButton.clickCallback = function():Void
    {
      FlxG.switchState(new PuzzleState(_currentLevel));
    };
    add(playButton);

    var musicButton = new TextButton("Music Credits");
    musicButton.x = (FlxG.width - musicButton.width) / 2;
    musicButton.y = FlxG.height - musicButton.height;
    musicButton.clickCallback = function():Void
    {
      FlxG.switchState(new MusicCreditsState(_currentLevel));
    };
    add(musicButton);

    _levelDisplay = new FlxText();
    _levelDisplay.size = 36;
    _levelDisplay.font = "external_assets/fonts/NovaMono.ttf";
    _levelDisplay.color = FlxColor.WHEAT;
    add(_levelDisplay);
  }

  override public function update():Void
  {
    super.update();

    if (_currentLevel < 1) _currentLevel = 1;
    if (_currentLevel > 3) _currentLevel = 3;

    _levelDisplay.text = Std.string(_currentLevel);
    _levelDisplay.x = (FlxG.width - _levelDisplay.fieldWidth) / 2;
  }
}
