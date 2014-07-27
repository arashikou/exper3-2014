package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MusicCreditsState extends FlxState
{
  private var _puzzleMemory:UInt;

  static private var CREDIT_TEXT = StringTools.replace(
'This game uses the following musical tracks:

"Dubstep Light" by Jason Shaw
Available at audionautix.com
Used under CC BY license http://creativecommons.org/licenses/by/3.0/

"Late Nigtht Tribe" by earritation featuring mactonite and Darkroom
Available at ccMixter.org http://ccmixter.org/files/earritation/46736
Used under CC BY-NC license http://creativecommons.org/licenses/by-nc/3.0/

"Space Jazz" by Martijn de Boer (NiGiD) featuring Doxent Zsigmond (doxent)
Available at ccMixter.org http://ccmixter.org/files/NiGiD/46628
Used under CC BY license http://creativecommons.org/licenses/by/3.0/

This game also uses the following sound effects:

"Start the Machine" by parabolix http://www.freesound.org/people/parabolix/
Used under CC BY license http://creativecommons.org/licenses/by/3.0/',
      "\r\n", "\n");

  public function new(puzzleMemory:UInt)
  {
    super();
    _puzzleMemory = puzzleMemory;
  }

  override public function create():Void
  {
    super.create();

    var credits = new FlxText();
    credits.size = 18;
    credits.font = "external_assets/fonts/NovaMono.ttf";
    credits.color = FlxColor.WHITE;
    credits.text = CREDIT_TEXT;
    credits.y = 25;
    add(credits);

    var button = new TextButton("Return to Title");
    button.clickCallback = function():Void
    {
      FlxG.switchState(new TitleState(_puzzleMemory));
    };
    button.x = (FlxG.width - button.width) / 2;
    button.y = FlxG.height - button.height;
    add(button);
    BackgroundMusic.play();
  }
}