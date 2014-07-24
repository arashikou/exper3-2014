package;

import openfl.Assets;

class PuzzleParser
{
  static public function parse(level:Int, state:PuzzleState):Void
  {
    var assetName = "assets/levels/" + level + ".txt";
    var asset = Assets.getText(assetName);
    asset = StringTools.replace(asset, "\r\n", "\n");
    var lines = asset.split("\n");

    var regex;

    regex = ~/^([0-9]+), +([0-9]+)$/;
    if (!regex.match(lines[0]))
    {
      throw "Invalid dimensions row.";
    }
    var w = Std.parseInt(regex.matched(1));
    var h = Std.parseInt(regex.matched(2));
    state.setDimensions(w, h);

    if (!regex.match(lines[1]))
    {
      throw "Invalid outlet row.";
    }
    var outletX = Std.parseInt(regex.matched(1));
    var outletY = Std.parseInt(regex.matched(2));
    state.setOutlet(outletX, outletY);

    regex = ~/^ *([0-9]+) +([0-9]+), +([0-9]+) +([A-Za-z]+) +(!?)$/;
    for (index in 2...lines.length)
    {
      if (!regex.match(lines[index]))
      {
        throw "Invalid cable row.";
      }
      var maxLength = Std.parseInt(regex.matched(1));
      var cableX = Std.parseInt(regex.matched(2));
      var cableY = Std.parseInt(regex.matched(3));
      var direction = Direction.parse(regex.matched(4));
      var isPowered = (regex.matched(5) == "!");
      state.addCable(cableX, cableY, direction, maxLength, isPowered);
    }
  }
}
