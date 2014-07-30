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

  static public var hunt = new Event(
    function(status:SimulationStatus):String
    {
      if (status.moosepower == 0)
        return "You have no moosepower left to use for hunting.";
      else
      {
        var increase = FlxRandom.intRanged(2, 5);
        status.humanFoodLevel += increase;
        status.moosepower--;
        return "Your moose brings back " + increase + " Meals worth of human food!";
      }
    }
  );

  static public var uneventfulTravel = new Event(
    function(status:SimulationStatus):String
    {
      if (status.moosepower == 0)
        return "You have no moosepower left to travel on.";
      else
      {
        status.distanceToNextTown--;
        status.moosepower--;
        return "Your herd moseys on down the trail for another kilometer.";
      }
    }
  );
}
