package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MusicCreditsState extends FlxState
{
  private var credits:FlxText;

  static inline private var CREDIT_TEXT =
"Music \"Dubstep Light\" by Jason Shaw
Available at audionautix.com
Under CC BY license http://creativecommons.org/licenses/by/3.0/

Music \"Late Nigtht Tribe\" by earritation featuring mactonite and Darkroom
Available at ccMixter.org http://ccmixter.org/files/earritation/46736
Under CC BY-NC license http://creativecommons.org/licenses/by-nc/3.0/

Music \"Space Jazz\" by Martijn de Boer (NiGiD) featuring Doxent Zsigmond (doxent)
Available at ccMixter.org http://ccmixter.org/files/NiGiD/46628
Under CC BY license http://creativecommons.org/licenses/by/3.0/";

  override public function create():Void
  {
    super.create();

    credits = new FlxText();
    credits.size = 18;
    credits.font = "external_assets/fonts/NovaMono.ttf";
    credits.color = FlxColor.WHITE;
    credits.text = CREDIT_TEXT;
    credits.y = 25;
    add(credits);

    var button = new TextButton("Return to Title");
    button.clickCallback = function():Void
    {
      FlxG.switchState(new MenuState());
    };
    button.x = (FlxG.width - button.width) / 2;
    button.y = FlxG.height - button.height;
    add(button);
    BackgroundMusic.play();
  }
}