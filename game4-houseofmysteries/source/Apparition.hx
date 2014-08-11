package;

import flixel.FlxSprite;
import flixel.util.FlxRandom;

enum Form
{
  Person;
  Prediction;
}

enum Subject
{
  Red;
  Green;
  Blue;
}

class Apparition extends FlxSprite
{
  public var form(default,null):Form;
  public var subject(default,null):Subject;

  public function new(vSubject:Subject, vForm:Form)
  {
    super();
    loadGraphic("assets/images/Apparitions.png", true, 32, 32);
    animation.add("Person-Green", [0]);
    animation.add("Person-Red", [1]);
    animation.add("Person-Blue", [2]);
    animation.add("Prediction-Green", [3]);
    animation.add("Prediction-Red", [4]);
    animation.add("Prediction-Blue", [5]);
    form = vForm;
    subject = vSubject;

    var formName = switch(form)
    {
      case Person:
        "Person";
      case Prediction:
        "Prediction";
    };
    var subjectName = switch(subject)
    {
      case Red:
        "Red";
      case Green:
        "Green";
      case Blue:
        "Blue";
    };
    animation.play('${formName}-${subjectName}');
  }
}

class Random
{
  static public function form(?forbidden:Null<Form>):Form
  {
    return switch (forbidden)
    {
      case Person:
        Prediction;
      case Prediction:
        Person;
      case null:
        FlxRandom.chanceRoll(50) ? Person : Prediction;
    };
  }

  static public function subject(?forbidden:Null<Subject>):Subject
  {
    return switch (forbidden)
    {
      case Red:
        FlxRandom.chanceRoll(50) ? Blue : Green;
      case Blue:
        FlxRandom.chanceRoll(50) ? Red : Green;
      case Green:
        FlxRandom.chanceRoll(50) ? Red : Blue;
      case null:
        switch (FlxRandom.intRanged(1, 3))
        {
          case 1:
            Red;
          case 2:
            Blue;
          case 3:
            Green;
          default:
            throw "Impossible!";
        };
    };
  }
}
