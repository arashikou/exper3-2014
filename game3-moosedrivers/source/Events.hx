package;

import flixel.util.FlxRandom;

import Event.EventResult;
import Event.Option;

class Events
{
  static public function moosercycle(status:SimulationStatus):EventResult
  {
    if (status.moosepower == 0)
      return new EventResult("You have no moosepower left to run the moosercycle.");
    else
    {
      var increase = FlxRandom.weightedPick([3, 1]) + 1;
      status.batteryLevel += increase;
      status.moosepower--;
      return new EventResult("Your moose generated " + increase + " Energy!");
    }
  }

  static public function hunt(status:SimulationStatus):EventResult
  {
    if (status.moosepower == 0)
      return new EventResult("You have no moosepower left to use for hunting.");
    else
    {
      var increase = FlxRandom.intRanged(2, 5);
      status.humanFoodLevel += increase;
      status.moosepower--;
      return new EventResult("Your moose brings back " + increase + " Meals worth of human food!");
    }
  }

  static public function uneventfulTravel(status:SimulationStatus):EventResult
  {
    if (status.moosepower == 0)
      return new EventResult("You have no moosepower left to travel on.");
    else
    {
      status.distanceToNextTown--;
      status.moosepower--;
      return new EventResult("Your herd moseys on down the trail for another kilometer.");
    }
  };
}
