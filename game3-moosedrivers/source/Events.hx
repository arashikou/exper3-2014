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
      var increase = FlxRandom.weightedPick([9, 3, 3, 1]) + 4;
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

  static private var postTravelOptions = [ new Option("Continue", postTravel) ];

  static public function uneventfulTravel(status:SimulationStatus):EventResult
  {
    status.distanceToNextTown--;
    return new EventResult("You pause after another kilometer has passed.", postTravelOptions);
  }

  static public function favorableTravel(status:SimulationStatus):EventResult
  {
    status.distanceToNextTown--;
    if (status.distanceToNextTown > 0) status.distanceToNextTown--;
    return new EventResult("The road is easy, and you travel two kilometers on just one moosepower.", postTravelOptions);
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
      },
      postTravelOptions);
  }

  static public function crossRiverSafe(status:SimulationStatus):EventResult
  {
    status.moosepower--;
    status.distanceToNextTown--;
    return new EventResult("About half a kilometer downstream, you find a shallows and cross.", postTravelOptions);
  }

  static public function abandonRiverCrossing(status:SimulationStatus):EventResult
  {
    return new EventResult("Saddened at the waste of your last moosepower, you turn the herd around and return to your previous rest site.");
  }

  static public function postTravel(status:SimulationStatus):EventResult
  {
    if (status.distanceToNextTown == 0)
    {
      var oldDestination = status.nameOfNextTown;
      var amount = Std.int(FlxRandom.floatRanged(3, 6) * status.mooseCount);
      status.mooseFeedLevel += amount;
      status.nameOfNextTown = Constants.getTownName([status.nameOfNextTown]);
      status.distanceToNextTown = Std.int(FlxRandom.floatRanged(3, 5) * status.mooseCount);
      return new EventResult(
        "Congratulations! You made it to " + oldDestination +
        "! The grateful townsfolk offer you " + amount +
        " Sachets of moose feed as a reward for your hard work! Now on to " +
        status.nameOfNextTown + "!");
    }
    else
    {
      return new EventResult("You stop to rest.");
    }
  }

  static public function night(status:SimulationStatus):EventResult
  {
    var message = "You make camp for the night.";

    // Check Food Levels
    if (status.humanFoodLevel > status.neededFood)
    {
      status.humanFoodLevel -= status.neededFood;
      message += " You eat heartily.";
    }
    else
    {
      var atRisk = status.neededFood - status.humanFoodLevel;
      status.humanFoodLevel = 0;
      var deathToll = 0;
      for (i in 0...atRisk)
      {
        if (FlxRandom.chanceRoll(50)) deathToll++;
      }
      status.driverCount -= deathToll;
      message += " There is not enough food to go around";
      if (deathToll == 1)
      {
        message += ", and a driver dies of starvation in his bedroll.";
      }
      else if (deathToll > 0)
      {
        message += ". " + deathToll + " drivers die of starvation.";
      }
      else
      {
        message += ".";
      }
    }

    // Check Feed Levels
    if (status.mooseFeedLevel > status.neededFeed)
    {
      status.mooseFeedLevel -= status.neededFeed;
      message += " The moose are well-fed.";
    }
    else
    {
      var atRisk = status.neededFeed - status.mooseFeedLevel;
      status.mooseFeedLevel = 0;
      var deathToll = 0;
      for (i in 0...atRisk)
      {
        if (FlxRandom.chanceRoll(50)) deathToll++;
      }
      status.mooseCount -= deathToll;
      message += " There is not enough moose feed for the entire herd";
      if (deathToll == 1)
      {
        message += ". In the morning, you find one has died.";
      }
      else if (deathToll > 0)
      {
        message += ", and " + deathToll + " moose die in the night.";
      }
      else
      {
        message += ".";
      }
    }

    // Check Energy Levels
    if (status.batteryLevel > status.neededEnergy)
    {
      status.batteryLevel -= status.neededEnergy;
    }
    else
    {
      if (status.batteryLevel == 0)
      {
        message += " The batteries remain empty.";
      }
      else
      {
        message += " The batteries run dry.";
      }
      status.batteryLevel = 0;
      message += " The mood in the camp is sour. Both moose and driver grumble over lost comforts.";
      // TODO: Add consequences for not enough energy.
    }

    return new EventResult(message, [new Option("Continue", DawnState)]);
  }
}
