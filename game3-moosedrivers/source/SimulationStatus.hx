package;

import flixel.util.FlxSave;

class SimulationStatus
{
  // Variables that persist betwen days and are saved
  public var mooseCount:UInt;
  public var driverCount:UInt;
  public var batteryLevel:UInt;
  public var humanFoodLevel:UInt;
  public var mooseFeedLevel:UInt;
  public var money:UInt;
  public var distanceToNextTown:UInt;
  public var nameOfNextTown:String;

  // Variables that only exist during days
  public var moosepower:UInt;

  // Variables that are derived
  public var neededFood(get, never):UInt;
  public var neededFeed(get, never):UInt;
  public var neededEnergy(get, never):UInt;
  public var moneyWholePortion(get, never):UInt;
  public var moneyHundredthsPortion(get, never):UInt;
  public var moneyString(get, never):String;

  public function new()
  {
    mooseCount = 5;
    driverCount = 2;
    batteryLevel = 24;
    humanFoodLevel = 4;
    mooseFeedLevel = 15;
    money = 10000;
    distanceToNextTown = 11;
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

  public function get_neededFood():UInt
  {
    return driverCount;
  }

  public function get_neededFeed():UInt
  {
    return mooseCount;
  }

  public function get_neededEnergy():UInt
  {
    return driverCount * 2 + mooseCount;
  }

  public function get_moneyWholePortion():UInt
  {
    return Std.int(money / 100);
  }

  public function get_moneyHundredthsPortion():UInt
  {
    return money % 100;
  }

  public function get_moneyString():String
  {
    var hundredths = StringTools.lpad(Std.string(moneyHundredthsPortion), "0", 2);
    return "$" + moneyWholePortion + "." + hundredths;
  }
}