package;

import openfl.Assets;

class PuzzleParser
{
  static public function parse(level:Int):PuzzleState
  {
    var assetName = "assets/levels/" + level + ".txt";
    var asset = Assets.getText(assetName);

    var state = new PuzzleState(5, 5);
    state.setOutlet(1, 1);
    return state;
  }
}
