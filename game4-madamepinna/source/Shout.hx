package;

import Apparition.Subject;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;

class Shout extends FlxSprite
{
  private var _text:FlxText;

  public function new()
  {
    super();

    makeGraphic(FlxG.width, 84, FlxColor.BLACK);
    alpha = 0.5;
    x = 0;
    y = FlxG.height - height;

    _text = new FlxText();
    _text.font = "external_assets/fonts/Alice.ttf";
    _text.size = 32;
    _text.x = x + 10;
    _text.y = y;
    _text.fieldWidth = FlxG.width - 20;
    _text.wordWrap = true;
    _text.alignment = "center";

    kill();
  }

  public function randomize(subject:Subject):Void
  {
    _text.text = getQuip(subject);
  }

  override public function draw():Void
  {
    super.draw();
    _text.draw();
  }

  static private function getQuip(subject:Subject):String
  {
    return FlxRandom.getObject(switch (subject)
    {
      case Red:
        [
          "Your boyfriend is cheating on you.",
          "Your boss is embezzling money.",
          "You only have four years left with your mother.",
          "Uncle Herbert never really loved you.",
          "Your father is trapped in a fortune cookie factory.",
          "There are dark days ahead.",
          "The future is bright.",
          "You will eat your last peach too angry to enjoy it.",
          "There is Nazi gold buried somewhere on your property.",
          "You will come into great fortune within a year.",
          "You will lose all your hair by age 40.",
          "Your favorite pink socks are behind the dryer sheets."
        ];
      case Blue:
        [
          "It's time to get over your childhood pet's death.",
          "Time and determination overcome all obstacles.",
          "A smile is the best compliment you can give.",
          "Love is given, sometimes stolen, but never taken.",
          "You have great potential. You have only to awaken it.",
          "Seeking worldly pleasures distracts from the truth.",
          "Sorrows are transient, but they shape us forever.",
          "No one is loved all the time.",
          "Those who see only themselves lose all others.",
          "Tranquility is a skill that must be practiced.",
          "We mine memories for the diamonds of experience."
        ];
      case Green:
        [
          "Next Tuesday, give exactly $3.50 to the blind beggar.",
          "Wear mismatched socks on all days beginning with S.",
          "Give away all your coins with odd values.",
          "Spend two hours every week meditating on sardines.",
          "Stepping on ants will lead to an early death.",
          "For good luck, own cats with exactly 144 total stripes.",
          "One of the winning lottery numbers is 45.",
          "One of the winning lottery numbers is 51.",
          "One of the winning lottery numbers is 16.",
          "One of the winning lottery numbers is 8.",
          "Answer cloudy. Ask again later."
        ];
    });
  }
}
