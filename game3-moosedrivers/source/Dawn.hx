package;

import flixel.FlxState;
import flixel.util.FlxSave;

class Dawn extends FlxState
{
  private var _state:GameState;

  public function new(state:GameState)
  {
    super();
    _state = state;
  }

  override public function create():Void
  {
    var saveData = new FlxSave();
    saveData.bind(Constants.saveName);
    _state.save(saveData);
    saveData.close();
  }
}
