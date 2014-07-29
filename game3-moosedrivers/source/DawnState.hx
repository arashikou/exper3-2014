package;

import flixel.util.FlxSave;

class DawnState extends SimulationState
{
  override public function create():Void
  {
    var saveData = new FlxSave();
    saveData.bind(Constants.saveName);
    _status.save(saveData);
    saveData.close();
  }
}
