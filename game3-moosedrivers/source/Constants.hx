package;

import flixel.util.FlxRandom;

class Constants
{
  inline static public var saveName = "the-only-save";

  static public var townNames = [
    "Ottawa",
    "Vancouver",
    "Calgary",
    "Winnipeg",
    "Regina",
    "St. John's",
    "Istanbul",
    "Chicago",
    "Milwaukee",
    "New York City",
    "Tucson",
    "Beijing"
  ];

  static public function getTownName(?omissionList:Array<String>)
  {
    if (omissionList == null) omissionList = [];
    var res = "";
    do
    {
        res = FlxRandom.getObject(townNames);
    }
    while (omissionList.indexOf(res) != -1);
    return res;
  }
}