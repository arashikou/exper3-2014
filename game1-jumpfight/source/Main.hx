package;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;

class Main extends Sprite
{
  var initialState:Class<FlxState> = MenuState; // The FlxState the game starts with.

  var zoom:Float = -1; // If -1, zoom, gameWidth, and gameHeight are automatically calculated to fit the window dimensions.
  var gameWidth:Int = 640; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
  var gameHeight:Int = 480; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
  var framerate:Int = 60; // How many frames per second the game should run at.

  // You can pretty much ignore everything from here on - your code should go in your states.

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
    if (zoom == -1)
    {
      var stageWidth:Int = Lib.current.stage.stageWidth;
      var stageHeight:Int = Lib.current.stage.stageHeight;
      var ratioX:Float = stageWidth / gameWidth;
      var ratioY:Float = stageHeight / gameHeight;
      zoom = Math.min(ratioX, ratioY);
      gameWidth = Math.ceil(stageWidth / zoom);
      gameHeight = Math.ceil(stageHeight / zoom);
    }

    addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate));
  }
}