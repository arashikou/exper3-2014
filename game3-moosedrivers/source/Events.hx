package;

import flixel.util.FlxRandom;

class Events
{
  static public var moosercycle = new Event(
    function(status:SimulationStatus):String
    {
      if (status.moosepower == 0)
        return "You have no moosepower left to run the moosercycle.";
      else
      {
        var increase = FlxRandom.weightedPick([3, 1]) + 1;
        status.batteryLevel += increase;
        status.moosepower--;
        return "Your moose generated " + increase + " Energy!";
      }
    }
  );
}