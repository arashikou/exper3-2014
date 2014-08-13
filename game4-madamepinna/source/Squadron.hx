package;

import flixel.FlxG;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxRandom;

class Squadron extends FlxTypedGroup<Apparition>
{
  public function new(formationNumber:UInt, bulletGroup:Bullet.Group)
  {
    super();

    switch (formationNumber)
    {
      case 1:
        var primarySubject = Apparition.Random.subject();

        add(new Apparition(primarySubject, Apparition.Random.form(), bulletGroup));
        add(new Apparition(primarySubject, Apparition.Random.form(members[0].form), bulletGroup));
        add(new Apparition(Apparition.Random.subject(primarySubject),
                           Apparition.Random.form(), bulletGroup));

        FlxRandom.shuffleArray(members, members.length * 4);

        members[0].x = 100;
        members[0].y = 100;
        members[1].x = FlxG.width - 100 - members[1].width;
        members[1].y = 100;
        members[2].x = (FlxG.width - members[2].width) / 2;
        members[2].y = 200;
      case 2:
        var primarySubject = Apparition.Random.subject();
        var secondarySubject = Apparition.Random.subject(primarySubject);

        add(new Apparition(primarySubject, Apparition.Random.form(), bulletGroup));
        add(new Apparition(secondarySubject, Apparition.Random.form(), bulletGroup));
        add(new Apparition(primarySubject, Apparition.Random.form(members[0].form), bulletGroup));
        add(new Apparition(secondarySubject, Apparition.Random.form(members[1].form), bulletGroup));

        FlxRandom.shuffleArray(members, members.length * 4);

        members[0].x = 100;
        members[0].y = 100;
        members[1].x = FlxG.width - 100 - members[1].width;
        members[1].y = 100;
        members[2].x = 100;
        members[2].y = 200;
        members[3].x = FlxG.width - 100 - members[3].width;
        members[3].y = 200;
      case 3:
        var primarySubject = Apparition.Random.subject();
        var secondarySubject = Apparition.Random.subject(primarySubject);

        add(new Apparition(primarySubject, Apparition.Random.form(), bulletGroup));
        add(new Apparition(secondarySubject, Apparition.Random.form(), bulletGroup));
        add(new Apparition(primarySubject, Apparition.Random.form(members[0].form), bulletGroup));
        add(new Apparition(secondarySubject, Apparition.Random.form(members[1].form), bulletGroup));

        FlxRandom.shuffleArray(members, members.length * 4);

        var d = (FlxG.width - 200) / 4;
        members[0].x = 100;
        members[0].y = 120;
        members[1].x = 100 + d;
        members[1].y = 100;
        members[2].x = 100 + 2 * d;
        members[2].y = 100;
        members[3].x = 100 + 3 * d;
        members[3].y = 120;
      case 4:
        var primarySubject = Apparition.Random.subject();
        var secondarySubject = Apparition.Random.subject(primarySubject);

        add(new Apparition(primarySubject, Apparition.Random.form(), bulletGroup));
        add(new Apparition(primarySubject, Apparition.Random.form(members[0].form), bulletGroup));
        add(new Apparition(secondarySubject, Apparition.Random.form(), bulletGroup));
        add(new Apparition(secondarySubject, Apparition.Random.form(members[2].form), bulletGroup));
        add(new Apparition(Apparition.Random.subject(primarySubject),
                           Apparition.Random.form(), bulletGroup));

        FlxRandom.shuffleArray(members, members.length * 4);

        members[0].x = 100;
        members[0].y = 75;
        members[1].x = FlxG.width - 100 - members[1].width;
        members[1].y = 75;
        members[2].x = 100;
        members[2].y = 225;
        members[3].x = FlxG.width - 100 - members[3].width;
        members[3].y = 225;
        members[4].x = (FlxG.width - members[4].width) / 2;
        members[4].y = 150;
      default:
        throw "Unusable formation number!";
    }
  }

  public function isViable():Bool
  {
    for (firstIndex in 0...members.length)
    {
        var first = members[firstIndex];
        if (first.alive)
        {
            for (secondIndex in (firstIndex + 1)...members.length)
            {
                var second = members[secondIndex];
                if (second.alive && first.subject == second.subject && first.form != second.form)
                {
                    return true;
                }
            }
        }
    }
    return false;
  }
}
