package;

import flixel.util.FlxSave;

class GameState
{
  public function new()
  {
  }

  static public function load(saveData:FlxSave):GameState
  {
    var version:Int = saveData.data.version;
    var serializedState:String = saveData.data.serializedState;
    return switch (version)
    {
      case 1:
        new GameState();
      default:
        throw "Unrecognized Save Version";
    }
  }

  public function save(saveData:FlxSave):Void
  {
    saveData.data.version = 1;
    saveData.data.serializedState = "";
  }
}