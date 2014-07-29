package;

import flixel.util.FlxSave;

class SimulationStatus
{
  // Variables that persist betwen days and are saved
  public var mooseCount:UInt;
  public var batteryLevel:UInt;
  public var humanFoodLevel:UInt;
  public var mooseFeedLevel:UInt;
  public var distanceToNextTown:UInt;
  public var nameOfNextTown:String;

  // Variables that only exist during days
  public var moosepower:UInt;

  public function new()
  {
    mooseCount = 5;
    batteryLevel = 5;
    humanFoodLevel = 5;
    mooseFeedLevel = 5;
    distanceToNextTown = 5;
    nameOfNextTown = Constants.getTownName();
    moosepower = 0;
  }

  static public function load(saveData:FlxSave):SimulationStatus
  {
    var version:Int = saveData.data.version;
    var serializedState:String = saveData.data.serializedState;
    return switch (version)
    {
      case 1:
        new SimulationStatus();
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