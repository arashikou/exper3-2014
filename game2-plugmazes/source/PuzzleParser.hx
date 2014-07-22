package;

import openfl.Assets;

class PuzzleParser
{
	static public function parse(level:Int):String
	{
		var assetName = "assets/levels/" + level + ".txt";
		var asset = Assets.getText(assetName);
		return asset;
	}
}
