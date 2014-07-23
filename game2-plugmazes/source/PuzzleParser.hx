package;

import openfl.Assets;

class PuzzleParser
{
  static public function parse(level:Int, state:PuzzleState):Void
  {
    var assetName = "assets/levels/" + level + ".txt";
    var asset = Assets.getText(assetName);

    state.setDimensions(5, 5);
    state.setOutlet(1, 1);
  }
}
