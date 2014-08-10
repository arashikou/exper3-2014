package;

import flixel.FlxG;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxRandom;

class Squadron extends FlxTypedGroup<Apparition>
{
  public function new(size:UInt)
  {
    super();

    switch (size)
    {
      case 3:
        var primarySubject = Apparition.Random.subject();

        add(new Apparition(primarySubject, Apparition.Random.form()));
        add(new Apparition(primarySubject, Apparition.Random.form(members[0].form)));
        add(new Apparition(Apparition.Random.subject(primarySubject),
                           Apparition.Random.form()));

        FlxRandom.shuffleArray(members, members.length * 4);

        members[0].x = 100;
        members[0].y = 100;
        members[1].x = FlxG.width - 100 - members[1].width;
        members[1].y = 100;
        members[2].x = (FlxG.width - members[2].width) / 2;
        members[2].y = 200;
      case 4:
        var primarySubject = Apparition.Random.subject();
        var secondarySubject = Apparition.Random.subject(primarySubject);

        add(new Apparition(primarySubject, Apparition.Random.form()));
        add(new Apparition(secondarySubject, Apparition.Random.form()));
        add(new Apparition(primarySubject, Apparition.Random.form(members[0].form)));
        add(new Apparition(secondarySubject, Apparition.Random.form(members[1].form)));

        FlxRandom.shuffleArray(members, members.length * 4);

        members[0].x = 100;
        members[0].y = 100;
        members[1].x = FlxG.width - 100 - members[1].width;
        members[1].y = 100;
        members[2].x = 100;
        members[2].y = 200;
        members[3].x = FlxG.width - 100 - members[3].width;
        members[3].y = 200;
      default:
        throw "Unusable size!";
    }
  }
}
