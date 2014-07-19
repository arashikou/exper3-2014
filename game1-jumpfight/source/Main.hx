package;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;

class Main extends Sprite
{
  // Game Settings
  inline static var initialState = TitleState;
  inline static var zoom = 2;
  inline static var framerate = 60;

  // Based on the code from the default template in HaxeFlixel
  public function new()
  {
    super();

    if (stage != null)
    {
      init();
    }
    else
    {
      addEventListener(Event.ADDED_TO_STAGE, init);
    }
  }

  private function init(?E:Event):Void
  {
    if (hasEventListener(Event.ADDED_TO_STAGE))
    {
      removeEventListener(Event.ADDED_TO_STAGE, init);
    }

    setupGame();
  }

  private function setupGame():Void
  {
    var stageWidth = Lib.current.stage.stageWidth;
    var stageHeight = Lib.current.stage.stageHeight;
    var gameWidth = Math.floor(stageWidth / zoom);
    var gameHeight = Math.floor(stageHeight / zoom);

    addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate));
  }
}