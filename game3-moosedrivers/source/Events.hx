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

  static public function travel(status:SimulationStatus):EventResult
  {
    if (status.moosepower == 0)
      return new EventResult("You have no moosepower left to travel on.");
    else
    {
      status.moosepower--;
      var continuance =
        if (FlxRandom.chanceRoll(25))
          // We have to use this instead of getObject because Haxe can't handle
          // arrays of function pointers apparently. (WTF?)
          switch (FlxRandom.intRanged(0, 1))
          {
            case 0: favorableTravel;
            case 1: riverTravel;
            default: throw "Impossible!";
          }
        else
          uneventfulTravel;
      return new EventResult(
        "Your herd moseys on down the trail.",
        [ new Option("And then...", continuance) ]);
    }
  }

  static public function uneventfulTravel(status:SimulationStatus):EventResult
  {
    status.distanceToNextTown--;
    return new EventResult("You pause after another kilometer has passed.");
  }

  static public function favorableTravel(status:SimulationStatus):EventResult
  {
    status.distanceToNextTown--;
    if (status.distanceToNextTown > 0) status.distanceToNextTown--;
    return new EventResult("The road is easy, and you travel two kilometers on just one moosepower.");
  }

  static public function riverTravel(status:SimulationStatus):EventResult
  {
    return
      if (status.moosepower == 0)
        new EventResult(
          "You come upon a river! The waters are swift and deep. Perhaps you should turn back?",
          [
            new Option("Ford Here", crossRiverDangerous),
            new Option("Turn Back", abandonRiverCrossing)
          ]);
      else
        new EventResult(
          "You come upon a river! The waters are swift and deep. For an extra moosepower, you can search for a better crossing.",
          [
            new Option("Ford Here", crossRiverDangerous),
            new Option("Search for Better", crossRiverSafe)
          ]);
  }

  static public function crossRiverDangerous(status:SimulationStatus):EventResult
  {
    status.distanceToNextTown--;
    return new EventResult(
      switch (FlxRandom.weightedPick([150, 100, 100, 100, 30, 30]))
      {
        case 0:
          "Thanks to your good driving, you make it safely across.";
        case 1:
          status.batteryLevel--;
          "A battery shorts out in the crossing, and you lose 1 Energy, but you make it across.";
        case 2:
          status.humanFoodLevel--;
          "The water spoils 1 Meal's worth of food, but you make it across.";
        case 3:
          status.mooseFeedLevel--;
          "The water spoils 1 Sachet of feed, but you make it across.";
        case 4:
          status.mooseCount--;
          "A moose is swept away in the raging waters! Saddened but thankful, the rest of the herd makes it safely across.";
        case 5:
          status.driverCount--;
          "With a yelp, one of the drivers falls in and disappears! Saddened but thankful, the rest of the herd makes it safely across.";
        default:
          throw "Impossible!";
      });
  }

  static public function crossRiverSafe(status:SimulationStatus):EventResult
  {
    status.moosepower--;
    status.distanceToNextTown--;
    return new EventResult("About half a kilometer downstream, you find a shallows and cross.");
  }

  static public function abandonRiverCrossing(status:SimulationStatus):EventResult
  {
    return new EventResult("Saddened at the waste of your last moosepower, you turn the herd around and return to your previous campsite.");
  }
}
