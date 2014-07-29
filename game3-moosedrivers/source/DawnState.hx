package;

import flixel.FlxState;
import flixel.util.FlxSave;

class DawnState extends FlxState
{
  private var _status:SimulationStatus;

  public function new(status:SimulationStatus)
  {
    super();
    _status = status;
  }

  override public function create():Void
  {
    var saveData = new FlxSave();
    saveData.bind(Constants.saveName);
    _status.save(saveData);
    saveData.close();
  }
}
