package;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;

class Main extends Sprite
{
  inline static var initialState = FlightState;
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
    var gameWidth = Lib.current.stage.stageWidth;
    var gameHeight = Lib.current.stage.stageHeight;

    addChild(new FlxGame(gameWidth, gameHeight, initialState, 1, framerate, framerate));
  }
}
